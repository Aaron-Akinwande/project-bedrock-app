output "catalog_db_endpoint" {
  value = aws_db_instance.catalog.address
}

output "catalog_db_database_name" {
  value = aws_db_instance.catalog.db_name
}

output "catalog_db_master_password" {
  value     = aws_db_instance.catalog.password
  sensitive = true
}

output "catalog_db_master_username" {
  value     = aws_db_instance.catalog.username
  sensitive = true
}

output "catalog_db_port" {
  value = aws_db_instance.catalog.port
}

output "catalog_db_reader_endpoint" {
  value = aws_db_instance.catalog.address
}

output "catalog_db_arn" {
  value = aws_db_instance.catalog.arn
}

output "orders_db_endpoint" {
  value = aws_db_instance.orders.address
}

output "orders_db_database_name" {
  value = aws_db_instance.orders.db_name
}

output "orders_db_master_password" {
  value     = aws_db_instance.orders.password
  sensitive = true
}

output "orders_db_master_username" {
  value     = aws_db_instance.orders.username
  sensitive = true
}

output "orders_db_port" {
  value = aws_db_instance.orders.port
}

output "orders_db_reader_endpoint" {
  value = aws_db_instance.orders.address
}

output "orders_db_arn" {
  value = aws_db_instance.orders.arn
}

output "carts_dynamodb_table_arn" {
  value = module.dynamodb_carts.dynamodb_table_arn
}

output "carts_dynamodb_table_name" {
  value = module.dynamodb_carts.dynamodb_table_id
}

output "carts_dynamodb_policy_arn" {
  value = aws_iam_policy.carts_dynamo.arn
}

output "mq_broker_id" {
  value = aws_mq_broker.mq.id
}

output "mq_broker_arn" {
  value = aws_mq_broker.mq.arn
}

output "mq_broker_endpoint" {
  value = aws_mq_broker.mq.instances[0].endpoints[0]
}

output "mq_password" {
  value     = random_password.mq_password.result
  sensitive = true
}

output "mq_user" {
  value = local.mq_default_user
}

output "checkout_elasticache_arn" {
  value = module.checkout_elasticache_redis.arn
}

output "checkout_elasticache_primary_endpoint" {
  value = module.checkout_elasticache_redis.endpoint
}

output "checkout_elasticache_reader_endpoint" {
  value = module.checkout_elasticache_redis.reader_endpoint_address
}

output "checkout_elasticache_port" {
  value = module.checkout_elasticache_redis.port
}

output "catalog_opensearch_endpoint" {
  value = module.catalog_opensearch.domain_endpoint
}

output "catalog_opensearch_master_username" {
  value     = local.catalog_search_username
  sensitive = true
}

output "catalog_opensearch_master_password" {
  value     = random_string.catalog_opensearch_master.result
  sensitive = true
}
