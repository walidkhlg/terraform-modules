# Module Serverless
This module provisions lambda functions along with Api gateway .
## Input variables
This module takes multiple arguments .
### lambda_runtime
The lambda function runtime . Example :
```
lambda_runtime = "python3.6"
lambda_runtime = "nodejs4.3"
```
### subnet_ids
A list of subnet ids where the lambda can be invoked .
```
subnet_ids = ["subnet-dcee85d6","subnet-7bfa4543"]
```
### security_groups
A list of security groups to attach for the lambda function . Example :
```
security_groups = ["sg-29e1f854","sg-61e8d083"]
```
### lambda_zip_file_name
The name of the lambda function package , has to be placed in the files folder . Example :
```
lambda_zip_file_name  = "lambda_package.zip"
```
### env_var
A map of environment variables for the lambda function . Example :
```
env_var = {
  "Name"   = "Lambda_Name"
  "Stage"  = "dev"
  "Owner"  = "OwnerName"
}
```
### deployment_stage
The name of the stage . Example :
```
deployment_stage = "dev"
```
### rest_api_name
The name of the rest api . Example :
```
rest_api_name = "my_api_name"
```
### aws_region
The aws region where the lambda will be deployed . Example :
```
aws_region = "eu-west-1"
```
