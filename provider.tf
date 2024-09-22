# Provider Block
provider "aws" {
  alias               = "us_east"
  profile             = var.aws_profile
  region              = var.aws_east_region
  allowed_account_ids = [var.aws_account_id]
}

provider "aws" {
  alias               = "us_west"
  profile             = var.aws_profile
  region              = var.us_west_region
  allowed_account_ids = [var.aws_account_id]
}
