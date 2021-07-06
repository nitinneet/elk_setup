# create-instance.tf

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}


resource "aws_key_pair" "elk_auth" {
  key_name   = var.key_pair
  public_key = file(var.aws_public_key_path)
}
/*
module "network" {
  source = "./network"
}
*/

module "iam" {
  source = "./iam"
}

#### Creating elasticsearch instnace ####

data "template_file" "init_elasticsearch" {
  template = file("./user_data/init_esearch.tpl")

  vars = {
    elasticsearch_cluster  = var.elasticsearch_cluster
    elasticsearch_data_dir = var.elasticsearch_data_dir
  }
}


resource "aws_instance" "elasticsearch" {
  #ami                        = var.aws_amis
  ami                         = var.aws_amis[var.aws_region]
  #availability_zone          = "${var.aws_region}${var.aws_region_az[0]}"
  instance_type               = var.instance_type
  key_name                    = var.key_pair
  #security_groups            = [aws_security_group.elk_sc_default.id]
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet[0].id
  associate_public_ip_address = true
  iam_instance_profile        = module.iam.es_iam_id


  ebs_block_device {
    device_name = "/dev/sdb"
    volume_type = "io1"
    volume_size = "20"
    iops        = "500"
  }

  user_data = data.template_file.init_elasticsearch.rendered

  tags = {
    Name = "Elasticsearch instance1"
  }
}

#### Creating pointling instnace &  Logstash ####


data "template_file" "init_logstash" {
  template = file("./user_data/init_logstash.tpl")

  vars = {
    elasticsearch_host = aws_instance.elasticsearch.private_ip
  }
}


resource "aws_instance" "logstash" {
  #ami                         = var.aws_amis
  ami           = var.aws_amis[var.aws_region]
  #availability_zone           = "${var.aws_region}${var.aws_region_az[0]}"
  instance_type               = var.instance_type
  associate_public_ip_address = true
  #security_groups             = [aws_security_group.elk_sc_esearch.id]
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet[0].id
  key_name                    = var.key_pair

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_type = "io1"
    volume_size = "20"
    iops        = "500"
  }

  user_data = data.template_file.init_logstash.rendered
    tags = {
      Name = "Pointlinq1"
    }
  }

#### Creating Kibana instnace ####


  data "template_file" "init_kibana" {
    template = file("./user_data/init_kibana.tpl")

    vars = {
    elasticsearch_host = aws_instance.elasticsearch.private_ip
  }
}

resource "aws_instance" "kibana" {
  ami           = var.aws_amis[var.aws_region]
  #ami               = var.aws_amis
  #availability_zone           = "${var.aws_region}${var.aws_region_az[0]}"
  instance_type     = var.instance_type
  key_name          = var.key_pair
  associate_public_ip_address = true
  #security_groups   = [aws_security_group.elasticsearch.id]
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id         = aws_subnet.subnet[0].id

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_type = "io1"
    volume_size = "10"
    iops        = "500"
  }
  user_data = data.template_file.init_kibana.rendered

  tags = {
    Name = "Kibana instance1"
  }
}
