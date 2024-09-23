variable "aws_profile" {
  type    = string
  default = "tf-user"
}
variable "aws_east_region" {
  description = "AWS region for the us-east VPC"
  type        = string
  default     = "us-east-2"
}

variable "us_west_region" {
  description = "AWS region for the us-west VPC"
  type        = string
  default     = "us-west-2"
}

variable "aws_account_id" {
  type    = string
  default = "038420655728"
}
#----------------------------------------------------------------------
variable "vpc_cidr" {
  type    = string
  default = "10.200.0.0/16"
}
variable "public_subnets" {
  type    = list(string)
  default = ["10.200.1.0/24", "10.200.2.0/24", "10.200.3.0/24"]
}
variable "private_subnets" {
  type    = list(string)
  default = ["10.200.11.0/24", "10.200.12.0/24", "10.200.13.0/24"]
}
#------------------------------------------------------------------------
variable "key_spec" {
  type    = string
  default = "SYMMETRIC_DEFAULT"
}
variable "kms_enabled" {
  type    = bool
  default = true
}
variable "kms_rotation" {
  type    = bool
  default = true
}
variable "kms_deletion_window" {
  type    = number
  default = 7
}
variable "kms_alias_name" {
  type    = string
  default = "alias/cia_lab_kms"
}

#------------------------------------------------------------------------
variable "algorithm" {
  type    = string
  default = "RSA"
}
variable "rsa_bits" {
  type    = number
  default = 4096
}
variable "key_pair_name_1" {
  type    = string
  default = "edrs_primary"
}
variable "key_pair_name_2" {
  type    = string
  default = "edrs_dr"
}
variable "instance_type" {
  type    = string
  default = "t2.small"
}
variable "root_vol_type" {
  type    = string
  default = "gp3"
}
variable "root_vol_size" {
  type    = number
  default = 10
}
variable "data_vol_type" {
  type    = string
  default = "gp3"
}
variable "data_vol_size" {
  type    = number
  default = 5
}
variable "USER_DATA" {
  type    = string
  default = "USER_DATA.sh"
}
variable "ec2_ports" {
  type = map(any)
  default = {
    "22" = {
      description = "SSH"
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      //security_groups = []
    }
    "80" = {
      description = "HTTP"
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      //security_groups = []
    }
    "443" = {
      description = "HTTPS"
      port        = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      //security_groups = []
    }
  }
}
