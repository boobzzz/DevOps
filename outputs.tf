output "s3_bucket_name" {
  value       = module.s3_backend.s3_bucket_id
  description = "The name of the S3 bucket used for state"
}

output "dynamodb_table_name" {
  value       = module.s3_backend.dynamodb_table_name
  description = "The name of the DynamoDB table used for state locking"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "The URL of the ECR repository"
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}
