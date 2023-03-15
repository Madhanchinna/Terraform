#variables
variable "client_ip" {
  default = "0.0.0.0/0"
}

variable "ingress_rules" {
  type        = list(number)
  description = "list of ingress port"
  default     = [80, 22, 8000]
}

variable "egress_rules" {
  type        = list(number)
  description = "list of egress ports"
  default     = [0]
}
