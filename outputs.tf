output "monitors_id" {
  value = tolist([
    for monitor in uptimerobot_monitor.monitor :
    monitor.id
  ])
}
output "uptimerobot_status_pages_names" {
  value = tolist([
    for page in uptimerobot_status_page.status_page :
    page.friendly_name
  ])
}
