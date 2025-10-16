<h1 align="center">🚀 Terraform Azure Infrastructure Deployment</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Terraform-v1.x-blue?logo=terraform" alt="Terraform Version">
  <img src="https://img.shields.io/badge/Provider-AzureRM%20v4.48.0-0078D4?logo=microsoftazure" alt="AzureRM Provider">
  <img src="https://img.shields.io/badge/Status-In%20Progress-yellow?style=flat-square" alt="Status">
</p>

---

<h2>📘 Project Overview</h2>

This project automates the deployment of a complete **Azure Virtual Infrastructure** using **Terraform**.  
It creates and manages key Azure components like Resource Group, Virtual Network, Subnet, Network Security Group (NSG), NSG Rules, Public IP, and Virtual Machine — all through modular Terraform configurations.

---

<h2>📂 Folder Structure</h2>

AZURERM_Virtual_Machine/
├── Environment/
│ ├── main.tf
│ ├── provider.tf
│ └── Module/
├── azurerm_resource_group/
│ ├── main.tf
│ ├── variable.tf
│ ├── azurerm_virtual_network/
│ │ ├── main.tf
│ │ └── variable.tf
│ ├── azurerm_subnet/
│ │ ├── main.tf
│ │ └── variable.tf
│ ├── azurerm_network_security_group/
│ │ ├── main.tf
│ │ └── variable.tf
│ ├── azurerm_network_security_rule/
│ │ ├── main.tf
│ │ └── variable.tf
│ ├── azurerm_public_ip/
│ │ ├── main.tf
│ │ └── variable.tf
│ └── azurerm_virtual_machine/
│ ├── data.tf
│ ├── main.tf
│ └── variable.tf

<h2>🧠 Module Design</h2>

Each module defines a specific Azure resource:

Module Name	Description  
azurerm_resource_group	Creates a Resource Group in Azure  
azurerm_virtual_network	Defines the Virtual Network (VNet)  
azurerm_subnet	Configures a Subnet inside the VNet  
azurerm_network_security_group	Creates a Network Security Group (NSG)  
azurerm_network_security_rule	Adds inbound/outbound NSG rules  
azurerm_public_ip	Allocates a Public IP address  
azurerm_virtual_machine	Deploys an Azure Virtual Machine with network interfaces  

---

<h2>🗺️ Terraform Architecture Diagram</h2>

graph TD  
    A[Resource Group] --> B[Virtual Network]  
    B --> C[Subnet]  
    C --> D[Network Security Group]  
    D --> E[NSG Rules]  
    C --> F[Virtual Machine]  
    F --> G[Public IP]  

---

<h2>⚙️ How to Use</h2>

1️⃣ **Clone the Repository**  

git clone https://github.com/your-repo/AZURERM_Virtual_Machine.git  
cd AZURERM_Virtual_Machine/Environment  

2️⃣ **Initialize Terraform**  

terraform init  

3️⃣ **Validate Configuration**  

terraform validate  

4️⃣ **Plan Deployment**  

terraform plan  

5️⃣ **Apply Changes**  

terraform apply -auto-approve  

6️⃣ **Destroy Resources (optional)**  

terraform destroy -auto-approve  

---

<h2>💡 Key Highlights</h2>

✅ **Modular Infrastructure** — Each Azure resource is managed via its own Terraform module.  
🔒 **Network Security Groups (NSG)** — Protect your VMs using inbound/outbound rules.  
☁️ **AzureRM Provider v4.48.0** — Ensures compatibility with the latest Azure APIs.  
⚙️ **State Management** — Supports local or remote backend (Azure Storage).  
🌍 **Scalable Design** — Easily extendable for multiple environments.  

---

<h2 align="center">✨ Developed with ❤️ using Terraform & Azure ✨</h2>
