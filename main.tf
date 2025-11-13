terraform {
  required_providers {
    minio = {
      source = "terraform-provider-minio/minio"
      version = ">= 3.1.0"
    }
  }
}
provider "minio" {
  endpoint = "http://localhost:9000"
  minio_access_key = "minioadmin"
  minio_secret_key = "minioadmin"
}
resource "minio_s3_bucket" "tp1_bucket" {
  bucket = "tp1-cloud-bucket"
  acl = "private"
}