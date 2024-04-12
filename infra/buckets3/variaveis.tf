variable "region" {
  description = "A região da AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"  # Substitua pela sua região
}
variable "origin_domain_name" {
  type = string
  description = "Domain name of the origin (e.g., S3 bucket)"
}
variable "origin_id" {
  type = string
  description = "Unique identifier for the origin"
}

variable "default_root_object" {
  type = string
  description = "Default object that you want requests to route to (e.g., index.html)"
}

# Additional variables for security policy, custom headers, etc. can be defined here