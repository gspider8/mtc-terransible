resource "random_id" "random" {
    byte_length = 2
}

resource "aws_vpc" "mtc_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    
    tags = {
        Name = "mtc_vpc-${random_id.random.dec}"
        project = "mtc-taj"
    }
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_internet_gateway" "mtc_internet_gateway" {
    vpc_id = aws_vpc.mtc_vpc.id
    tags = {
        Name = "mtc_igw-${random_id.random.dec}"
        project = "mtc-taj"
    }
}

resource "aws_route_table" "mtc_public_rt" {
    vpc_id = aws_vpc.mtc_vpc.id
    tags = {
        Name = "mtc-public"
        project = "mtc-taj"
    }
}
resource "aws_route" "default_route" {
    route_table_id = aws_route_table.mtc_public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mtc_internet_gateway.id
}
