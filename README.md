# 🚀 Azure Virtual Machine Generic Module

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&height=240&text=Azure%20Virtual%20Machine%20Module&fontSize=42&fontAlignY=40&desc=Terraform%20%7C%20Azure%20%7C%20Reusable%20Infrastructure&descAlignY=60&fontColor=ffffff&animation=fadeIn&color=0:0078D4,50:623CE4,100:0D1117"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Terraform-623CE4?style=for-the-badge&logo=terraform&logoColor=white"/>
  <img src="https://img.shields.io/badge/Microsoft%20Azure-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white"/>
  <img src="https://img.shields.io/badge/Reusable%20Module-IaC-success?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Status-Production%20Ready-22C55E?style=for-the-badge"/>
</p>

---

## 📌 Overview

A reusable and scalable Terraform module designed to provision multiple **Azure Linux Virtual Machines** using a single module declaration.

The module leverages:

* `for_each`
* Structured Objects
* Dynamic Blocks
* Optional Attributes
* Reusable Infrastructure Patterns

to deploy VMs, NICs, NSGs, Public IPs, and subnet associations efficiently.

---

## ✨ Key Features

| Feature                  | Description                               |
| ------------------------ | ----------------------------------------- |
| 🚀 Multi-VM Deployment   | Deploy multiple VMs using a single module |
| 🔄 Reusable Architecture | Generic and scalable Terraform design     |
| 🌐 Network Integration   | NIC, Subnet & Public IP support           |
| 🔐 Dynamic NSG Rules     | Create custom inbound/outbound rules      |
| ⚡ Modern Terraform       | Uses optional(), for_each, coalesce       |
| ☁️ Azure Native          | Built specifically for Azure workloads    |

---

## 🏗️ Architecture

```mermaid
flowchart TD

A[Terraform Configuration]
--> B[Generic VM Module]

B --> C[Network Interface]
B --> D[Linux Virtual Machine]
B --> E[Network Security Group]
B --> F[Subnet Lookup]
B --> G[Public IP Lookup]

F --> C
G --> C
E --> C

C --> D
```

---

## 📊 Module Capabilities

<p align="center">

<img src="https://img.shields.io/badge/Multi%20VM-Supported-0078D4?style=for-the-badge"/>

<img src="https://img.shields.io/badge/Dynamic%20NSG-Rules-623CE4?style=for-the-badge"/>

<img src="https://img.shields.io/badge/Public%20IP-Optional-0EA5E9?style=for-the-badge"/>

<img src="https://img.shields.io/badge/Reusable-Module-22C55E?style=for-the-badge"/>

</p>

---

## 📂 Project Structure

```text
Module/
└── azurerm_virtual_machine/
    ├── main.tf
    ├── variables.tf
    ├── data.tf
    └── README.md
```

---

## 🚀 Usage

### Module Declaration

```hcl
module "virtual_machines" {
  source  = "../Module/azurerm_virtual_machine"

  vm_list = var.vm_list
}
```

---

### Example Configuration

```hcl
vm_list = {
  frontend-web = {

    vm_name        = "vm-prod-web-01"
    vm_location    = "East US"
    rg_name        = "rg-production"

    vm_size        = "Standard_DS2_v2"

    nic_name       = "nic-web-01"

    vnet_name      = "vnet-prod"
    snet_name      = "snet-frontend"

    pip_name       = "pip-web-01"

    nsg_name       = "nsg-web-01"

    security_rules = [
      {
        name                   = "AllowHTTP"
        priority               = 100
        direction              = "Inbound"
        access                 = "Allow"
        protocol               = "Tcp"
        destination_port_range = "80"
      }
    ]
  }
}
```

---

## 🧩 Supported Configuration

| Resource                 | Support    |
| ------------------------ | ---------- |
| Azure Linux VM           | ✅          |
| Network Interface        | ✅          |
| Public IP                | ✅ Optional |
| Network Security Group   | ✅ Optional |
| Dynamic Security Rules   | ✅          |
| Custom Tags              | ✅          |
| Multiple Resource Groups | ✅          |
| Multi-VM Deployment      | ✅          |

---

## ⚙️ Execution Steps

### Initialize

```bash
terraform init
```

### Validate

```bash
terraform validate
```

### Plan

```bash
terraform plan -out=tfplan
```

### Deploy

```bash
terraform apply tfplan
```

### Destroy

```bash
terraform destroy
```

---

## 📈 Why This Module?

* Reduces Terraform code duplication
* Supports enterprise-style VM deployments
* Simplifies NSG and NIC management
* Easy to scale from 1 VM to multiple VMs
* Maintains clean Infrastructure as Code practices

---

## 👩‍💻 Author

**Priya Jaiswal**

Azure Cloud | DevOps | Terraform

<p align="center">
  <a href="https://github.com/Pjaisw1103">
    <img src="https://img.shields.io/badge/GitHub-Pjaisw1103-181717?style=for-the-badge&logo=github"/>
  </a>
  <a href="https://linkedin.com/in/priya-jaiswal1103">
    <img src="https://img.shields.io/badge/LinkedIn-Priya%20Jaiswal-0078D4?style=for-the-badge&logo=linkedin"/>
  </a>
</p>

---

<p align="center">
⭐ If this module helped you, consider giving the repository a star.
</p>
