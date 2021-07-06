resource "aws_route_table_association" "a" {
  count = length(var.sbn_cidr_block)
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.rt.id
}
