variable "namespace" {
  description = "Namespace for Jenkins"
  type        = string
  default     = "jenkins"
}

variable "chart_version" {
  description = "Helm chart version for Jenkins"
  type        = string
  default     = "5.1.4"
}

variable "jenkins_admin_password" {
  description = "Admin password for Jenkins controller"
  type        = string
  sensitive   = true
}
