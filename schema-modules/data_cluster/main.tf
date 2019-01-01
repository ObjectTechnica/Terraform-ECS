resource "aws_security_group" "redis" {
  name        = "${format("%s-redis-sg", var.env_prefix)}"
  description = "ElastiCache Redis Security Group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "6379"
    to_port     = "6379"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.env_prefix} Redis Node"
  }
}

resource "aws_elasticache_subnet_group" "redis-csng" {
  name        = "${format("%s-redis-csng", var.env_prefix)}"
  description = "${var.env_prefix} Redis Cache Subnet Group"
  subnet_ids  = ["${var.subnet_ids}"]
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "${var.cluster_id}"
  replication_group_description = "${format("%s Redis Cache Cluster", var.env_prefix)}"
  node_type                     = "${var.node_type}"
  number_cache_clusters         = "${var.num_cache_nodes}"
  port                          = 6379
  subnet_group_name             = "${aws_elasticache_subnet_group.redis-csng.name}"
  security_group_ids            = ["${aws_security_group.redis.id}"]
  automatic_failover_enabled    = "${var.automatic_failover}"
}
