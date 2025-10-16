terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.48.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = "80304407-f80e-4a01-9b2c-197d855b6fb6"
}
