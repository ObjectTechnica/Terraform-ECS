variable "cluster_id" {
  type = "string"
}

variable "node_type" {
  type = "string"
}

variable "num_cache_nodes" {
  type    = "string"
  default = "1"
}

variable "subnet_ids" {
  type = "list"
}

variable "vpc_id" {
  type = "string"
}

variable "env_prefix" {
  type = "string"
}

variable "automatic_failover" {
  type = "string"
  default = "false"
}

output "redis_address" {
  value = "${aws_elasticache_replication_group.redis.primary_endpoint_address}"
}
