variable "uptimerobot_monitors" {
  description = "List of monitors to set up with their respective information"
  type = map(object({
    alert_contacts = list(string)
    friendly_name  = string
    monitor_type   = string
    keyword_type   = string
    keyword_value  = string
    url            = string
    interval       = number
  }))
}
