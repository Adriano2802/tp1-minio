provider "minio" {
  minio_server = "127.0.0.1:9000"
  minio_user = "minioadmin"
  minio_password = "minioadmin"
}
resource "minio_s3_bucket" "web_bucket" {
  bucket = "webbucket"
  acl = "public-read"
}
resource "minio_s3_object" "index_html" {
  bucket = minio_s3_bucket.web_bucket.bucket
  object = "index.html"
  source = "index.html"
  acl = "public-read"
}
resource "minio_s3_object" "style_css" {
  bucket = minio_s3_bucket.web_bucket.bucket
  object = "style.css"
  source = "style.css"
  acl = "public-read"
}
