variable "config_rule" {
  description = "The config rule to apply to"
  type        = object({ name = string })
}

variable "versioning_enabled" {
  description = "Whether to enable versioning (true) or disable versioning (false)."
  type        = bool
  default     = true
}

variable "name_prefix" {
  description = "Suffix to attach to all named resources."
  default     = ""
}

variable "name_suffix" {
  description = "Suffix to attach to all named resources."
  default     = ""
}
