############# launch config ######
# instance profile

resource "aws_iam_instance_profile" "web_s3_profile" {
  name = "web_s3_profile"
  role = "${var.iam_role}"
}

#####launch configuration
resource "aws_launch_configuration" "web-lc" {
  name_prefix          = "web-lc-"
  image_id             = "${var.launch_ami}"
  instance_type        = "${var.instance_type}"
  security_groups      = ["${aws_security_group.sg-private.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.web_s3_profile.id}"
  user_data            = "${data.template_file.userdata.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}
data "template_file" "userdata" {
  template = "${file("./files/${var.userdatafile}")}"

  vars {
    bucket_name = "${var.bucket_name}"
    dbhost      = "${var.dbhost}"
    dbuser      = "${var.db_user}"
    dbpass      = "${var.db_password}"
    dbname      = "${var.db_name}"
    dbreadname  = "${var.dbreadname}"
    cloudfront  = "${var.cloudfront}"
  }
}

################### Autoscaling Group###############

resource "aws_autoscaling_group" "web-asg" {
  max_size                  = "${var.asg_max}"
  min_size                  = "${var.asg_min}"
  desired_capacity          = "${var.asg_capacity}"
  health_check_grace_period = "${var.asg_grace}"
  health_check_type         = "ELB"
  load_balancers            = ["${aws_elb.web-elb.id}"]
  vpc_zone_identifier       = ["${data.aws_subnet_ids.private.ids}"]
  launch_configuration      = "${aws_launch_configuration.web-lc.name}"

  tags = "${var.tags}"
}

####### Security Groups ####################

resource "aws_security_group" "sg-elb" {
  name   = "allow_web"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = "${var.elb_port}"
    protocol    = "tcp"
    to_port     = "${var.elb_port}"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "sg-elb"
  }
}

resource "aws_security_group" "sg-private" {
  name   = "security_group_private"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port       = "${var.instance_port}"
    protocol        = "tcp"
    to_port         = "${var.instance_port}"
    security_groups = ["${aws_security_group.sg-elb.id}"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "sg_private"
  }
}

##################### scale policy ##############
resource "aws_autoscaling_policy" "cpu-policy" {
  name                   = "cpu-policy"
  autoscaling_group_name = "${aws_autoscaling_group.web-asg.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu-alarm" {
  alarm_name          = "cpu-alarm"
  alarm_description   = "cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.web-asg.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.cpu-policy.arn}"]
}

# scale down alarm
resource "aws_autoscaling_policy" "cpu-policy-scaledown" {
  name                   = "cpu-policy-scaledown"
  autoscaling_group_name = "${aws_autoscaling_group.web-asg.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu-alarm-scaledown" {
  alarm_name          = "cpu-alarm-scaledown"
  alarm_description   = "cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.web-asg.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.cpu-policy-scaledown.arn}"]
}

################ elb #############

resource "aws_elb" "web-elb" {
  name            = "web-elb"
  subnets         = ["subnet-dceb0f86", "subnet-1c71ab7a"]
  security_groups = ["${aws_security_group.sg-elb.id}"]
  internal        = true

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "${var.instance_protocol}"
    lb_port           = "${var.elb_port}"
    lb_protocol       = "${var.elb_protocol}"
  }

  health_check {
    healthy_threshold   = "2"
    interval            = "30"
    target              = "TCP:80"
    timeout             = "3"
    unhealthy_threshold = "2"
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "web-elb"
  }
}
