resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.environment}_ecs_task_execution_role"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ecs-tasks.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_attach" {
  role       = aws_iam_role.ecs_task_execution_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "template_file" "service_json" {
  template = file("${path.module}/service.json")

  vars = {
    image_uri        = var.image_uri
    container_name   = var.container_name
  }
}

resource "aws_ecs_task_definition" "ecs-task" {
  family                = "ecs-task-test"
  container_definitions = data.template_file.service_json.rendered
  memory = 128
  cpu = 256
  requires_compatibilities = ["EC2"]
  task_role_arn = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
}