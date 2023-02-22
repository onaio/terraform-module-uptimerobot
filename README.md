# UptimeRobot Terraform Module [![Build Status](https://github.com/onaio/terraform-module-uptimerobot/workflows/CI/badge.svg)](https://github.com/onaio/terraform-module-uptimerobot/actions?query=workflow%3ACI)

This module sets up and configures monitoring of services on [UptimeRobot](https://uptimerobot.com) with the help of [louy/terraform-provider-uptimerobot](https://github.com/louy/terraform-provider-uptimerobot)

## Usage Example

```hcl
# main.tf
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

uptimerobot_status_page_monitors = {
  akuko_uptimerobot_status_page = {
    monitors = [
      "Service A",
    ],
    friendly_name = "Service A"
    custom_domain = "status.service_a.io"
    password      = null
    sort          = "down-up-paused"
    status        = "active"
  },
}

# variables.tf
variable "uptimerobot_monitors" {}
variable "uptimerobot_status_page_monitors" {}
```

Ensure you've set `UPTIMEROBOT_API_KEY` in your environment before running any of the terraform commands that interact with the UptimeRobot API e.g. `terraform plan`, `terraform_apply`, `terraform destroy`. The API Key can be found in Ona's Bitwarden under the Engineering collection named `UptimeRobot API Key`.

```bash
export UPTIMEROBOT_API_KEY=<your UptimeRobot Main API key here>
```
