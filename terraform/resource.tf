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
# ========== Random Password for RDS ==========

resource "random_password" "master"{
  length           = 16
  special          = true
  override_special = "_!%^"
}

# ========== RDS ==========

resource "aws_db_instance" "mysql_instance" {
    identifier                  = "mysql"
    allocated_storage           = 20
    engine                      = "mysql"
    engine_version              = "8.0.35"
    instance_class              = "db.t4g.micro"
    name                        = "rds_mysql_de_challenge"
    username                    = local.db_username
    password                    = random_password.master.result
    publicly_accessible         = "true"
    db_subnet_group_name        = aws_db_subnet_group.rds_public_subnet.name
    vpc_security_group_ids      = [aws_security_group.rds_sg.id]
    backup_retention_period     = 7
    multi_az                    = false
    skip_final_snapshot         = true
    tags = merge(local.common_tags, {"Name" = "rds-de-challenge"})
}