#Example of calling firewall_rules module to create vpc firewall rules

module "fw_rules" {
  source = "./modules/firewall_rules"

  network_name  = [network name]
  project_id    = [project id]
  egress_rules  = var.egress_rules
  ingress_rules = var.ingress_rules
}
