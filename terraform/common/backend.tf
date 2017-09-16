terraform {
  backend "s3" {
    bucket = "terraform-state-notejam"
    key    = "common"
    region = "eu-central-1"
  }
}
