# IAM assume role for lambda
resource "aws_iam_role" "lambda_exec" {
  name = var.lambda_assume_role

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com",
        "AWS"    : [
                   "arn:aws:sts::${data.aws_caller_identity.current.account_id}:assumed-role/${var.lambda_assume_role}/${var.getpods_lambda_function_name}"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# Inline policy for STS & EKS
resource "aws_iam_role_policy" "sts_policy" {
  name = "lambda_role_eks_policy"
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "sts:GetCallerIdentity",
                "eks:*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
  })
}

# Lambda policy required to attach to VPC
resource "aws_iam_role_policy" "lambda_ec2_policy" {
  name = "lambda_role_ec2_policy"
  role = aws_iam_role.lambda_exec.id
  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeNetworkInterfaces",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeInstances",
        "ec2:AttachNetworkInterface"
      ],
      "Resource": "*"
    }
  ]
})
}

#Lambda execution role
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
