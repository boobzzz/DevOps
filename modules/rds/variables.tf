variable "use_aurora" {
  description = "Встановіть true для створення Aurora Cluster, або false для звичайного RDS"
  type        = bool
  default     = false
}

variable "identifier" {
  description = "Назва бази даних (ідентифікатор ресурсу)"
  type        = string
}

variable "engine" {
  description = "Тип бази даних (postgres, aurora-postgresql, mysql)"
  type        = string
}

variable "engine_version" {
  description = "Версія рушія бази даних"
  type        = string
}

variable "family" {
  description = "Сімейство Parameter Group (postgres14, aurora-postgresql14)"
  type        = string
}

variable "instance_class" {
  description = "Клас інстансу бази даних"
  type        = string
}

variable "multi_az" {
  description = "Увімкнути Multi-AZ"
  type        = bool
  default     = false
}


variable "db_name" {
  description = "Початкова назва бази даних"
  type        = string
}

variable "username" {
  description = "Головний користувач БД"
  type        = string
}

variable "password" {
  description = "Пароль користувача БД"
  type        = string
  sensitive   = true
}

variable "allocated_storage" {
  description = "Виділене місце в ГБ"
  type        = number
  default     = 20
}

variable "vpc_id" {
  description = "ID вашого VPC для Security Group"
  type        = string
}

variable "subnet_ids" {
  description = "Список Subnet IDs для DB Subnet Group"
  type        = list(string)
}

variable "db_port" {
  description = "Порт для підключення до БД (5432 для Postgres, 3306 для MySQL)"
  type        = number
  default     = 5432
}
