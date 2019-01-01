//
// VPC
//
variable "region" {
  description   = "Choose your AWS Region - i.e. us-west-2, us-east-1"
  default       = "us-west-2"
}
variable "vpc_name" {
  description   = "The friendly name of the VPC"
  default       = "ObjectTechnica"
}
//
// VPC_CIDR
//
variable "vpc_cidr" {
  description   = "The Network CIDR for your chosen VPC"
  default       = "10.10"
}
variable "cidr_spread" {
  description   = "The Network CIDR for your chosen VPC"
  default       = ".0.0/16"
}
//
// Private_Subnets
//
variable "prisub_a" {
  description   = "Private Subnet in $AWS-region A"
  default       = ".160.0/19"
}
variable "prisub_b" {
  description   = "Private Subnet in $AWS-region B"
  default       = ".192.0/19"
}
variable "prisub_c" {
  description   = "Private Subnet in $AWS-region C"
  default       = ".224.0/19"
}
//
// Public_Subnets
//
variable "pubsub_a" {
  description   = "Private Subnet in $AWS-region A"
  default       = ".0.0/21"
}
variable "pubsub_b" {
  description   = "Private Subnet in $AWS-region B"
  default       = ".8.0/21"
}
variable "pubsub_c" {
  description   = "Private Subnet in $AWS-region C"
  default       = ".16.0/21"
}
//
// Bastion_Node
//
variable "env_prefix" {
  description   = "Environment prefix for your Bastion host"
  default       = "development"
}
variable "key_name" {
  description   = "Name of the pem key used for ec2 access"
  default       = "ObjectTechnica"
}
//
// Cache_Cluster
//
variable "cache_cluster_id" {
  description   = "The name of your cache cluster"
  default       = "ObjectTechnica"
}
variable "cache_node_type" {
  description   = "Declared compute type of your cache cluster"
  default       = "cache.m3.medium"
}
variable "num_cache_nodes" {
  description   = "number of nodes in a shard"
  default       = "3"
}
variable "automatic_failover" {
  description   = "Whether or not to add automatic fail-over"
  default       = "true"
}
//
// ECS_Cluster
//
variable "ecs_ami_id" {
  description   = "Declared ami to use with your ecs-cluster - https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html"
  default       = "ami-d2f489aa"
}
variable "ecs_cluster_name" {
  description   = "Name of your ECS cluster"
  default       = "ObjectTechnica_ecs_cluster"
}
variable "desired_capacity" {
  description   = "The optimal number of nodes for your cluster"
  default       = "5"
}
variable "max_capacity" {
  description   = "The max number of nodes for your cluster"
  default       = "5"
}
variable "ecs_instance_type" {
  description   = "Desired size for your ecs nodes"
  default       = "t2.small"
}
