resource "aws_db_instance" "mssql" {
  identifier              = "${var.identifier}"
  vpc_security_group_ids  = ["${aws_security_group.rds-sg.id}"]
  engine                  = "${var.db_engine}"
  multi_az                = "${var.multi_az}"
  instance_class          = "${var.db_instance_class}"
  allocated_storage       = "${var.allocated_storage}"
  db_subnet_group_name    = "${aws_db_subnet_group.rds_sub_group.name}"
  username                = "${var.db_user}"
  password                = "${var.db_password}"
  port                    = "${var.db_port}"
  kms_key_id              = "${var.kms_key}"
  backup_retention_period = "${var.backup_retention_period}"
  storage_encrypted       = true
  skip_final_snapshot     = true
  license_model           = "license-included"

  tags = "${var.tags}"
}

resource "aws_db_subnet_group" "rds_sub_group" {
  name       = "main"
  subnet_ids = ["${data.aws_subnet_ids.local.ids}"]

  tags {
    Name = "DB subnet group"
  }
}

resource "aws_security_group" "rds-sg" {
  name   = "rds-sg-web"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port       = "${var.db_port}"
    protocol        = "tcp"
    to_port         = "${var.db_port}"
    security_groups = ["${aws_security_group.sg-private.id}"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "rds-sg-web"
  }
}
