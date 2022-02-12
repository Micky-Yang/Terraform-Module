output "asg_name" {
    description = "The Name of the Auto Scaling Group"
    value = aws_autoscaling_group.example_autoscaling_group.name
}