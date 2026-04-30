resource "aws_db_subnet_group" "this" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.identifier}-subnet-group"
  }
}

resource "aws_security_group" "this" {
  name        = "${var.identifier}-db-sg"
  description = "Security group for ${var.identifier} DB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Name = "${var.identifier}-db-sg"
  }
}


# Створюється якщо use_aurora = false
resource "aws_db_parameter_group" "rds_pg" {
  count  = var.use_aurora ? 0 : 1
  name   = "${var.identifier}-rds-pg"
  family = var.family

  parameter {
    name  = "max_connections"
    value = "100"
  }
  parameter {
    name  = "log_statement"
    value = "all"
  }
  parameter {
    name  = "work_mem"
    value = "4096"
  }
}

# Створюється якщо use_aurora = true
resource "aws_rds_cluster_parameter_group" "aurora_cluster_pg" {
  count  = var.use_aurora ? 1 : 0
  name   = "${var.identifier}-aurora-cluster-pg"
  family = var.family

  parameter {
    name  = "max_connections"
    value = "100"
  }
  parameter {
    name  = "log_statement"
    value = "all"
  }
  parameter {
    name  = "work_mem"
    value = "4096"
  }
}

resource "aws_db_parameter_group" "aurora_instance_pg" {
  count  = var.use_aurora ? 1 : 0
  name   = "${var.identifier}-aurora-instance-pg"
  family = var.family
}
