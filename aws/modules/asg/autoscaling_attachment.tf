#---------------------------------------------------
# AWS autoscaling_attachment
#---------------------------------------------------
resource "aws_autoscaling_attachment" "asg_attachment" {
  count = var.enable_autoscaling_attachment ? 1 : 0

  autoscaling_group_name = var.autoscaling_group_name != "" ? var.autoscaling_group_name : (var.enable_asg ? element(concat(aws_autoscaling_group.asg.*.name, [""]), 0) : null)

  elb                  = upper(var.load_balancer_type) == "ELB" ? var.load_balancers : null
  alb_target_group_arn = upper(var.load_balancer_type) == "ALB" ? var.alb_target_group_arn : null

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_autoscaling_group.asg
  ]
}
