terraform {
  backend "s3" {
    bucket = "terraform-state-notejam"
    key    = "asg"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "common" {
  backend = "s3" 
  config {
    bucket = "terraform-state-notejam"
    key    = "common"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "static" {
  backend = "s3"
  config {
    bucket = "terraform-state-notejam"
    key    = "static"
    region = "eu-central-1"
  }
}
