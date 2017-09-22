terraform {
  backend "s3" {
    bucket = "terraform-state-notejam"
    key    = "stage-common"
    region = "eu-central-1"
  }
}
