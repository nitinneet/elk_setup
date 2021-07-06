resource "aws_subnet" "subnet" {
  count = length(var.sbn_cidr_block)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.sbn_cidr_block[count.index]
  map_public_ip_on_launch = var.sbn_public_ip
  availability_zone       = "${var.aws_region}${var.aws_region_az[count.index]}"

  tags = {
    "Name"  = "pointlinq-subnet-${count.index}"
  }
}
