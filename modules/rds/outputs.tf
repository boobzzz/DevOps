output "db_endpoint" {
  description = "Кінцева точка (endpoint) бази даних"
  value = var.use_aurora ? aws_rds_cluster.this[0].endpoint : aws_db_instance.this[0].endpoint
}

output "db_port" {
  description = "Порт бази даних"
  value       = var.use_aurora ? aws_rds_cluster.this[0].port : aws_db_instance.this[0].port
}

output "db_name" {
  description = "Назва бази даних"
  value       = var.use_aurora ? aws_rds_cluster.this[0].database_name : aws_db_instance.this[0].db_name
}
