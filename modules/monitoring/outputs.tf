output "grafana_namespace" {
  value       = kubernetes_namespace_v1.monitoring.metadata[0].name
  description = "Namespace where Grafana is installed"
}