resource "aws_db_subnet_group" "orders" {
  name       = "bedrock-orders"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "orders_rds" {
  name        = "bedrock-orders-rds"
  description = "Security group for orders RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = ["sg-091d049131a4da734"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "random_string" "orders_db_master" {
  length  = 10
  special = false
}

resource "aws_db_instance" "orders" {
  identifier              = "bedrock-orders"
  engine                  = "postgres"
  engine_version          = "15"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  db_name                 = "orders"
  username                = "root"
  password                = random_string.orders_db_master.result
  db_subnet_group_name    = aws_db_subnet_group.orders.name
  vpc_security_group_ids  = [aws_security_group.orders_rds.id]
  storage_encrypted       = false
  skip_final_snapshot     = true
  backup_retention_period = 0
  apply_immediately       = true
  tags                    = var.tags
}
