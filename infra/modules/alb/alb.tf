resource "aws_lb" "this" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"
  internal           = false # should be true?

  security_groups = [aws_security_group.alb.id]
  subnets         = var.public_subnets

  enable_deletion_protection = false

}