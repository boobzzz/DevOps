provider "aws" {
  region = "eu-central-1"
}

# Підключаємо S3 та DynamoDB
module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "yb-tf-state-bucket-0105"
  table_name  = "terraform-locks"
}

# Підключаємо VPC
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  vpc_name           = "final-project-vpc"
}

# Підключаємо ECR
module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "final-project-ecr"
  scan_on_push = true
}

# Підключаємо EKS
module "eks" {
  source       = "./modules/eks"
  cluster_name = "final-project-cluster"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
}

module "jenkins" {
  source = "./modules/jenkins"

  depends_on = [
    module.eks
  ]
}

module "argo_cd" {
  source = "./modules/argo_cd"

  depends_on = [module.eks]
}

module "monitoring" {
  source = "./modules/monitoring"

  depends_on = [
    module.eks
  ]
}

module "rds_database" {
  source = "./modules/rds"

  use_aurora     = false
  identifier     = "my-django-rds-db"
  engine         = "postgres"
  engine_version = "14.10"
  family         = "postgres14"
  instance_class = "db.t3.micro"
  multi_az       = true

  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnet_ids

  db_name        = "djangodb"
  username       = var.db_username
  password       = var.db_password
}


data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

# Налаштовуємо Helm провайдер
provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

# Налаштовуємо Kubernetes провайдер
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
