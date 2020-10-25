variable "security_groups" {
  type        = list
  description = "Additional security groups for the CodeBuild"
  default     = []
}

variable "codebuild_egress_cidr" {
  type    = list
  default = ["0.0.0.0/0"]
}

locals {
  security_groups = sort(concat(
    list(aws_security_group.codebuild.id),
    distinct(compact(var.security_groups))
  ))
}

resource "aws_security_group" "codebuild" {
  name        = format("%s-wl-sg", var.name)
  description = "Allow codebuild Access"
  vpc_id      = data.aws_vpc.main.id
  tags = merge(
    map(
      "Name", format("%s-sg", var.name)
    ),
    var.tags
  )
}

resource "aws_security_group_rule" "codebuild_default_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.codebuild_egress_cidr
  security_group_id = aws_security_group.codebuild.id
}

output "codebuild_sg" {
  description = "codebuild security group"
  value       = aws_security_group.codebuild.id
}
