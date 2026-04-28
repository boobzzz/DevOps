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
