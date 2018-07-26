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
user_data = "${file("./files/userdata.web")}"
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
