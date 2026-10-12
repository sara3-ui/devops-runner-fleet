variable "node_count" {
  description = "Number of AKS nodes"
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "Virtual machine size for AKS nodes"
  type        = string
  default     = "Standard_B2s"
}
