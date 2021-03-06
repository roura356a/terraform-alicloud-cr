variable "region" {
  description = "The region used to launch this module resources."
  default     = ""
  type        = string
}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  default     = "default"
  type        = string
}

variable "shared_credentials_file" {
  description = "This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  default     = ""
  type        = string
}

variable "skip_region_validation" {
  description = "Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  default     = false
  type        = bool
}

variable "namespace" {
  description = "Name of Container Registry namespace"
  type        = string
}

variable "password" {
  description = "Password for the Container Registry"
  type        = string
  default     = ""
}

variable "repositories" {
  description = "List of repositories to be created on apply"
  default     = ["default"]
  type        = list(string)
}

variable "repo_autocreate" {
  description = "Boolean, when it set to true, repositories are automatically created when pushing new images. If it set to false, you create repository for images before pushing"
  default     = true
  type        = bool
}
