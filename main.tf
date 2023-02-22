terraform {
  required_providers {
    uptimerobot = {
      source  = "louy/uptimerobot"
      version = "0.5.1"
    }
  }
}

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

resource "uptimerobot_status_page" "status_page" {
  for_each      = var.uptimerobot_status_page_monitors
  friendly_name = each.value.friendly_name
  monitors = [
    for monitor in resource.uptimerobot_monitor.monitor :
    monitor.id if contains(each.value.monitors, monitor.friendly_name)
  ]
  custom_domain = each.value.custom_domain
  password      = each.value.password
  sort          = each.value.sort
  status        = each.value.status
}

resource "aws_route53_record" "record" {
  for_each = var.uptimerobot_status_page_monitors
  zone_id  = data.aws_route53_zone.zone[each.value.zone_name].zone_id
  name     = each.value.custom_domain
  type     = "CNAME"
  ttl      = "300"
  records = [
    for status_page in uptimerobot_status_page.status_page :
    status_page.dns_address if status_page.custom_domain == each.value.custom_domain
  ]
}

data "aws_route53_zone" "zone" {
  for_each = toset(values(var.uptimerobot_status_page_monitors)[*].zone_name)
  name     = each.value
}