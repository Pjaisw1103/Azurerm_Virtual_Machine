terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.37.0"
    }
  }
  # backend "azurerm" {
  #     resource_group_name  = "tfstate"
  #     storage_account_name = "<storage_account_name>"
  #     container_name       = "tfstate"
  #     key                  = "terraform.tfstate"
  # }
}

provider "azurerm" {
  features {

  }
  subscription_id = "80304407-f80e-4a01-9b2c-197d855b6fb6"
}