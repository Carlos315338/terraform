# ECS Cluster
resource "aws_ecs_cluster" "backend_cluster" {
  name = "backend-fargate-cluster"
}

# IAM Role for ECS Task Execution
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

# ECS Task Definition
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
      image = aws_ecr_repository.cosmeticos-belleza-infinita.repository_url
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

# Security Group para el servicio ECS
resource "aws_security_group" "ecs_sg" {
  name        = "ecs-backend-sg"
  description = "Allow only internal access"
  vpc_id      = "<tu-vpc-id>" # reemplazar

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # solo acceso interno desde la VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Servicio ECS en Fargate
resource "aws_ecs_service" "backend_service" {
  name            = "backend-fargate-service"
  cluster         = aws_ecs_cluster.backend_cluster.id
  task_definition = aws_ecs_task_definition.backend_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = ["<subnet-id-1>", "<subnet-id-2>"] # reemplazar
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs_sg.id]
  }
  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_policy]
}
