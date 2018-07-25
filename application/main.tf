data "template_file" "userdata" {
  template = "${file("./files/userdata.web")}"

  vars {
    bucket_name = "${aws_s3_bucket.app_bucket.id}"
    dbhost      = "${var.dbhost}"
    dbuser      = "${var.db_user}"
    dbpass      = "${var.db_password}"
    dbname      = "${var.db_name}"
    dbreadname  = "${var.dbread}"
    logs_bucket = "${aws_s3_bucket.logs_bucket.id}"
  }
}

#################### s3  bucket for logs #######################
resource "aws_s3_bucket" "logs_bucket" {
  bucket_prefix = "web-ec2-logs-"
  acl           = "private"
  server_side_encryption_configuration {
  rule {
  apply_server_side_encryption_by_default {
    kms_master_key_id = "${var.kms_key_id}"
    sse_algorithm = "aws:kms"
      }
    }
  }
  tags {
    Name = "Instance_log_bucket"
  }
}

data "template_file" "rendered_log_script" {
  template = "${file("./files/log.sh")}"
  vars {
    logs_bucket = "${aws_s3_bucket.logs_bucket.id}"
  }
}

resource "aws_s3_bucket_object" "logs_script" {
  bucket  = "${aws_s3_bucket.logs_bucket.id}"
  key     = "log.sh"
  source = "${data.template_file.rendered_log_script.rendered}"
  kms_key_id = "${var.kms_key_id}"
  tags {
    Name = "logging_script"
  }
}
#### s3 bucket for application code ####
resource "aws_s3_bucket" "app_bucket" {
  bucket_prefix = "webapp-"
  acl           = "private"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${var.kms_key_id}"
        sse_algorithm = "aws:kms"
        }
      }
    }
    tags {
      Name = "Application code bucket"
    }
  }



resource "aws_s3_bucket_object" "app_package" {
  bucket  = "${aws_s3_bucket.app_bucket.id}"
  key     = "App.zip"
  source = "./files/App.zip"
  kms_key_id = "${var.kms_key_id}"
  tags {
    Name = "Application package"
  }
}
