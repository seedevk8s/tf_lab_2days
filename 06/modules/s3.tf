resource "aws_s3_bucket" "buckets" {
  for_each = toset(var.bucket_names) # 리스트를 Set으로 변환

  bucket = each.value

  tags = {
    Name = each.value
  }
}
