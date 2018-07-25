resource "aws_vpc" "pattern1" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "pattern_vpc"
  }
}

#IGW
resource "aws_internet_gateway" "pattern1" {
  vpc_id = "${aws_vpc.pattern1.id}"

  tags {
    Name = "pattern_igw"
  }
}

# Subnets

resource "aws_subnet" "public1_subnet" {
  cidr_block              = "${var.cidrs["public1"]}"
  vpc_id                  = "${aws_vpc.pattern1.id}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "public1"
  }
}

resource "aws_subnet" "public2_subnet" {
  cidr_block              = "${var.cidrs["public2"]}"
  vpc_id                  = "${aws_vpc.pattern1.id}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "public2"
  }
}



# private subnets
resource "aws_subnet" "rds1_subnet" {
  cidr_block              = "${var.cidrs["rds1"]}"
  vpc_id                  = "${aws_vpc.pattern1.id}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "rds1"
  }
}

resource "aws_subnet" "rds2_subnet" {
  cidr_block              = "${var.cidrs["rds2"]}"
  vpc_id                  = "${aws_vpc.pattern1.id}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "rds2"
  }
}

#Route Tables

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.pattern1.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.pattern1.id}"
  }

  tags {
    Name = "public_rt"
  }
}

resource "aws_default_route_table" "private_rt" {
  default_route_table_id = "${aws_vpc.pattern1.default_route_table_id}"

  tags {
    Name = "private_rt"
  }
}

####### subnet associations ##########

resource "aws_route_table_association" "web-public-assoc1" {
  route_table_id = "${aws_route_table.public_rt.id}"
  subnet_id      = "${aws_subnet.public1_subnet.id}"
}

resource "aws_route_table_association" "web-public-assoc2" {
  route_table_id = "${aws_route_table.public_rt.id}"
  subnet_id      = "${aws_subnet.public2_subnet.id}"
}
