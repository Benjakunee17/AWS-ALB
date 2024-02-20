
# /**
#  * Create By : Sarun Thepnamwong
#  * Date : Fri Aug 11 10:00:00 +07 2023
#  * Purpose : ประกาศว่าใช้ terraform version อะไรสำหรับ provider
#  */
 terraform {
   required_providers {
     aws = {
       source  = "hashicorp/aws"
       version = "4.67.0"
     }
   }
 }
/**
 * Create By : Sarun Thepnamwong
 * Date : Fri Aug 11 10:00:00 +07 2023
 * Purpose : สร้าง bucket สำหรับเก็บ state ของ terraform
 */
# terraform {
#   backend "s3" {
#     bucket  = "rms-mop-dev-terraform-state-bucket"
#     key     = "terraform/dev/terraform.tfstate"
#     region  = "ap-southeast-1"
#     acl     = "bucket-owner-full-control"
#     encrypt = true
#     profile = "awscpadev"
#   }
# }
/**
 * Create By : Sarun Thepnamwong
 * Date : Fri Aug 11 10:00:00 +07 2023
 * Purpose : กำหนด provider information
 */
provider "aws" {
  profile  = var.awsprofile
  region   = var.aws_region
  insecure = true
  default_tags {
    tags = {
      Owner   = var.owner_name
      Service = var.service_name
      System  = var.system_name
      Project = var.project_name
      # SR          = var.sr_name
      Environment = "${var.environment}"
      Createby    = var.create_by_name
    }
  }
}