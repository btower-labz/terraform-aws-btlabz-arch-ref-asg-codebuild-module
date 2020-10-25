variable "config_path" {
  description = "Configuration path for SSM and Secrets"
  type        = string
  default     = "/dev"
}

variable "database_secret_arn" {
  description = "Database access AWS Secret ARN."
  type        = string
}

variable "git_repo" {
  description = "GIT repository"
  type        = string
}

variable "git_ref" {
  description = "GIT reference"
  type        = string
  default     = "master"
}

variable "buildspec_path" {
  description = "GIT reference"
  type        = string
  default     = "buildspec.yml"
}

variable "tags" {
  description = "Additional tags. E.g. environment, backup tags etc"
  type        = map
  default     = {}
}
