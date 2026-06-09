# 🚀 Azure Virtual Machine Infrastructure with Terraform

This project provides a production-ready, modular Terraform configuration to deploy a Linux Virtual Machine on Azure. It follows best practices by using separate modules for each resource and parameterizing all configurations.

## 📁 Project Structure

```text
AZURERM_Virtual_Machine/
├── Environment/                # Main deployment folder
│   ├── main.tf                 # Root module configuration
│   ├── variables.tf            # Variable declarations for environment
│   ├── terraform.tfvars        # Values for variables (Input)
│   └── provider.tf             # AzureRM provider configuration
├── Module/                     # Reusable resource modules
│   ├── azurerm_resource_group/
│   ├── azurerm_virtual_network/
│   ├── azurerm_subnet/
│   ├── azurerm_public_ip/
│   └── azurerm_virtual_machine/ # Refactored "Genuine" VM Module
│       ├── main.tf             # Resource definitions (NIC, NSG, VM)
│       ├── variable.tf         # Typed & Documented Variables
│       └── data.tf             # Fetching existing Subnet & Public IP
└── README.md                   # This file
```

## 🛠️ Module: azurerm_virtual_machine

The Virtual Machine module has been refactored to be highly flexible and "genuine". Key improvements include:

- **Dynamic NSG Rules:** Configure any number of security rules using a list of objects.
- **Typed Variables:** All variables have descriptions and types.
- **Terraform Functions:** Uses `base64encode`, `coalesce`, and `dynamic` blocks.
- **Customizable:** Easily change VM size, OS image, and admin credentials.

### Required Variables

| Name | Description | Type |
|------|-------------|------|
| `rg_name` | Resource Group Name | `string` |
| `vm_name` | Virtual Machine Name | `string` |
| `vm_location` | Azure Region | `string` |
| `nic_name` | Network Interface Name | `string` |
| `nsg_name` | Network Security Group Name | `string` |
| `admin_password` | Administrator Password (Sensitive) | `string` |

### Default Settings
- **VM Size:** `Standard_DS1_v2`
- **OS:** Ubuntu 22.04 LTS (Jammy)
- **User:** `azureuser`

## 🚀 Getting Started

### 1. Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) installed.
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) authenticated (`az login`).

### 2. Configuration
Update `Environment/terraform.tfvars` with your desired values.

### 3. Deployment
```bash
cd Environment
terraform init
terraform plan
terraform apply -auto-approve
```

## ✨ Features
- ✅ **Infrastructure as Code:** 100% automated deployment.
- ✅ **Security:** Integrated NSG with dynamic rule support.
- ✅ **Best Practices:** Use of `sensitive` variables and `coalesce` for robust resource placement.
- ✅ **Scalability:** Modular design allows for easy extension.

---
Developed with ❤️ by Gemini CLI
