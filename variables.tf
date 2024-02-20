/**
 * Create by : Benja kuneepong
 * Date : Wed, Aug 30, 2023  4:57:13 PM
 * Purpose : ประกาศตัวแปลเริิ่มต้นเพื่อไปใช้ในไฟล์​ var ของแต่ละ environment
 */

variable "awsprofile" {}
variable "awsprofileid" {}
variable "aws_region" { default = "ap_southeast_1" }

variable "owner_name" {}
variable "service_name" {}
variable "system_name" {}
variable "project_name" {}
variable "sr_name" {}
variable "environment" {}
variable "create_by_name" {}

variable "vpc_id" {}
variable "subnet_app_b" {}
variable "subnet_app_c" {}
variable "subnet_nonexpose_b" {}
variable "subnet_nonexpose_c" {}
variable "subnet_secure_b" {}
variable "subnet_secure_c" {}

variable "ec2_instance_image" {}
variable "ec2_instance_type" {}

# variable "aurora_version" { default = "8.0.mysql_aurora.3.02.0" }
# variable "aurora_instance_type" { default = "db.t4g.medium" }
# variable "aurora_master_username" {}
# variable "aurora_master_password" {}
# variable "aurora_performance_insights_enabled" { default = "false" }
# variable "aurora_ca_cert" {}

# variable "certificate_arn" {}
# variable "ssl_policy" {}
