# package go function and dependencies
data "archive_file" "go_lambda_archive" {
  type        = "zip"
  source_dir = "${path.module}/handler"
  output_path = "${path.module}/handler.zip"
}

# S3 bucket to store function package
resource "aws_s3_bucket" "lambda_go_bucket" {
  bucket = "aqua-assignment-lambda-go-function-bucket"
  acl           = "private"
  force_destroy = true
}

resource "aws_s3_bucket_object" "lambda_go_archive_object" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "handler.zip"
  source = data.archive_file.go_lambda_archive.output_path
  etag = filemd5(data.archive_file.go_lambda_archive.output_path)

}

#lambda function for go
resource "aws_lambda_function" "lambda_go" {
  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_bucket_object.lambda_go_archive_object.key
  function_name = "go_function"
  role          = aws_iam_role.lambda_exec.arn #data.aws_iam_role.lambda_go_eks_role.arn
  handler       = "handler"
  runtime       = "go1.x"
  timeout        =  30
    vpc_config {
    subnet_ids         = [for s in data.aws_subnet.private : s.id]
    security_group_ids = [data.aws_security_groups.private.ids[0]]
  }
  source_code_hash = data.archive_file.go_lambda_archive.output_base64sha256
}

#log group for lambda fucntion
resource "aws_cloudwatch_log_group" "lambda_go_log_group" {
  name = "/aws/lambda-apigw-go/${aws_lambda_function.lambda_go.function_name}"
  retention_in_days = 30
}
