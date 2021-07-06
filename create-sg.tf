# create-sg.tf

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "sg" {
  name        = "pointlinq-sg"
  description = "Allow inbound traffic via SSH"
  vpc_id      = aws_vpc.vpc.id



egress = [{
    description      = "All traffic"
    protocol         = var.sg_egress_proto
    from_port        = var.sg_egress_all
    to_port          = var.sg_egress_all
    cidr_blocks      = [var.sg_egress_cidr_block]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false

  }]
ingress = [{
    description      = "My public IP"
    protocol         = var.sg_ingress_proto
    from_port        = var.sg_ingress_ssh
    to_port          = var.sg_ingress_ssh
    #cidr_blocks      = ["${chomp(data.http.myip.body)}/32"]
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false

  },{
    description      = "My public IP"
    protocol         = "tcp"
    from_port        = 80
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false

  },{
    description      = "My public IP"
    protocol         = "tcp"
    from_port        = 443
    to_port          = 443
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false

  }]


  tags = {
    "Name"  = "pointlinq-sg"
  }
}
