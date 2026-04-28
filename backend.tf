terraform {
  backend "s3" {
    bucket         = "yb-tf-state-bucket-2704"
    key            = "lesson-5/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
