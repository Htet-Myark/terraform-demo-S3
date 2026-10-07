provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "nextwork-unique-bucket-htetmyark-001" # Make sure this bucket name is globally unique by typing a long random number
}

resource "aws_s3_bucket_public_access_block" "my_bucket_public_access_block" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.my_bucket.id
  key          = "index.html"
  source       = "website/index.html"
  content_type = "text/html"
  etag         = filemd5("website/index.html")
}

resource "aws_s3_object" "style_css" {
  bucket       = aws_s3_bucket.my_bucket.id
  key          = "style.css"
  source       = "website/style.css"
  content_type = "text/css"
  etag         = filemd5("website/style.css")
}