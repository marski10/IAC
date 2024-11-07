resource "aws_s3_bucket" "main" {
  bucket = "bucket-videos-lab"
  tags = {
    Name        = "bucket-videos-lab"
    Environment = "Dev"
  }
}
