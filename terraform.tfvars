
#Mock variables
hierarchy_rules = {
  "block-all-ingress" = {
    description    = "block-ingress-external-traffic"
    priority       = 3000
    enable_logging = false
    action         = "deny"
    direction      = "INGRESS"
    disabled       = false
    layer4_configs = [
      {
        ip_protocol = "all"
        ports       = []
      }
    ]
    source_ip_ranges = ["0.0.0.0/0"]

  },
  "block-all-egress" = {
    description    = "block-egress-external-traffic"
    priority       = 3001
    enable_logging = false
    action         = "deny"
    direction      = "EGRESS"
    disabled       = false
    layer4_configs = [
      {
        ip_protocol = "all"
        ports       = []
      }
    ]

    dest_ip_ranges = ["0.0.0.0/0"]
  },
  #some test variable
  "allow-http-s-ingress" = {
    description    = "allow-http-s-ingress"
    priority       = 1000
    enable_logging = false
    action         = "allow"
    direction      = "INGRESS"
    disabled       = false
    layer4_configs = [
      {
        ip_protocol = "tcp"
        ports       = [80]
      },
      {
        ip_protocol = "tcp"
        ports       = [443]
      }
    ]
    source_ip_ranges = ["0.0.0.0/0"]
  },
}

ingress_rules = [
  {
    name               = "name"
    description        = "description"
    priority           = 105
    source_ranges      = ["0.0.0.0/0"]
    destination_ranges = []
    allow = [
    ]
    deny = [
      { protocol = "all" },
    ]
  },
  {
    name               = "allow-ping-icmp"
    description        = "Allow ping"
    priority           = 110
    source_ranges      = ["0.0.0.0/0"]
    destination_ranges = []
    allow = [
      { protocol = "icmp" },
    ]
    deny = [
    ]
  }
]

egress_rules = [
  {
    name               = "name"
    description        = "description"
    priority           = 105
    source_ranges      = []
    destination_ranges = []
    allow = [
    ]
    deny = [
      { protocol = "all" },
    ]
  },
  {
    name               = "out-ping-icmp"
    description        = "Allow Ping"
    priority           = 110
    source_ranges      = []
    destination_ranges = []
    allow = [
      { protocol = "icmp" },
    ]
    deny = [
    ]
  }
]
