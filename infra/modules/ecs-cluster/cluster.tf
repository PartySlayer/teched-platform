resource "aws_ecs_cluster" "this" {
  name = var.project_name
  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

}
