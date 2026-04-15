# AWS SQS Queue Module

This module creates an AWS SQS queue with an optional dead-letter queue (DLQ) and attaches the redrive policy automatically when the DLQ is enabled.

## What This Module Creates

- 1 SQS queue
- 0 or 1 dead-letter queue

## Usage

```hcl
module "app_queue" {
  source = "git::ssh://git@github.com/<org>/terraform-sqs-queue-module.git?ref=v0.1.0"

  name = "app-events"

  create_dlq = true

  visibility_timeout_seconds = 30
  message_retention_seconds  = 345600
  max_receive_count          = 5

  tags = {
    Service     = "app"
    Environment = "prod"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | Name of the primary SQS queue | `string` | n/a | yes |
| `create_dlq` | Whether to create a dead-letter queue and attach it to the primary queue | `bool` | `true` | no |
| `visibility_timeout_seconds` | How long a received message stays hidden from other consumers before it becomes visible again | `number` | `30` | no |
| `message_retention_seconds` | How long to retain messages in the primary queue | `number` | `345600` | no |
| `dlq_message_retention_seconds` | How long to retain messages in the dead-letter queue | `number` | `1209600` | no |
| `max_receive_count` | How many times a message can be received before moving to the dead-letter queue | `number` | `5` | no |
| `delay_seconds` | How long to delay new messages before they become visible in the queue | `number` | `0` | no |
| `receive_wait_time_seconds` | How long long polling waits for messages before returning | `number` | `0` | no |
| `tags` | Tags to apply to created queues | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `queue_name` | Name of the primary SQS queue |
| `queue_url` | URL of the primary SQS queue |
| `queue_arn` | ARN of the primary SQS queue |
| `dlq_name` | Name of the dead-letter queue, or `null` when disabled |
| `dlq_url` | URL of the dead-letter queue, or `null` when disabled |
| `dlq_arn` | ARN of the dead-letter queue, or `null` when disabled |

## Release Process

- Update the root `VERSION` file in the same change that should be released, using semantic versioning such as `1.0.1`, `1.1.0`, or `2.0.0`.
- Push the change to `develop` and let the `terraform-validate` workflow pass.
- Open a pull request from `develop` to `main` and let the `terraform-validate` workflow pass again.
- Merge the pull request to `main`.
- Pushing to `main` triggers the automated release workflow, which:
  - reads `VERSION`,
  - checks that tag `v<VERSION>` does not already exist,
  - creates and pushes the tag,
  - creates the GitHub release automatically.
- If `VERSION` has not been updated and the tag already exists, validation and release will fail.
- Consume released versions from other Terraform repos by pinning the module source with the released tag, for example:

```bash
source = "git::ssh://git@github.com:karoosoftware/terraform-sqs-queue-module.git?ref=v1.0.0"
```

## Prerequisites

- Terraform 1.5+
- AWS provider configured in the root module
- IAM permissions to create and manage SQS queues
