terraform {
  backend "s3" {
    bucket       = "terraform-cicd-pipeline-pass-statefile"
    key          = "eks/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

