resource "aws_security_group" "ecs_service_alb_sg" {
  name   = "ecs-service-alb-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allow_cidr_block]
  }

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_alb_target_group" "alb_target_group_http" {
  name     = var.alb_http_target_group_name
  port     = var.alb_listener_port_http
  protocol = var.alb_listener_protocol_http
  vpc_id   = module.vpc.vpc_id

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = var.target_group_path
    port                = "traffic-port"
  }
}

resource "aws_alb_listener" "alb_listener_http" {
  load_balancer_arn = aws_alb.ecs_service_alb.arn
  port              = var.alb_listener_port_http
  protocol          = var.alb_listener_protocol_http

  default_action {
    target_group_arn = aws_alb_target_group.alb_target_group_http.arn
    type             = "forward"
  }
}

resource "aws_alb" "ecs_service_alb" {
  idle_timeout    = 60
  internal        = false
  name            = "ecs-service-alb"
  security_groups = [aws_security_group.ecs_service_alb_sg.id]
  subnets         = module.vpc.public_subnets

  enable_deletion_protection = false

}

resource "aws_alb_listener_rule" "listener_rule" {
  depends_on   = [aws_alb_target_group.alb_target_group_http]
  listener_arn = aws_alb_listener.alb_listener_http.arn
  action {    
    type             = "forward"    
    target_group_arn = aws_alb_target_group.alb_target_group_http.id  
  }   
  condition {    
    field  = "path-pattern"    
    values = [var.alb_path]  
  }
}

