resource "kubernetes_namespace_v1" "jenkins" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = kubernetes_namespace_v1.jenkins.metadata[0].name
#   version    = var.chart_version

  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [kubernetes_namespace_v1.jenkins]
}

resource "kubernetes_secret" "kaniko_secret" {
  metadata {
    name      = "kaniko-secret"
    namespace = kubernetes_namespace_v1.jenkins.metadata[0].name
  }

  data = {
    "config.json" = jsonencode({
      "credsStore" : "ecr-login"
    })
  }

  depends_on = [kubernetes_namespace_v1.jenkins]
}
