terraform {
  backend "s3" {
    bucket = "terraform-state-notejam"
    key    = "prod-common"
    region = "eu-central-1"
  }
}
