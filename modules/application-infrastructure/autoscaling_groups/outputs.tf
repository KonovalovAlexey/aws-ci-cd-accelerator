output "asg_name" {
  value = aws_autoscaling_group.asg.*.name
}

output "asg_arn" {
  value = aws_autoscaling_group.asg.*.arn
}
output "template_name" {
  value = aws_launch_template.launch_template.*.name
}

output "launch_template_id" {
  value = aws_launch_template.launch_template.*.id
}
