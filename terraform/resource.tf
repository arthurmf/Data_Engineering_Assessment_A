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

# ========== RDS ==========

resource "aws_db_instance" "mysql_instance" {
    identifier                  = "mysql"
    allocated_storage           = 20
    engine                      = "mysql"
    engine_version              = "8.0.35"
    instance_class              = "db.t4g.micro"
    name                        = jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["db_name"]
    username                    = jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["username"]
    password                    = jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["password"]
    publicly_accessible         = "true"
    db_subnet_group_name        = aws_db_subnet_group.rds_public_subnet.name
    vpc_security_group_ids      = [aws_security_group.rds_sg.id]
    backup_retention_period     = 7
    multi_az                    = false
    skip_final_snapshot         = true
    tags = merge(local.common_tags, {"Name" = "rds-de-challenge"})

    # Ensure RDS is created only after the secret is available
    depends_on = [
        aws_secretsmanager_secret_version.rds_secret_value
    ]
}