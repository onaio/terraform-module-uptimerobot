# UptimeRobot Terraform Module [![Build Status](https://github.com/onaio/terraform-module-uptimerobot/workflows/CI/badge.svg)](https://github.com/onaio/terraform-module-uptimerobot/actions?query=workflow%3ACI)

This module sets up and configures monitoring of services on [UptimeRobot](https://uptimerobot.com) with the help of [louy/terraform-provider-uptimerobot](https://github.com/louy/terraform-provider-uptimerobot)

## Usage Example

```hcl
# main.tf
provider "uptimerobot" {}

module "uptimerobot_monitor" {
  source = "../../../modules/uptime-robot"

  uptimerobot_monitors = var.uptimerobot_monitors
}

# terraform.tfvars
uptimerobot_monitors = {
  service_a_http = {
    alert_contacts = [
      "Ona Slack (devops-logs)",
      "Canopy Opsgenie"
    ],
    friendly_name = "Service A"
    monitor_type  = "http"
    keyword_type  = null
    keyword_value = null
    url           = "https://service_a.ona.io/health"
    interval      = 60
  },
  service_a_keyword = {
    alert_contacts = [
      "Ona Slack (devops-logs)",
      "Canopy Opsgenie"
    ],
    friendly_name = "Service A"
    monitor_type  = "keyword"
    keyword_type  = "not exists"
    keyword_value = "OK"
    url           = "https://service_a.ona.io/health"
    interval      = 60
  }
}

# variables.tf
variable "uptimerobot_monitors" {}
```

Ensure you've set `UPTIMEROBOT_API_KEY` in your environment before running any of the terraform commands that interact with the UptimeRobot API e.g. `terraform plan`, `terraform_apply`, `terraform destroy`.

```bash
export UPTIMEROBOT_API_KEY=<your UptimeRobot Main API key here>
```
