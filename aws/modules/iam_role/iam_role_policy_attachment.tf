#-----------------------------------------------------------
# IAM role policy attachment
#-----------------------------------------------------------
resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  count = var.enable_iam_role_policy_attachment ? length(jsondecode(var.iam_role_policy_attachment_policy_arns)) : 0

  role       = var.iam_role_policy_attachment_role != "" ? var.iam_role_policy_attachment_role : (var.enable_iam_role ? element(aws_iam_role.iam_role.*.name, 0) : null)
  policy_arn = jsondecode(var.iam_role_policy_attachment_policy_arns)[count.index]

  depends_on = [
    aws_iam_role.iam_role
  ]
}
