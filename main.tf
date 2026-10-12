
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "location" {
  description = "Azure region for the AKS cluster"
  type        = string
  default     = "Norway East"
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "devops-runner-aks"
}

resource "azurerm_resource_group" "runner_rg" {
  name     = "devops-runner-rg"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "runner_aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.runner_rg.location
  resource_group_name = azurerm_resource_group.runner_rg.name
  dns_prefix          = "devops-runner"

  default_node_pool {
    name       = "system"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    project     = "devops-runner-fleet"
    environment = "training"
  }
}

output "resource_group_name" {
  value = azurerm_resource_group.runner_rg.name
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.runner_aks.name
}
