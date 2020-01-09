
resource "aws_ecs_service" "test-ecs-service" {
  name            = "test-ecs-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.ecs-task.arn
  desired_count   = 5
  iam_role        = "arn:aws:iam::${var.ACCOUNT_ID}:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  launch_type = "EC2"
  scheduling_strategy = "REPLICA"
  # This value should be carefully tuned if doing rolling deployment
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent = 100
  depends_on = [aws_alb.ecs_service_alb]
  load_balancer {
    target_group_arn = aws_alb_target_group.alb_target_group_http.arn
    container_name   = var.container_name
    container_port   = 3000
  }
}