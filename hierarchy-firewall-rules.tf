resource "google_compute_firewall_policy" "folder_hierarchy_policy" {
  parent      = "folders/123456789"
  short_name  = "terraform-hierarchy-folder-fw-policy"
  description = "Example Resource for hierarchy policy"
}

resource "google_compute_firewall_policy_association" "default_policy" {
  firewall_policy   = google_compute_firewall_policy.folder_hierarchy_policy.id
  attachment_target = "folders/123456789"
  name              = "test-policy-association"
}


resource "google_compute_firewall_policy_rule" "folder_hierarchy_rules" {
  for_each = var.hierarchy_rules

  firewall_policy = google_compute_firewall_policy.folder_hierarchy_policy.id
  description     = each.value.description
  priority        = each.value.priority
  enable_logging  = each.value.enable_logging
  action          = each.value.action
  direction       = each.value.direction
  disabled        = each.value.disabled


  match {
    dynamic "layer4_configs" {

      for_each = each.value.layer4_configs
      content {

        ip_protocol = layer4_configs.value.ip_protocol
        ports       = layer4_configs.value.ports
      }
    }

    dest_ip_ranges            = try(each.value.dest_ip_ranges, [])
    dest_fqdns                = try(each.value.dest_fqdns, [])
    dest_region_codes         = try(each.value.dest_region_codes, [])
    dest_threat_intelligences = try(each.value.dest_threat_intelligences, [])
    src_address_groups        = try(each.value.src_address_groups, [])
    dest_address_groups       = try(each.value.dest_address_groups, [])
    src_ip_ranges             = try(each.value.source_ip_ranges, [])
  }

  target_service_accounts = try(each.value.target_service_accounts, [])
}

# resource "google_compute_firewall_policy_rule" "folder_hierarchy_rules_match" {
#   firewall_policy = google_compute_firewall_policy.folder_hierarchy_policy.id
#   description     = "test-more-layer4-configs-blocks"
#   priority        = 9000
#   enable_logging  = false
#   action          = "allow"
#   direction       = "EGRESS"
#   disabled        = false
#   match {
#     layer4_configs {
#       ip_protocol = "tcp"
#       ports       = [8080]
#     }
#     layer4_configs {
#       ip_protocol = "udp"
#       ports       = [22]
#     }
#     dest_ip_ranges            = ["11.100.0.1/32"]
#     dest_fqdns                = []
#     dest_region_codes         = ["US"]
#     dest_threat_intelligences = ["iplist-known-malicious-ips"]
#     src_address_groups        = []

#   }
#   target_service_accounts = ["my@service-account.com"]
# }
