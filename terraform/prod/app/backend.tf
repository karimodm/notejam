terraform {
  backend "s3" {
    bucket = "terraform-state-notejam"
    key    = "stage-app"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "common" {
  backend = "s3" 
  config {
    bucket = "terraform-state-notejam"
    key    = "stage-common"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "db" {
  backend = "s3" 
  config {
    bucket = "terraform-state-notejam"
    key    = "stage-db"
    region = "eu-central-1"
  }
}
