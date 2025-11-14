terraform {
  required_providers {
    minio = {
      source  = "terraform-provider-minio/minio"
      version = ">= 3.1.0"
    }
  }
}

provider "minio" {
  minio_server   = var.minio_server
  minio_user     = var.minio_user
  minio_password = var.minio_password
  minio_ssl      = false
}

resource "minio_s3_bucket" "web_bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "minio_s3_object" "index_html" {
  bucket = minio_s3_bucket.web_bucket.bucket
  object = "index.html"
  source = "index.html"
  acl    = "public-read"
}

resource "minio_s3_object" "style_css" {
  bucket = minio_s3_bucket.web_bucket.bucket
  object = "style.css"
  source = "style.css"
  acl    = "public-read"
}
