output "alb_arn" {
  value = aws_lb.this.arn
}

output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "listener_https_arn" {
  value = aws_lb_listener.https.arn
}

output "target_group_arns" {
  value = {
    for k, tg in aws_lb_target_group.this :
    k => tg.arn
  }
}

output "security_group_id" {
  value = aws_security_group.alb.id
}
