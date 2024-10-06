# ========== Random Password for RDS ==========
resource "random_password" "master" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

# ========== AWS Secrets Manager for RDS ==========
resource "aws_secretsmanager_secret" "rds_secret" {
  name        = local.secrets_name
  description = "Secrets for the RDS MySQL instance"
}

resource "aws_secretsmanager_secret_version" "rds_secret_value" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    db_name     = "rds_mysql_de_challenge"
    username    = local.db_username
    password    = random_password.master.result
  })

  # Ensure this runs after the secret is created
  depends_on = [
    aws_secretsmanager_secret.rds_secret
  ]
}