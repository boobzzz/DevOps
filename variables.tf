variable "db_username" {
  description = "Username for RDS"
  type        = string
  default     = "dbadmin"
}

variable "db_password" {
  description = "Password for RDS"
  type        = string
  sensitive   = true
}
