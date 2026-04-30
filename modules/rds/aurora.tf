resource "aws_rds_cluster" "this" {
  count = var.use_aurora ? 1 : 0

  cluster_identifier      = var.identifier
  engine                  = var.engine
  engine_version          = var.engine_version

  database_name           = var.db_name
  master_username         = var.username
  master_password         = var.password
  port                    = var.db_port

  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.this.id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_pg[0].name

  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "writer" {
  count = var.use_aurora ? 1 : 0

  identifier              = "${var.identifier}-writer"
  cluster_identifier      = aws_rds_cluster.this[0].id
  engine                  = aws_rds_cluster.this[0].engine
  engine_version          = aws_rds_cluster.this[0].engine_version
  instance_class          = var.instance_class

  db_subnet_group_name    = aws_db_subnet_group.this.name
  db_parameter_group_name = aws_db_parameter_group.aurora_instance_pg[0].name
}
