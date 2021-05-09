provider "aws" {
  alias = "su1"
  region = "ap-southeast-1"
}
resource "aws_s3_bucket" "b" {
  provider = aws.su1
  bucket = "my-tf-test-bucket"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  provider = aws.su1
  name           = "GameScores"
  //billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "UserId"
  //range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"//Attribute type,(S)tring, (N)umber or (B)inary data
  }
}
