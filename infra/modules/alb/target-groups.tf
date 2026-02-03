locals {
  services = {
    auth     = 8080
    learn    = 8080
    payments = 8080
  }
}

resource "aws_lb_target_group" "this" {
  for_each = local.services

  name        = "${var.project_name}-${each.key}-tg"
  port        = each.value
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    path                = var.health_check_path
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

}
