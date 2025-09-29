# s3 bucket for terraform backend
resource "aws_s3_bucket" "mybackend" {
  bucket = "coolprod25-${lower(var.env)}-${random_integer.mybackend.result}"

  tags = {
    Name        = "backend"
    Environment = var.env
  }
}

# kms key for bucket encryption
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.mybackend.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}


# random integer for bucket naming convention
resource "random_integer" "mybackend" {
  min = 1
  max = 100
  keepers = {
    env = var.env
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.mybackend.id
  versioning_configuration {
    status = var.versioning
  }
}
