# Il Bucket S3 per salvare il file tfstate di ciascun ambiente
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.project_name}-tf-state"

  lifecycle {
    prevent_destroy = true # ricordarsi di commentare per terraform destroy
  }

  tags = {
    Name = "Terraform State Store"
  }
}

# Abilita il versioning
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Regole di lifecycle per eliminare tutte le versioni non attuali più vecchie di 3 giorni
resource "aws_s3_bucket_lifecycle_configuration" "state_cleanup" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    id     = "cleanup_old_versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 3
    }
  }
}

# Crittografia lato server
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Blocco accesso pubblico al bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Tabella DynamoDB per state locking 
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${var.project_name}-tf-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform State Lock Table"
  }
}
