terraform {
  required_version = "1.6.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
}

