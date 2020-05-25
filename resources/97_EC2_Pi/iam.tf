
resource "aws_iam_role_policy" "ec2-profile-policy" {
  name = "${local.iam_instance_profile}-policy"
  role = aws_iam_role.ec2-role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
              "ec2:CreateKeyPair",
              "ec2:ReleaseAddress",
              "ec2:DisassociateAddress",
              "ec2:DescribeInstances",
              "ec2:DescribeAddresses",
              "ec2:DescribeNetworkInterfaces",
              "ec2:AssociateAddress",
              "ec2:AllocateAddress"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}


# on recupere la policy pour SSM
data "aws_iam_policy" "amazonEC2RoleforSSM_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "attachSSMPolicy" {
  role       = aws_iam_role.ec2-role.name
  policy_arn = data.aws_iam_policy.amazonEC2RoleforSSM_policy.arn
}


# # on recupere la policy pour CloudWatch
# data "aws_iam_policy" "cloudWatchAgentAdmin_policy" {
#   arn = "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy"
# }

# resource "aws_iam_role_policy_attachment" "attachCloudWatcholicy" {
#   role       = "${aws_iam_role.ec2-role.name}"
#   policy_arn = "${data.aws_iam_policy.cloudWatchAgentAdmin_policy.arn}"
# }

# Creation de l'instance profile qui sera associé à l'instance
resource "aws_iam_instance_profile" "ec2-profile" {
  name  = local.iam_instance_profile
  role = aws_iam_role.ec2-role.name
}


# Creation du role que l'instance openVPN va "AssumerRole"
resource "aws_iam_role" "ec2-role" {
  name = "${local.iam_instance_profile}-role"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
