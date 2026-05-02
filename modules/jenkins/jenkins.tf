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
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]

  set_sensitive {
    name  = "controller.adminPassword"
    value = var.jenkins_admin_password
  }

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
