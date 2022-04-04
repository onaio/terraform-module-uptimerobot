output "monitors_id" {
  value = tolist([
    for monitor in uptimerobot_monitor.monitor :
    monitor.id
  ])
}
