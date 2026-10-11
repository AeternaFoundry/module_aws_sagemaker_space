resource "aws_sagemaker_space" "sagemaker_spaces" {
  for_each = var.sagemaker_spaces

  domain_id          = each.value.domain_id
  space_name         = each.value.space_name
  region             = each.value.region
  space_display_name = each.value.space_display_name
  tags               = each.value.tags
  tags_all           = each.value.tags_all

  dynamic "ownership_settings" {
    for_each = each.value.ownership_settings != null ? [each.value.ownership_settings] : []
    content {
      owner_user_profile_name = ownership_settings.value.owner_user_profile_name
    }
  }

  dynamic "space_settings" {
    for_each = each.value.space_settings != null ? [each.value.space_settings] : []
    content {
      app_type = space_settings.value.app_type
      dynamic "code_editor_app_settings" {
        for_each = space_settings.value.code_editor_app_settings != null ? [space_settings.value.code_editor_app_settings] : []
        content {
          dynamic "app_lifecycle_management" {
            for_each = code_editor_app_settings.value.app_lifecycle_management != null ? [code_editor_app_settings.value.app_lifecycle_management] : []
            content {
              dynamic "idle_settings" {
                for_each = app_lifecycle_management.value.idle_settings != null ? [app_lifecycle_management.value.idle_settings] : []
                content {
                  idle_timeout_in_minutes = idle_settings.value.idle_timeout_in_minutes
                }
              }
            }
          }
          default_resource_spec {
            instance_type                 = code_editor_app_settings.value.default_resource_spec.instance_type
            lifecycle_config_arn          = code_editor_app_settings.value.default_resource_spec.lifecycle_config_arn
            sagemaker_image_arn           = code_editor_app_settings.value.default_resource_spec.sagemaker_image_arn
            sagemaker_image_version_alias = code_editor_app_settings.value.default_resource_spec.sagemaker_image_version_alias
            sagemaker_image_version_arn   = code_editor_app_settings.value.default_resource_spec.sagemaker_image_version_arn
          }
        }
      }
      dynamic "custom_file_system" {
        for_each = space_settings.value.custom_file_system != null ? space_settings.value.custom_file_system : []
        content {
          efs_file_system {
            file_system_id = custom_file_system.value.efs_file_system.file_system_id
          }
        }
      }
      dynamic "jupyter_lab_app_settings" {
        for_each = space_settings.value.jupyter_lab_app_settings != null ? [space_settings.value.jupyter_lab_app_settings] : []
        content {
          dynamic "app_lifecycle_management" {
            for_each = jupyter_lab_app_settings.value.app_lifecycle_management != null ? [jupyter_lab_app_settings.value.app_lifecycle_management] : []
            content {
              dynamic "idle_settings" {
                for_each = app_lifecycle_management.value.idle_settings != null ? [app_lifecycle_management.value.idle_settings] : []
                content {
                  idle_timeout_in_minutes = idle_settings.value.idle_timeout_in_minutes
                }
              }
            }
          }
          dynamic "code_repository" {
            for_each = jupyter_lab_app_settings.value.code_repository != null ? jupyter_lab_app_settings.value.code_repository : []
            content {
              repository_url = code_repository.value.repository_url
            }
          }
          default_resource_spec {
            instance_type                 = jupyter_lab_app_settings.value.default_resource_spec.instance_type
            lifecycle_config_arn          = jupyter_lab_app_settings.value.default_resource_spec.lifecycle_config_arn
            sagemaker_image_arn           = jupyter_lab_app_settings.value.default_resource_spec.sagemaker_image_arn
            sagemaker_image_version_alias = jupyter_lab_app_settings.value.default_resource_spec.sagemaker_image_version_alias
            sagemaker_image_version_arn   = jupyter_lab_app_settings.value.default_resource_spec.sagemaker_image_version_arn
          }
        }
      }
      dynamic "jupyter_server_app_settings" {
        for_each = space_settings.value.jupyter_server_app_settings != null ? [space_settings.value.jupyter_server_app_settings] : []
        content {
          dynamic "code_repository" {
            for_each = jupyter_server_app_settings.value.code_repository != null ? jupyter_server_app_settings.value.code_repository : []
            content {
              repository_url = code_repository.value.repository_url
            }
          }
          default_resource_spec {
            instance_type                 = jupyter_server_app_settings.value.default_resource_spec.instance_type
            lifecycle_config_arn          = jupyter_server_app_settings.value.default_resource_spec.lifecycle_config_arn
            sagemaker_image_arn           = jupyter_server_app_settings.value.default_resource_spec.sagemaker_image_arn
            sagemaker_image_version_alias = jupyter_server_app_settings.value.default_resource_spec.sagemaker_image_version_alias
            sagemaker_image_version_arn   = jupyter_server_app_settings.value.default_resource_spec.sagemaker_image_version_arn
          }
          lifecycle_config_arns = jupyter_server_app_settings.value.lifecycle_config_arns
        }
      }
      dynamic "kernel_gateway_app_settings" {
        for_each = space_settings.value.kernel_gateway_app_settings != null ? [space_settings.value.kernel_gateway_app_settings] : []
        content {
          dynamic "custom_image" {
            for_each = kernel_gateway_app_settings.value.custom_image != null ? kernel_gateway_app_settings.value.custom_image : []
            content {
              app_image_config_name = custom_image.value.app_image_config_name
              image_name            = custom_image.value.image_name
              image_version_number  = custom_image.value.image_version_number
            }
          }
          default_resource_spec {
            instance_type                 = kernel_gateway_app_settings.value.default_resource_spec.instance_type
            lifecycle_config_arn          = kernel_gateway_app_settings.value.default_resource_spec.lifecycle_config_arn
            sagemaker_image_arn           = kernel_gateway_app_settings.value.default_resource_spec.sagemaker_image_arn
            sagemaker_image_version_alias = kernel_gateway_app_settings.value.default_resource_spec.sagemaker_image_version_alias
            sagemaker_image_version_arn   = kernel_gateway_app_settings.value.default_resource_spec.sagemaker_image_version_arn
          }
          lifecycle_config_arns = kernel_gateway_app_settings.value.lifecycle_config_arns
        }
      }
      dynamic "space_storage_settings" {
        for_each = space_settings.value.space_storage_settings != null ? [space_settings.value.space_storage_settings] : []
        content {
          ebs_storage_settings {
            ebs_volume_size_in_gb = space_storage_settings.value.ebs_storage_settings.ebs_volume_size_in_gb
          }
        }
      }
    }
  }

  dynamic "space_sharing_settings" {
    for_each = each.value.space_sharing_settings != null ? [each.value.space_sharing_settings] : []
    content {
      sharing_type = space_sharing_settings.value.sharing_type
    }
  }
}

