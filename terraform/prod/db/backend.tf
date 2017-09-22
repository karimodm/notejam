terraform {
  backend "s3" {
    bucket = "terraform-state-notejam"
    key    = "prod-db"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "common" {
  backend = "s3" 
  config {
    bucket = "terraform-state-notejam"
    key    = "prod-common"
    region = "eu-central-1"
  }
}
