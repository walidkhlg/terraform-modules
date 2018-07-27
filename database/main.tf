############# RDS ##############

resource "aws_rds_cluster" "db-cluster" {
  cluster_identifier     = "pattern-db"
  database_name          = "${var.db_name}"
  master_username        = "${var.db_user}"
  master_password        = "${var.db_password}"
  db_subnet_group_name   = "${aws_db_subnet_group.rds_subnetgroup.name}"
  skip_final_snapshot    = true
  vpc_security_group_ids = ["${aws_security_group.rds-sg.id}"]
  storage_encrypted      = true
  kms_key_id             = "${var.kms_key_id}"
}

resource "aws_rds_cluster_instance" "cluster-instance1" {
  identifier_prefix  = "aurora-cluster-db-instance"
  instance_class     = "${var.db_instance_class}"
  cluster_identifier = "${aws_rds_cluster.db-cluster.id}"

  tags = "${var.db_instance_tags}"
}

resource "aws_rds_cluster_instance" "cluster-instance2" {
  identifier_prefix  = "aurora-cluster-db-instance"
  instance_class     = "${var.db_instance_class}"
  cluster_identifier = "${aws_rds_cluster.db-cluster.id}"

  tags = "${var.db_instance_tags}"
}

resource "aws_rds_cluster_instance" "cluster-instance3" {
  identifier_prefix  = "aurora-cluster-db-instance"
  instance_class     = "${var.db_instance_class}"
  cluster_identifier = "${aws_rds_cluster.db-cluster.id}"

  tags = "${var.db_instance_tags}"
}

# subnet group for rds
resource "aws_db_subnet_group" "rds_subnetgroup" {
  name_prefix = "rds_subnet_group"
  subnet_ids  = ["${data.aws_subnet_ids.local.ids}"]

  tags {
    Name = "rds-subnet-group"
  }
}

# security group
resource "aws_security_group" "rds-sg" {
  name   = "rds-sg"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
    security_groups = "${var.security_group_ids}"
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "rds-security-group"
  }
}
