resource "kubernetes_deployment" "app" {
  metadata {
    name = "devops-app"
    labels = {
      app = "devops"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "devops"
      }
    }

    template {
      metadata {
        labels = {
          app = "devops"
        }
      }

      spec {
        container {
          name  = "devops-container"
          image = "omprakash13890/devops:1"

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = "devops-service"
  }

  spec {
    selector = {
      app = "devops"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "NodePort"
  }
}
