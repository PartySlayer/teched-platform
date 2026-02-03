data "aws_availability_zones" "available" {
  state = "available"
  region = "eu-west-1"
}

resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = data.aws_availability_zones.available.names[index(var.public_subnets, each.value) % length(data.aws_availability_zones.available.names)]
  map_public_ip_on_launch = true

}

resource "aws_subnet" "private" {
  for_each = toset(var.private_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = data.aws_availability_zones.available.names[index(var.private_subnets, each.value) % length(data.aws_availability_zones.available.names)]

}
