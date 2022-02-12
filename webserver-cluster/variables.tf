variable "instance_type" {
    description = "The type of EC2 Instance to run (e.g. t2.micro)"
    type = string
}


variable "min_size" {
    description = "The minimum number of EC2 Instance in the ASG"
    type = number
}


variable "max_size" {
    description = "The maximum number of EC2 Instance in the ASG"
    type = number
}

variable "security_group_id" {
    description = "The security group id"
    type = list(string)
}

variable "vpc_zone_identifier" {
    description = "The security group id"
    type = list(string)
}

