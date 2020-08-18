terraform {
  backend "s3" {
    bucket = "cb-demo-state"
    key    = "state/eks-cb-demo"
    region = "us-east-2"
  }
}