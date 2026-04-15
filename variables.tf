variable "name" {
  description = "Name of the primary SQS queue."
  type        = string
}

variable "create_dlq" {
  description = "Whether to create a dead-letter queue and attach it to the primary queue."
  type        = bool
  default     = true
}

variable "visibility_timeout_seconds" {
  description = "How long a received message stays hidden from other consumers before it becomes visible again."
  type        = number
  default     = 30
}

variable "message_retention_seconds" {
  description = "How long to retain messages in the primary queue."
  type        = number
  default     = 345600
}

variable "dlq_message_retention_seconds" {
  description = "How long to retain messages in the dead-letter queue."
  type        = number
  default     = 1209600
}

variable "max_receive_count" {
  description = "How many times a message can be received before moving to the dead-letter queue."
  type        = number
  default     = 5
}

variable "delay_seconds" {
  description = "How long to delay new messages before they become visible in the queue."
  type        = number
  default     = 0
}

variable "receive_wait_time_seconds" {
  description = "How long long polling waits for messages before returning."
  type        = number
  default     = 0
}

variable "tags" {
  description = "Tags to apply to created queues."
  type        = map(string)
  default     = {}
}