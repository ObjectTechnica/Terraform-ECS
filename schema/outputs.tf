output "ecs_redis_cluster_address" {
  value = "${module.cache_cluster.redis_address}"
}

output "bastion_node_address" {
  value = "${module.bastion_node.bastion_node_address}"
}

output "bastion_ssh_command" {
  value = "${format("ssh ec2-user@%s", module.bastion_node.bastion_node_address)}"
}

output "nat_gateway_ips" {
  value = "${module.vpc.nat_ips}"
}

output "ecs_cluster_name" {
  value = "${module.ecs_cluster.ecs_cluster_name}"
}
