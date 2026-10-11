output "sagemaker_spaces_id" {
  description = "Map of id values across all sagemaker_spaces, keyed the same as var.sagemaker_spaces"
  value       = { for k, v in aws_sagemaker_space.sagemaker_spaces : k => v.id if v.id != null && length(v.id) > 0 }
}
output "sagemaker_spaces_arn" {
  description = "Map of arn values across all sagemaker_spaces, keyed the same as var.sagemaker_spaces"
  value       = { for k, v in aws_sagemaker_space.sagemaker_spaces : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "sagemaker_spaces_domain_id" {
  description = "Map of domain_id values across all sagemaker_spaces, keyed the same as var.sagemaker_spaces"
  value       = { for k, v in aws_sagemaker_space.sagemaker_spaces : k => v.domain_id if v.domain_id != null && length(v.domain_id) > 0 }
}
output "sagemaker_spaces_home_efs_file_system_uid" {
  description = "Map of home_efs_file_system_uid values across all sagemaker_spaces, keyed the same as var.sagemaker_spaces"
  value       = { for k, v in aws_sagemaker_space.sagemaker_spaces : k => v.home_efs_file_system_uid if v.home_efs_file_system_uid != null && length(v.home_efs_file_system_uid) > 0 }
}
output "sagemaker_spaces_ownership_settings" {
  description = "Map of ownership_settings values across all sagemaker_spaces, keyed the same as var.sagemaker_spaces"
  value       = { for k, v in aws_sagemaker_space.sagemaker_spaces : k => one(v.ownership_settings) if v.ownership_settings != null && length(v.ownership_settings) > 0 }
}
output "sagemaker_spaces_region" {
  description = "Map of region values across all sagemaker_spaces, keyed the same as var.sagemaker_spaces"
  value       = { for k, v in aws_sagemaker_space.sagemaker_spaces : k => v.region if v.region != null && length(v.region) > 0 }
}
output "sagemaker_spaces_space_display_name" {
  description = "Map of space_display_name values across all sagemaker_spaces, keyed the same as var.sagemaker_spaces"
  value       = { for k, v in aws_sagemaker_space.sagemaker_spaces : k => v.space_display_name if v.space_display_name != null && length(v.space_display_name) > 0 }
}
output "sagemaker_spaces_space_name" {
  description = "Map of space_name values across all sagemaker_spaces, keyed the same as var.sagemaker_spaces"
  value       = { for k, v in aws_sagemaker_space.sagemaker_spaces : k => v.space_name if v.space_name != null && length(v.space_name) > 0 }
}
output "sagemaker_spaces_space_settings" {
  description = "Map of space_settings values across all sagemaker_spaces, keyed the same as var.sagemaker_spaces"
  value       = { for k, v in aws_sagemaker_space.sagemaker_spaces : k => one(v.space_settings) if v.space_settings != null && length(v.space_settings) > 0 }
}
output "sagemaker_spaces_space_sharing_settings" {
  description = "Map of space_sharing_settings values across all sagemaker_spaces, keyed the same as var.sagemaker_spaces"
  value       = { for k, v in aws_sagemaker_space.sagemaker_spaces : k => one(v.space_sharing_settings) if v.space_sharing_settings != null && length(v.space_sharing_settings) > 0 }
}
output "sagemaker_spaces_tags" {
  description = "Map of tags values across all sagemaker_spaces, keyed the same as var.sagemaker_spaces"
  value       = { for k, v in aws_sagemaker_space.sagemaker_spaces : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "sagemaker_spaces_tags_all" {
  description = "Map of tags_all values across all sagemaker_spaces, keyed the same as var.sagemaker_spaces"
  value       = { for k, v in aws_sagemaker_space.sagemaker_spaces : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}
output "sagemaker_spaces_url" {
  description = "Map of url values across all sagemaker_spaces, keyed the same as var.sagemaker_spaces"
  value       = { for k, v in aws_sagemaker_space.sagemaker_spaces : k => v.url if v.url != null && length(v.url) > 0 }
}

