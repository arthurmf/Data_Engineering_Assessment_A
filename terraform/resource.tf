# ========== S3 Bucket ==========
resource "aws_s3_bucket" "de_challenge_bucket" {
    bucket = local.bucket_name

    # Tags for the bucket
    tags = merge(local.common_tags, {"Name" = local.bucket_name})
}

# ========== S3 Bucket Server-Side Encryption Configuration ==========
resource "aws_s3_bucket_server_side_encryption_configuration" "de_challenge_bucket_sse" {
    bucket = aws_s3_bucket.de_challenge_bucket.bucket

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

# ========== S3 Bucket Object ==========
resource "aws_s3_bucket_object" "bucket_key" {
    bucket = aws_s3_bucket.de_challenge_bucket.id
    key    = "data-source/"
}
