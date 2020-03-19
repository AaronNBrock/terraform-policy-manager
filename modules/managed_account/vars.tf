variable "role_arn" {
  description = "The Role to assume with permissions in the account."
  type        = string
}

variable "name_prefix" {
  description = "Prefix to attach to all named resources."
  default     = ""
}

variable "name_suffix" {
  description = "Suffix to attach to all named resources."
  default     = ""
}
