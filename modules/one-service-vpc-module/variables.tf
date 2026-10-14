variable "target_region" {
  description = "Target Region"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type        = string
}

variable "public_subnets" {
  description = "list of Public Subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "list of Private Subnets"
  type        = list(string)
}

variable "tags" {
  description = "default tags for resources"
  type        = map(string)
}


### Web App Instance
variable "instance_name" {
  description = "Instance Name"
  type        = string
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Key Pair to login EC2"
  type        = string
}

variable "userdata_filename" {
  description = "Name of user data script"
  type        = string
}

variable "webapp_outbound_rules" {
  description = "Map of Objects for Outbound rules."
  type = map(object({
    name                         = optional(string)
    cidr_ipv4                    = optional(string)
    description                  = optional(string)
    from_port                    = optional(number)
    ip_protocol                  = optional(string, "tcp")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    to_port                      = optional(number)
  }))
  default = {
    "all_outbound" = {
      description = "Allow all outbound traffic by default"
      ip_protocol = "-1" # -1 means all protocols in AWS security groups
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
}

variable "webapp_inbound_rules" {
  description = "Map of Objects for Outbound rules."
  type = map(object({
    name                         = optional(string)
    cidr_ipv4                    = optional(string)
    description                  = optional(string)
    from_port                    = optional(number)
    ip_protocol                  = optional(string, "tcp")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    to_port                      = optional(number)
  }))
}


## Bastion
variable "use_Bastion" {
  description = "create Bastion Host in Public Subnet or not"
  type        = bool
  default     = false
}

variable "bastion_outbound_rules" {
  description = "Map of Objects for Outbound rules."
  type = map(object({
    name                         = optional(string)
    cidr_ipv4                    = optional(string)
    description                  = optional(string)
    from_port                    = optional(number)
    ip_protocol                  = optional(string, "tcp")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    to_port                      = optional(number)
  }))
  default = {
    "all_outbound" = {
      description = "Allow all outbound traffic by default"
      ip_protocol = "-1" # -1 means all protocols in AWS security groups
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
}

variable "bastion_inbound_rules" {
  description = "Map of Objects for Outbound rules."
  type = map(object({
    name                         = optional(string)
    cidr_ipv4                    = optional(string)
    description                  = optional(string)
    from_port                    = optional(number)
    ip_protocol                  = optional(string, "tcp")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    to_port                      = optional(number)
  }))
  default = {}
}
