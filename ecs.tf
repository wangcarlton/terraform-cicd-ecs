
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "carlton-vpc-test"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "test"
  }
}

resource "aws_ecs_cluster" "ecs-cluster" {
  name = var.ecs_cluster_name
}