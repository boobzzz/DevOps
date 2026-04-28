output "argocd_namespace" {
  description = "The namespace where Argo CD is installed"
  value       = var.namespace
}

output "argocd_initial_admin_password_command" {
  description = "Command to get the initial admin password for Argo CD UI"
  value       = "kubectl -n ${var.namespace} get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d ; echo"
}
