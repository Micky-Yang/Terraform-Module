# 定义模块的局部变量
locals {
  image_id = "ami-03d79d440297083e3"
  health_check_type = "ELB"
  tag_key = "name"
  tag_value = "terraform-asg-example"
}


# 定义主机集群集中实例的配置信息
resource "aws_launch_configuration" "instance_example" {
    image_id = local.image_id
    instance_type = var.instance_type
    security_groups = var.security_group_id
    
    user_data = <<EOF
		#! /bin/bash
        sudo yum update all -y
		sudo yum install -y httpd
		sudo systemctl start httpd
		sudo systemctl enable httpd
		echo `hostname` > /var/www/html/index.html
	EOF

    # 定义一个钩子，表示先创建新资源，再删除旧资源
    lifecycle {
      create_before_destroy = true
    }          
}



# 定义集群组，引用配置的实例中的配置信息
resource "aws_autoscaling_group" "example_autoscaling_group" {
    launch_configuration = aws_launch_configuration.instance_example.name
    vpc_zone_identifier = var.vpc_zone_identifier
    
    #target_group_arns = [aws_lb_target_group.asg_group.arn]
    health_check_type = local.health_check_type

    min_size = var.min_size
    max_size = var.max_size

    tag {
      key = local.tag_key
      value = local.tag_value
      propagate_at_launch = true
    }
}