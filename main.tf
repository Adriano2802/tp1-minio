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

# Bucket privé
resource "minio_s3_bucket" "web_bucket" {
  bucket_name = var.bucket_name
}

# index.html - public
resource "minio_s3_object" "index_html" {
  bucket_name = minio_s3_bucket.web_bucket.bucket_name
  object_name = "index.html"
  content_file = "index.html"

  # Nouvelle syntaxe ACL
  object_acl = "public-read"
}

# style.css - public
resource "minio_s3_object" "style_css" {
  bucket_name = minio_s3_bucket.web_bucket.bucket_name
  object_name = "style.css"
  content_file = "style.css"

  object_acl = "public-read"
}
