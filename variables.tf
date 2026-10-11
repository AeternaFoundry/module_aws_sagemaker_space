variable "sagemaker_spaces" {
  description = <<EOT
Map of sagemaker_spaces, attributes below
Required:
    - domain_id
    - space_name
Optional:
    - region
    - space_display_name
    - tags
    - tags_all
    - ownership_settings (block):
        - owner_user_profile_name (required)
    - space_settings (block):
        - app_type (optional)
        - code_editor_app_settings (optional, block):
            - app_lifecycle_management (optional, block):
                - idle_settings (optional, block):
                    - idle_timeout_in_minutes (optional)
            - default_resource_spec (required, block):
                - instance_type (optional)
                - lifecycle_config_arn (optional)
                - sagemaker_image_arn (optional)
                - sagemaker_image_version_alias (optional)
                - sagemaker_image_version_arn (optional)
        - custom_file_system (optional, block):
            - efs_file_system (required, block):
                - file_system_id (required)
        - jupyter_lab_app_settings (optional, block):
            - app_lifecycle_management (optional, block):
                - idle_settings (optional, block):
                    - idle_timeout_in_minutes (optional)
            - code_repository (optional, block):
                - repository_url (required)
            - default_resource_spec (required, block):
                - instance_type (optional)
                - lifecycle_config_arn (optional)
                - sagemaker_image_arn (optional)
                - sagemaker_image_version_alias (optional)
                - sagemaker_image_version_arn (optional)
        - jupyter_server_app_settings (optional, block):
            - code_repository (optional, block):
                - repository_url (required)
            - default_resource_spec (required, block):
                - instance_type (optional)
                - lifecycle_config_arn (optional)
                - sagemaker_image_arn (optional)
                - sagemaker_image_version_alias (optional)
                - sagemaker_image_version_arn (optional)
            - lifecycle_config_arns (optional)
        - kernel_gateway_app_settings (optional, block):
            - custom_image (optional, block):
                - app_image_config_name (required)
                - image_name (required)
                - image_version_number (optional)
            - default_resource_spec (required, block):
                - instance_type (optional)
                - lifecycle_config_arn (optional)
                - sagemaker_image_arn (optional)
                - sagemaker_image_version_alias (optional)
                - sagemaker_image_version_arn (optional)
            - lifecycle_config_arns (optional)
        - space_storage_settings (optional, block):
            - ebs_storage_settings (required, block):
                - ebs_volume_size_in_gb (required)
    - space_sharing_settings (block):
        - sharing_type (required)
EOT

  type = map(object({
    domain_id          = string
    space_name         = string
    region             = optional(string)
    space_display_name = optional(string)
    tags               = optional(map(string))
    tags_all           = optional(map(string))
    ownership_settings = optional(object({
      owner_user_profile_name = string
    }))
    space_settings = optional(object({
      app_type = optional(string)
      code_editor_app_settings = optional(object({
        app_lifecycle_management = optional(object({
          idle_settings = optional(object({
            idle_timeout_in_minutes = optional(number)
          }))
        }))
        default_resource_spec = object({
          instance_type                 = optional(string)
          lifecycle_config_arn          = optional(string)
          sagemaker_image_arn           = optional(string)
          sagemaker_image_version_alias = optional(string)
          sagemaker_image_version_arn   = optional(string)
        })
      }))
      custom_file_system = optional(list(object({
        efs_file_system = object({
          file_system_id = string
        })
      })))
      jupyter_lab_app_settings = optional(object({
        app_lifecycle_management = optional(object({
          idle_settings = optional(object({
            idle_timeout_in_minutes = optional(number)
          }))
        }))
        code_repository = optional(list(object({
          repository_url = string
        })))
        default_resource_spec = object({
          instance_type                 = optional(string)
          lifecycle_config_arn          = optional(string)
          sagemaker_image_arn           = optional(string)
          sagemaker_image_version_alias = optional(string)
          sagemaker_image_version_arn   = optional(string)
        })
      }))
      jupyter_server_app_settings = optional(object({
        code_repository = optional(list(object({
          repository_url = string
        })))
        default_resource_spec = object({
          instance_type                 = optional(string)
          lifecycle_config_arn          = optional(string)
          sagemaker_image_arn           = optional(string)
          sagemaker_image_version_alias = optional(string)
          sagemaker_image_version_arn   = optional(string)
        })
        lifecycle_config_arns = optional(set(string))
      }))
      kernel_gateway_app_settings = optional(object({
        custom_image = optional(list(object({
          app_image_config_name = string
          image_name            = string
          image_version_number  = optional(number)
        })))
        default_resource_spec = object({
          instance_type                 = optional(string)
          lifecycle_config_arn          = optional(string)
          sagemaker_image_arn           = optional(string)
          sagemaker_image_version_alias = optional(string)
          sagemaker_image_version_arn   = optional(string)
        })
        lifecycle_config_arns = optional(set(string))
      }))
      space_storage_settings = optional(object({
        ebs_storage_settings = object({
          ebs_volume_size_in_gb = number
        })
      }))
    }))
    space_sharing_settings = optional(object({
      sharing_type = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_spaces : (
        v.space_settings == null || (v.space_settings.jupyter_lab_app_settings == null || (v.space_settings.jupyter_lab_app_settings.code_repository == null || (length(v.space_settings.jupyter_lab_app_settings.code_repository) <= 10)))
      )
    ])
    error_message = "Each code_repository list must contain at most 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_spaces : (
        v.space_settings == null || (v.space_settings.jupyter_server_app_settings == null || (v.space_settings.jupyter_server_app_settings.code_repository == null || (length(v.space_settings.jupyter_server_app_settings.code_repository) <= 10)))
      )
    ])
    error_message = "Each code_repository list must contain at most 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_spaces : (
        v.space_settings == null || (v.space_settings.kernel_gateway_app_settings == null || (v.space_settings.kernel_gateway_app_settings.custom_image == null || (length(v.space_settings.kernel_gateway_app_settings.custom_image) <= 200)))
      )
    ])
    error_message = "Each custom_image list must contain at most 200 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_spaces : (
        (length(v.space_name) >= 1 && length(v.space_name) <= 63) && (can(regex("^[0-9A-Za-z](-*[0-9A-Za-z]){0,62}", v.space_name)))
      )
    ])
    error_message = "all of: must be between 1 and 63 characters; Valid characters are a-z, A-Z, 0-9, and - (hyphen)."
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_spaces : (
        v.space_display_name == null || (length(v.space_display_name) >= 0 && length(v.space_display_name) <= 64)
      )
    ])
    error_message = "must be between 0 and 64 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_spaces : (
        v.space_settings == null || (v.space_settings.code_editor_app_settings == null || (v.space_settings.code_editor_app_settings.app_lifecycle_management == null || (v.space_settings.code_editor_app_settings.app_lifecycle_management.idle_settings == null || (v.space_settings.code_editor_app_settings.app_lifecycle_management.idle_settings.idle_timeout_in_minutes == null || (v.space_settings.code_editor_app_settings.app_lifecycle_management.idle_settings.idle_timeout_in_minutes >= 60 && v.space_settings.code_editor_app_settings.app_lifecycle_management.idle_settings.idle_timeout_in_minutes <= 525600)))))
      )
    ])
    error_message = "must be between 60 and 525600"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_spaces : (
        v.space_settings == null || (v.space_settings.jupyter_lab_app_settings == null || (v.space_settings.jupyter_lab_app_settings.app_lifecycle_management == null || (v.space_settings.jupyter_lab_app_settings.app_lifecycle_management.idle_settings == null || (v.space_settings.jupyter_lab_app_settings.app_lifecycle_management.idle_settings.idle_timeout_in_minutes == null || (v.space_settings.jupyter_lab_app_settings.app_lifecycle_management.idle_settings.idle_timeout_in_minutes >= 60 && v.space_settings.jupyter_lab_app_settings.app_lifecycle_management.idle_settings.idle_timeout_in_minutes <= 525600)))))
      )
    ])
    error_message = "must be between 60 and 525600"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_spaces : (
        v.space_settings == null || (v.space_settings.jupyter_lab_app_settings == null || (v.space_settings.jupyter_lab_app_settings.code_repository == null || alltrue([for item in v.space_settings.jupyter_lab_app_settings.code_repository : (length(item.repository_url) >= 1 && length(item.repository_url) <= 1024)])))
      )
    ])
    error_message = "must be between 1 and 1024 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_spaces : (
        v.space_settings == null || (v.space_settings.jupyter_server_app_settings == null || (v.space_settings.jupyter_server_app_settings.code_repository == null || alltrue([for item in v.space_settings.jupyter_server_app_settings.code_repository : (length(item.repository_url) >= 1 && length(item.repository_url) <= 1024)])))
      )
    ])
    error_message = "must be between 1 and 1024 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_spaces : (
        v.space_settings == null || (v.space_settings.space_storage_settings == null || (v.space_settings.space_storage_settings.ebs_storage_settings.ebs_volume_size_in_gb >= 5 && v.space_settings.space_storage_settings.ebs_storage_settings.ebs_volume_size_in_gb <= 16384))
      )
    ])
    error_message = "must be between 5 and 16384"
  }
  # Note: 20 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

