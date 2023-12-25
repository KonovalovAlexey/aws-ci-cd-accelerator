#============================= ECS Policies ===========================##
data "aws_iam_policy_document" "ecs_assume_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "ecs_execution_role" {
  name               = "Ecs-Execution-${var.repo_name}-${var.region}"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_policy.json
}
resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_role" {
  name               = "Ecs-Task-${var.repo_name}-${var.region}"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_policy.json
}
#resource "aws_iam_role_policy_attachment" "ecs_task" {
#  role       = aws_iam_role.ecs_task_role.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
#}
resource "aws_iam_role_policy_attachment" "ecs_task" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXrayFullAccess"
}
#============ Put Policies for Task Role here, if you need to get access to AWS Services ==========#
resource "aws_iam_policy" "secrets" {
  name        = "ECS-Get-Secrets-${var.repo_name}-${var.region}"
  description = "Allowed ECS Service to get secrets "

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssm:GetParameters",
          "secretsmanager:GetSecretValue"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "secrets" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = aws_iam_policy.secrets.arn
}