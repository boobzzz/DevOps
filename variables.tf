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

variable "jenkins_admin_password" {
  description = "Password for the Jenkins admin user"
  type        = string
  sensitive   = true
}
