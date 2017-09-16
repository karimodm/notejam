terraform {
  backend "s3" {
    bucket = "terraform-state-notejam"
    key    = "static"
    region = "eu-central-1"
  }
}
