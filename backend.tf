terraform {
  backend "s3" {
    bucket         = "yb-tf-state-bucket-618384"
    key            = "lesson-5/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
