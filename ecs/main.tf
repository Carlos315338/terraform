# ======================================
# Módulo ECS - Recursos completos ECS
# ======================================

# Cluster ECS
resource "aws_ecs_cluster" "backend_cluster" {
  name = "backend-fargate-cluster"
}

# IAM Role para ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Task Definition para el contenedor backend
resource "aws_ecs_task_definition" "backend_task" {
  family                   = "backend-task"
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn      = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "backend-container"
      image = var.image_uri
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}

# Security Group para el backend ECS
resource "aws_security_group" "ecs_sg" {
  name        = "ecs-backend-sg"
  description = "Allow only internal access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Servicio ECS sobre Fargate
resource "aws_ecs_service" "backend_service" {
  name            = "backend-fargate-service"
  cluster         = aws_ecs_cluster.backend_cluster.id
  task_definition = aws_ecs_task_definition.backend_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnet_ids
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_policy]
}
