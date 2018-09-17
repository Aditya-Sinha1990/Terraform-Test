# Terraform-Test
>Test Terraform|Resource Created| VPC,Subnets,SecurityGroup,ELB,EC2,S3,RDS-AZ-a and b


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access_key | Access Key value received from IAM of AWS Account that runs the code | string | `` | no |
| azs | A list of availability zones in the region | string | `<list>` | no |
| cidr | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden | string | `0.0.0.0/0` | no |
| enable_nat_gateway | Should be true if you want to provision NAT Gateways for each of your private networks | string | `false` | no |
| keyname | Should be true if you want to provision a single shared NAT Gateway across all of your private networks | string | `aws368` | no |
| name | Name to be used on all the resources as identifier | string | `` | no |
| private_subnets | A list of private subnets inside the VPC | string | `<list>` | no |
| public_subnet_tags | Additional tags for the public subnets | string | `<map>` | no |
| public_subnets | A list of public subnets inside the VPC | string | `<list>` | no |
| region | Region of AWS Account where we run the code | string | `ap-southeast-2` | no |
| secret_key | Secret Key value received from IAM of AWS Account that runs the code | string | `` | no |
| single_nat_gateway | Should be true if you want to provision a single shared NAT Gateway across all of your private networks | string | `false` | no |

## Used Links
This `code` was built through help of [Terraform Pages](https://www.terraform.io/docs/providers/aws/index.html)
**These docs are generated by using _binaries of terraform-docs_**
[Terraform-Docs](https://github.com/segmentio/terraform-docs/releases)
   - *Commands To Generate Docs*
   - ```
     terraform-docs md ../path/to/.tf_files
     ```
   

## Prequisites
> **Need AWS Account with correct _IAM User_ Account to Run IaaC**

> **Create S3 Bucket to store state files of terraform**

> **Create Dyanmo DB Table and write \*LOCKID\* as a _Partion Key_ while creating Table**

> **Initialize Backend in Terraform main Script and give details of Dynamo DB like - Table name and S3 bucket Name**

> **Basically Terraform State-Files are placed in Dynamo Database of AWS (anyformat of docs saved)format and stored in S3 Bucket**


1. ```Terraform _Init_```
   - ```Terraform *Validate*```
     - ```Terraform *Plan*```
2. ```Terraform *Apply*```
3. ```Terraform *Destroy*```

         
