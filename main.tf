terraform {
  required_providers {
    uptimerobot = {
      source  = "louy/uptimerobot"
      version = "0.5.1"
    }
  }
}

provider "uptimerobot" {}

data "uptimerobot_alert_contact" "alert_contact" {
  for_each = toset(flatten(values(var.uptimerobot_monitors)[*].alert_contacts))

  friendly_name = each.value
}

resource "uptimerobot_monitor" "monitor" {
  for_each = var.uptimerobot_monitors

  friendly_name  = each.value.friendly_name
  type           = each.value.monitor_type
  keyword_type   = each.value.keyword_type
  keyword_value  = each.value.keyword_value
  url            = each.value.url
  interval       = each.value.interval
  http_username  = lookup(each.value, "http_username", null)
  http_password  = lookup(each.value, "http_password", null)
  http_auth_type = lookup(each.value, "http_auth_type", null)

  dynamic "alert_contact" {
    for_each = toset(each.value.alert_contacts)

    content {
      id = data.uptimerobot_alert_contact.alert_contact[alert_contact.value].id
    }
  }
}
