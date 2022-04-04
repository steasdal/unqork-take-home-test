variable "region" {
  default = "us-east-2"
}

variable "vpc_name" {
  default = "temp-test-cluster-vpc"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "private_subnets" {
  default = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
}

variable "public_subnets" {
  default = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
}

variable "eks_cluster_name" {
  default = "temp-test-cluster"
}

variable "eks_cluster_version" {
  default = "1.21"
}

variable "eks_node_instance_type" {
  default = "t2.micro"
}