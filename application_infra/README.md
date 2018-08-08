# Module Autoscaling_elb

This module provisions an Autoscaling Group and an Elastic Load Balancer .

## Input variables
This module takes multiple arguments .

### iam_role
Role to be assumed by the ec2 instances launched by the Autoscaling Group . Example :
```
iam_role = "role_ec2_s3"
```
### instance_type
Instance type for the ec2 instances launched by the Autoscaling Group . Example :
```
instance_type = "t2.micro"
```
### launch_ami
The ami Id used for the launch configuration . Example :
```
launch_ami = ami-c30c0dba
```
### user_data
A script to be executed at the ec2 instance launch . Example :
```
#!/bin/bash
yum update -y
yum install -y httpd
service httpd start
chkconfig httpd on
```
Or can be take a file as input .
```
user_data = "${file("./files/userdata.sh")}"
```
### elb_port
The port for the load balancer listener . Examples :
```
elb_port = 80
elb_port = 443
```
### elb_protocol
The protocol to listen on. Valid values are HTTP, HTTPS, TCP, or SSL . Example:
```
elb_protocol = "http"
```
### instance_port
The port on the instance to route to . Examples :
```
instance_port = 80
instance_port = 443
```
### instance_protocol
The protocol to use to the instance. Valid values are HTTP, HTTPS, TCP, or SSL . Example :
```
instance_protocol = "http"
```
### asg_max
The maximum size of the Autoscaling group .
```
asg_max = 4
```
### asg_min
The minimum size of the Autoscaling group .
```
asg_min = 2
```
### asg_capacity
The desired capacity of the Autoscaling group .
```
asg_capacity = 2
```
### tags
A list of tags to associate with the Autoscaling Groups .
```
autoscaling_instance_tags = [
{
key                 = "Name"
propagate_at_launch = true
value               = "asg-web"
},
{
key                 = "stage"
propagate_at_launch = true
value               = "dev"
}
]
```
