# Variables for general information
######################################

variable "aws_profile" {
  description = "aws profile"
  default     = "default"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}


variable "aws_region_az" {
  description = "AWS region availability zone"
  type        = list(string)
  default     = ["a","b","c"]
}


# Variables for VPC
######################################

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "vpc_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}


# Variables for Security Group
######################################

variable "sg_ingress_proto" {
  description = "Protocol used for the ingress rule"
  type        = string
  default     = "tcp"
}

variable "sg_ingress_ssh" {
  description = "Port used for the ingress rule"
  type        = string
  default     = "22"
}

variable "sg_egress_proto" {
  description = "Protocol used for the egress rule"
  type        = string
  default     = "-1"
}

variable "sg_egress_all" {
  description = "Port used for the egress rule"
  type        = string
  default     = "0"
}

variable "sg_egress_cidr_block" {
  description = "CIDR block for the egress rule"
  type        = string
  default     = "0.0.0.0/0"
}


# Variables for Subnet
######################################

variable "sbn_public_ip" {
  description = "Assign public IP to the instance launched into the subnet"
  type        = bool
  default     = true
}

variable "sbn_cidr_block" {
  description = "CIDR block for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24","10.0.2.0/24"]
}



# Variables for Route Table
######################################

variable "rt_cidr_block" {
  description = "CIDR block for the route table"
  type        = string
  default     = "0.0.0.0/0"
}


# Variables for Instance
######################################
/*
variable "aws_amis" {
  description = "ID of the AMI used"
  type        = string
  default     = "ami-0d1cd67c26f5fca19"
}
*/

variable "aws_amis" {
  default = {
    eu-west-1 = "ami-035966e8adab4aaad"
    us-west-2 = "ami-0d1cd67c26f5fca19"
    us-east-1 = "ami-07ebfd5b3428b6f4d"
  }
}


variable "instance_type" {
  description = "Type of the instance"
  type        = string
  default     = "m4.large"
}

variable "key_pair" {
  description = "SSH Key pair used to connect"
  type        = string
  default     = "pointlinq-key-pair-auto"
}

variable "root_device_type" {
  description = "Type of the root block device"
  type        = string
  default     = "gp2"
}

variable "root_device_size" {
  description = "Size of the root block device"
  type        = string
  default     = "50"
}

# Variable for ELK
#########################################

variable "elasticsearch_data_dir" {
  default = "/opt/elasticsearch/data"
}

variable "elasticsearch_cluster" {
  description = "Name of the elasticsearch cluster"
  default     = "pointlink_cluster"
}


variable "aws_public_key_path" {
  default = "/Users/nitin/.ssh/id_rsa.pub"

}
