locals {
  vpc_tags = {
    Name = "${var.env}-vpc"
    ENV  = var.env
    PROJECT = "roboshop"
  }
  vpc_peering_tags = {

  }
  vpc_ids = [for k, v in aws_vpc.main : v.id]
}