terraform {
  backend "s3" {
    bucket = "project-bedrock-tfstate-alt-soe-025-4763"
    key    = "project-bedrock/terraform.tfstate"
    region = "us-east-1"
  }
}
