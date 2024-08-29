data "aws_availability_zones" "zones" {}

module "vpc" {
  source             = "../schema-modules/vpc"
  name               = "${var.vpc_name}"
  cidr               = "${var.vpc_cidr}${var.cidr_spread}"
  private_subnets    = ["${var.vpc_cidr}${var.prisub_a}", "${var.vpc_cidr}${var.prisub_b}", "${var.vpc_cidr}${var.prisub_c}"]
  public_subnets     = ["${var.vpc_cidr}${var.pubsub_a}", "${var.vpc_cidr}${var.pubsub_b}", "${var.vpc_cidr}${var.pubsub_c}"]
  availability_zones = ["${data.aws_availability_zones.zones.names}"]
}

module "bastion_node" {
  source     = "../schema-modules/bastion"
  env_prefix = "${var.env_prefix}"
  vpc_id     = "${module.vpc.vpc_id}"
  key_name   = "${var.key_name}"
  subnet_id  = "${element(module.vpc.public_subnets, 0)}"
}

module "cache_cluster" {
  source             = "../schema-modules/data_cluster"
  vpc_id             = "${module.vpc.vpc_id}"
  subnet_ids         = ["${module.vpc.private_subnets}"]
  cluster_id         = "${var.cache_cluster_id}"
  node_type          = "${var.cache_node_type}"
  num_cache_nodes    = "${var.num_cache_nodes}"
  automatic_failover = "${var.automatic_failover}"
  env_prefix         = "${var.env_prefix}"
}

module "ecs_cluster" {
  source           = "../schema-modules/ecs_cluster"
  env_prefix       = "${var.env_prefix}"
  ami_id           = "${var.ecs_ami_id}"
  cluster_name     = "${var.ecs_cluster_name}"
  desired_capacity = "${var.desired_capacity}"
  max_size         = "${var.max_capacity}"
  instance_type    = "${var.ecs_instance_type}"
  vpc_id           = "${module.vpc.vpc_id}"
  subnet_ids       = ["${module.vpc.private_subnets}"]
  key_name         = "${var.key_name}"
}
