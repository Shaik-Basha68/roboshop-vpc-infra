data "aws_availability_zones" "available" {
    state = "available"
}   
data "aws_vpc" "selected" {
    id = aws_vpc.main.id
}
