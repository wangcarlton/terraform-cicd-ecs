variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "ap-southeast-2"
}

variable "environment" {
  description = "The name of the environment"
  default     = "testenv"
}

variable "ecs_cluster_name" {
  description = "The name of the environment"
  default     = "test-cluster"
}

variable "allow_cidr_block" {
  default     = "0.0.0.0/0"
  description = "Specify cidr block that is allowd to acces the LoadBalancer"
}

variable "vpc_cidr" {
  default     = "22.0.0.0/16"
  description = "Specify cidr block for VPC"
}

variable "key_name" {
  default     = "carlton"
  description = "SSH key pair to instances"
}


variable "max_size" {
  default     = 2
  description = "max_size"
}

variable "min_size" {
  default     = 2
  description = "min_size"
}

variable "desired_capacity" {
  default     = 2
  description = "desired_capacity"
}

variable "availability_zones" {
  default     = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
  description = "availability_zones"
}

variable "private_subnets" {
  default     = ["22.0.6.0/24", "22.0.7.0/24", "22.0.8.0/24"]
  description = "private_subnet_cidrs"
}

variable "public_subnets" {
  default     = ["22.0.1.0/24", "22.0.2.0/24", "22.0.3.0/24"]
  description = "public_subnet_cidrs"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "instance_type"
}

variable "ecs_aws_ami" {
  default     = "ami-0adc350d7c7a2259f"
  description = "ecs_aws_ami"
}

variable "alb_listener_port_http" {
  description = "HTTP request listener"
  default     = "80"
}

variable "alb_listener_protocol_http" {
  description = "HTTP protocal listener"
  default     = "HTTP"
}

variable "alb_http_target_group_name" {
  description = "Name of ALB target group"
  default     = "ecs-service-alb-target-group"
}

variable "target_group_path" {
  description = "Health check path"
  default     = "/"
}

variable "target_group_port" {
  description = "Target Port"
  default     = "80"
}

variable "alb_path" {
  description = "Health check path"
  default     = "/"
}

# The container name should be the same as in your imagedefinitions.json which might be generated in your buildappspec.yml
# 
variable "container_name" {
  description = "Container name in task definitions"
  default     = "carlton-test"
}

variable "image_uri" {
  description = "Image URI of ECR"
  default     = "329193457145.dkr.ecr.ap-southeast-2.amazonaws.com/hello-world:latest"
}

variable "ACCOUNT_ID" {
  description = "AWS Account ID"
  default     = "329193457145"
}