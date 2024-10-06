output "rds_endpoint" {
  value = aws_db_instance.mysql_instance.endpoint
}

output "rds_secret_arn" {
  description = "The ARN of the RDS Secrets Manager secret"
  value       = aws_secretsmanager_secret.rds_secret.arn
}