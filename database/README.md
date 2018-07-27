# Module database

This module provisions an Autoscaling Group and an Elastic Load Balancer .

## Input variables
This module takes multiple arguments .

### security_group_ids
A list of security groups allowed to reach the cluster . Example :
```
security_groups_ids = ["sg-14e27a1e","sg-34f91948"]
```
### db_instance_class
The class of the db_instance size . Example:
```
db_instance_class = "db.t2.medium"
```
### db_engine
The engine to use for the database cluster . Example :
```
db_engine = "aurora-mysql"
```
### kms_key_id
The ARN of the Kms key to use to encrypt the cluster . Example :
```
kms_key_id = "arn:aws:kms:eu-west-1:8547342598703:key/e53256c0-x68a-43245-8412-c2366e565201"
```
### db_name
The name of the database .
```
db_name = "test_database"
```
### db_user
The database master username
```
db_user = "master"
```
### db_password
The database password
###
