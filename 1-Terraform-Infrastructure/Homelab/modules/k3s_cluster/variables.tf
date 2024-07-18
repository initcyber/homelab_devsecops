# modules/vm/variables.tf

variable "vmid" {
  description = "The VM ID"
  type        = number
}

variable "name" {
  description = "The name of the VM"
  type        = string
}

variable "target_node" {
  description = "The target node for the VM"
  type        = string
}

variable "cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "sockets" {
  description = "Number of CPU sockets"
  type        = number
  default     = 2
}

variable "cpu" {
  description = "Type of CPU"
  type        = string
  default     = "host"
}

variable "memory" {
  description = "Amount of memory in MB"
  type        = number
  default     = 2048
}

variable "disk_size" {
  description = "Disk size"
  type        = string
  default     = "10G"
}

variable "clone" {
  description = "Cloud-init image to clone"
  type        = string
}

variable "agent" {
    description = "Check the box for QEMU Agent Installed?"
    type        = number
    default     = 1
}

variable "onboot" {
  description = "Startup upon Proxmox Startup"
  type        = bool
  default     = true
}

variable "os_type" {
  description = "OS type"
  type        = string
  default     = "cloud-init"
}


variable "network_model" {
  description = "Network model"
  type        = string
  default     = "virtio"
}

variable "netbridge" {
  description = "Network bridge"
  type        = string
  default     = "vmbr0"
}

variable "vlantag" {
  description = "VLAN Tag"
  type        = number
  default     = 10
}

variable "ipaddress" {
  description = "VLAN Tag"
  type        = string
}

variable "clone_os" {
  description = "Cloud Template to clone from"
  type        = string
  default     = "ubuntu_2404_cloud"
}

variable "clone_vmid" {
  description = "Template VMID to clone from"
  type        = number
  default     = 9000
}

variable scsihw {
    description = "Hardware for scsi interface"
    type = string
    default = "virtio-scsi-pci"  
    } 

variable vmdiskstorage {
    description = "Name of Hard Drive to store VM's on Proxmox"
    type = string
    default = "VM_Storage"
    }

variable vmdisksize {
    description = "Disk Size of Virtual Machine Hard Drive"
    type = string
    default = "40G"
}    

variable cloudinitstorage {
    description = "Name of Hard Drive to store VM's on Proxmox"
    type = string
    default = "VM_Storage"
    }

variable cloudinitsize {
    description = "Disk Size of Virtual Machine Hard Drive"
    type = string
    default = "10G"
}    
variable "user" {
  description = "Virtual Machine user"
  type        = string
  default     = "root"
}

variable "password" {
  description = "VM user password"
  type        = string
}

variable "sshkeys" {
    type = string
}

variable "tags" {
  description = "VM tag"
  type        = string
}

variable "ansible_user" {
  description = "Ansible SSH user"
  type        = string
  default     = "root"
}

variable "ansible_private_key" {
  description = "Path to SSH private key for Ansible"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "ansible_ssh_host_keys" {
	type = map
    default = {
      pub  = "~/.ssh/id_rsa.pub"
      priv = "~/.ssh/id_rsa"
    }
}