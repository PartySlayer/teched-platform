resource "aws_lb_listener_rule" "auth" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this["auth"].arn
  }

  condition {
    path_pattern {
      values = ["/auth/*"]
    }
  }
}

resource "aws_lb_listener_rule" "learn" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this["learn"].arn
  }

  condition {
    path_pattern {
      values = [
        "/courses*",
        "/progress*",
        "/videos*"
      ]
    }
  }
}

resource "aws_lb_listener_rule" "payments" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 30

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this["payments"].arn
  }

  condition {
    path_pattern {
      values = ["/payments/*"]
    }
  }
}
