output "s3_bucket_name" {
  value       = aws_s3_bucket.terraform_state.id
  description = "Il nome del bucket da usare nel backend di ogni environment"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "Il nome della tabella da usare nel backend di ogni environment"
}