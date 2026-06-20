resource "aws_db_subnet_group" "catalog" {
  name       = "bedrock-catalog"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "catalog_rds" {
  name        = "bedrock-catalog-rds"
  description = "Security group for catalog RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = var.allowed_security_group_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "random_string" "catalog_db_master" {
  length  = 10
  special = false
}

resource "aws_db_instance" "catalog" {
  identifier              = "bedrock-catalog"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  db_name                 = "catalog"
  username                = "root"
  password                = random_string.catalog_db_master.result
  db_subnet_group_name    = aws_db_subnet_group.catalog.name
  vpc_security_group_ids  = [aws_security_group.catalog_rds.id]
  storage_encrypted       = false
  skip_final_snapshot     = true
  backup_retention_period = 0
  apply_immediately       = true
  tags                    = var.tags
}
