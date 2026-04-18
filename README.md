# Lesson 7: Робота з AWS EKS, ECR, Terraform та Helm

Цей проєкт демонструє повний цикл розгортання веб-застосунку (Django) у хмарі AWS. Інфраструктура автоматизовано створюється за допомогою **Terraform**, а застосунок розгортається у кластері Kubernetes за допомогою **Helm**.

## 🏗 Архітектура проєкту

Проєкт складається з двох основних частин:

1. **Інфраструктура (Terraform):**
   * **S3 Backend & DynamoDB:** Зберігання файлу стану (`terraform.tfstate`) та блокування одночасних змін.
   * **VPC:** Мережа з 3 публічними та 3 приватними підмережами, IGW та NAT Gateway. Публічні підмережі мають тег `"kubernetes.io/role/elb" = "1"` для коректної роботи AWS Load Balancer.
   * **ECR:** Приватний репозиторій для зберігання Docker-образів.
   * **EKS:** Кластер Kubernetes (Control Plane) та Node Group (на базі інстансів `t3.medium`) у приватних підмережах.

2. **Застосунок (Helm):**
   * **Deployment:** Розгортання Docker-образу Django з ECR.
   * **Service:** Тип `LoadBalancer` для публічного доступу до застосунку через інтернет.
   * **ConfigMap:** Зберігання змінних середовища (env) та безпечна їх передача у поди.
   * **HPA (Horizontal Pod Autoscaler):** Автоматичне масштабування від 2 до 6 подів при перевищенні навантаження на CPU ( > 70%).

## 📁 Структура директорій

```text
lesson-7/
│
├── main.tf                  # Головний файл для підключення модулів
├── backend.tf               # Налаштування бекенду (S3 + DynamoDB)
├── outputs.tf               # Загальні виводи ресурсів
├── README.md                # Документація проєкту
│
├── modules/                 # Terraform модулі
│   ├── s3-backend/          # Модуль S3 та DynamoDB
│   ├── vpc/                 # Модуль мережі (VPC, Subnets, Gateways)
│   ├── ecr/                 # Модуль репозиторію ECR
│   └── eks/                 # Модуль кластера Kubernetes
│
└── charts/
    └── django-app/          # Helm-чарт для застосунку
        ├── Chart.yaml       # Метадані чарта
        ├── values.yaml      # Змінні для конфігурації чарта
        └── templates/       # Шаблони Kubernetes (deployment, service, hpa, configmap)
