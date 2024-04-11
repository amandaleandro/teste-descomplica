resource "aws_iam_policy" "eks_policy" {
  name        = "eks_policy"
  path        = "/"
  description = "Policy for EKS"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "eks:DescribeCluster",
        "eks:CreateCluster",
        "eks:DeleteCluster",
        "eks:ListClusters",
        "eks:UpdateClusterVersion",
        "eks:UpdateClusterConfig"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}