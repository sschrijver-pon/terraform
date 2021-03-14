#---------------------------------------------------
# AWS opsworks php app layer
#---------------------------------------------------
resource "aws_opsworks_php_app_layer" "opsworks_php_app_layer" {
  count = var.enable_opsworks_php_app_layer ? 1 : 0

  name     = var.opsworks_php_app_layer_name != "" ? lower(var.opsworks_php_app_layer_name) : "${lower(var.name)}-opsworks-ganglia-layer-${lower(var.environment)}"
  stack_id = var.opsworks_php_app_layer_stack_id != "" && ! var.enable_opsworks_stack ? var.opsworks_php_app_layer_stack_id : element(concat(aws_opsworks_stack.opsworks_stack.*.id, [""]), 0)

  auto_assign_elastic_ips     = var.opsworks_php_app_layer_auto_assign_elastic_ips
  auto_assign_public_ips      = var.opsworks_php_app_layer_auto_assign_public_ips
  custom_instance_profile_arn = var.opsworks_php_app_layer_custom_instance_profile_arn
  custom_security_group_ids   = var.opsworks_php_app_layer_custom_security_group_ids
  auto_healing                = var.opsworks_php_app_layer_auto_healing
  install_updates_on_boot     = var.opsworks_php_app_layer_install_updates_on_boot
  instance_shutdown_timeout   = var.opsworks_php_app_layer_instance_shutdown_timeout
  elastic_load_balancer       = var.opsworks_php_app_layer_elastic_load_balancer
  drain_elb_on_shutdown       = var.opsworks_php_app_layer_drain_elb_on_shutdown
  system_packages             = var.opsworks_php_app_layer_system_packages
  use_ebs_optimized_instances = var.opsworks_php_app_layer_use_ebs_optimized_instances

  custom_json              = var.opsworks_php_app_layer_custom_json
  custom_configure_recipes = var.opsworks_php_app_layer_custom_configure_recipes
  custom_deploy_recipes    = var.opsworks_php_app_layer_custom_deploy_recipes
  custom_setup_recipes     = var.opsworks_php_app_layer_custom_setup_recipes
  custom_shutdown_recipes  = var.opsworks_php_app_layer_custom_shutdown_recipes
  custom_undeploy_recipes  = var.opsworks_php_app_layer_custom_undeploy_recipes

  dynamic "ebs_volume" {
    for_each = var.opsworks_php_app_layer_ebs_volume
    content {
      mount_point     = lookup(opsworks_php_app_layer_ebs_volume.value, "mount_point", null)
      size            = lookup(opsworks_php_app_layer_ebs_volume.value, "size", null)
      number_of_disks = lookup(opsworks_php_app_layer_ebs_volume.value, "number_of_disks", null)
      raid_level      = lookup(opsworks_php_app_layer_ebs_volume.value, "raid_level", null)
      type            = lookup(opsworks_php_app_layer_ebs_volume.value, "type", null)
      iops            = lookup(opsworks_php_app_layer_ebs_volume.value, "iops", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_opsworks_stack.opsworks_stack
  ]
}
