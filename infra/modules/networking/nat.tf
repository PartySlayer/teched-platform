resource "aws_eip" "nat" {
  domain = "vpc"

}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public)[0].id

  depends_on = [aws_internet_gateway.this]
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

}
