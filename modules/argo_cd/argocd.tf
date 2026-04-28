resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = var.namespace
  create_namespace = true
  version          = var.chart_version

  values = [
    file("${path.module}/values.yaml")
  ]
}

resource "helm_release" "argo_apps" {
  name       = "argo-apps"
  chart      = "${path.module}/charts"
  namespace  = var.namespace

  depends_on = [helm_release.argocd]
}
