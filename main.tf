data "uptimerobot_alert_contact" "alert_contact" {
  for_each = toset(flatten(values(var.uptimerobot_monitors)[*].alert_contacts))

  friendly_name = each.value
}

resource "uptimerobot_monitor" "monitor" {
  for_each = var.uptimerobot_monitors

  friendly_name = each.value.friendly_name
  type          = each.value.monitor_type
  keyword_type  = each.value.keyword_type
  keyword_value = each.value.keyword_value
  url           = each.value.url
  interval      = each.value.interval

  dynamic "alert_contact" {
    for_each = toset(each.value.alert_contacts)

    content {
      id = data.uptimerobot_alert_contact.alert_contact[alert_contact.value].id
    }
  }
}
