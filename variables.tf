
variable "hierarchy_rules" {
  description = "A map of firewall rule configurations for folder hierarchy"
  type = map(object({
    description    = string
    priority       = number
    enable_logging = bool
    action         = string
    direction      = string
    disabled       = bool
    layer4_configs = list(object({
      ip_protocol = string
      ports       = list(number)
    }))
    dest_ip_ranges              = optional(list(string))
    dest_fqdns                  = optional(list(string))
    dest_region_codes           = optional(list(string))
    dest_threat_intelligences   = optional(list(string))
    dest_address_groups         = optional(list(string))
    source_ip_ranges            = optional(list(string))
    source_fqdns                = optional(list(string))
    source_region_codes         = optional(list(string))
    source_threat_intelligences = optional(list(string))
    source_address_groups       = optional(list(string))

    target_service_accounts = optional(list(string))
  }))
}

#VPC firewall rules variables below
variable "ingress_rules" {
  description = "List of ingress rules"
  default     = []
  type = list(object({
    name                    = string                     # The name of the firewall rule
    description             = optional(string, null)     # An optional description of this resource
    disabled                = optional(bool, null)       # Denotes whether the firewall rule is disabled
    priority                = optional(number, null)     # Priority for this rule. This is an integer between 0 and 65535. When not specified, the value assumed is 1000
    destination_ranges      = optional(list(string), []) # If specified, the firewall will apply only to traffic that has destination IP address in these ranges
    source_ranges           = optional(list(string), []) # If specified, the firewall will apply only to traffic that has source IP address in these ranges
    source_tags             = optional(list(string))     # If specified, the firewall will apply only to traffic with source IP that belongs to a tag listed in source tags
    source_service_accounts = optional(list(string))     # If specified, the firewall will apply only to traffic originating from an instance with a service account in this list
    target_tags             = optional(list(string))     # A list of instance tags indicating sets of instances located in the network that may make network connections as specified in allowed[]
    target_service_accounts = optional(list(string))     # A list of service accounts indicating sets of instances located in the network that may make network connections as specified in allowed[]

    allow = optional(list(object({ # The list of ALLOW rules specified by this firewall
      protocol = string
      ports    = optional(list(string))
    })), [])
    deny = optional(list(object({ # The list of DENY rules specified by this firewall
      protocol = string
      ports    = optional(list(string))
    })), [])
    log_config = optional(object({ # Logging options for a firewall rule
      metadata = string
    }))
  }))
}

variable "egress_rules" {
  description = "List of egress rules"
  default     = []
  type = list(object({
    name                    = string                     # The name of the firewall rule
    description             = optional(string, null)     # An optional description of this resource
    disabled                = optional(bool, null)       # Denotes whether the firewall rule is disabled
    priority                = optional(number, null)     # Priority for this rule. This is an integer between 0 and 65535. When not specified, the value assumed is 1000
    destination_ranges      = optional(list(string), []) # If specified, the firewall will apply only to traffic that has destination IP address in these ranges
    source_ranges           = optional(list(string), []) # If specified, the firewall will apply only to traffic that has source IP address in these ranges
    source_tags             = optional(list(string))     # If specified, the firewall will apply only to traffic with source IP that belongs to a tag listed in source tags
    source_service_accounts = optional(list(string))     # If specified, the firewall will apply only to traffic originating from an instance with a service account in this list
    target_tags             = optional(list(string))     # A list of instance tags indicating sets of instances located in the network that may make network connections as specified in allowed[]
    target_service_accounts = optional(list(string))     # A list of service accounts indicating sets of instances located in the network that may make network connections as specified in allowed[]

    allow = optional(list(object({ # The list of ALLOW rules specified by this firewall
      protocol = string
      ports    = optional(list(string))
    })), [])
    deny = optional(list(object({ # The list of DENY rules specified by this firewall
      protocol = string
      ports    = optional(list(string))
    })), [])
    log_config = optional(object({ # Logging options for a firewall rule
      metadata = string
    }))
  }))
}


