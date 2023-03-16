variable "uptimerobot_monitors" {
  description = "List of monitors to set up with their respective information"
  type = map(object({
    alert_contacts    = optional(list(string))
    friendly_name     = string
    monitor_type      = string
    keyword_type      = string
    keyword_value     = string
    url               = string
    interval          = number
    http_username     = optional(string)
    http_password     = optional(string)
    http_auth_type    = optional(string)
    alert_contact_ids = optional(list(number))
  }))
}
variable "uptimerobot_status_page_monitors" {
  description = "List of monitors status page to set up with their respective information"
  default     = {}
  type = map(object({
    monitors      = list(string)
    friendly_name = string
    custom_domain = string
    zone_name     = string
    password      = string
    sort          = string
    status        = string
  }))
}
