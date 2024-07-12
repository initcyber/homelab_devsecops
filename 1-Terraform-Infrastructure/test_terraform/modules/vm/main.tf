#  Modules VM Template which carries the virtual machine variables used in ../main.tf
# ---
terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc3"  # Latest as of 7/4/2024
    }
  }
}
resource "proxmox_vm_qemu" "vm" {
  vmid        = var.vmid
  name        = var.name
  target_node = var.target_node
  cores       = var.cores
  sockets    = var.sockets #1
  cpu        = var.cpu #"host"    
  memory      = var.memory
  os_type   = var.os_type
  onboot = var.onboot #true 
  agent = var.agent
  ciuser = var.user
  cipassword = var.password
  sshkeys = var.sshkeys
  scsihw = var.scsihw #"virtio-scsi-pci"
  clone = var.clone
  disks {
      scsi{
          scsi0 {
              disk {
                  storage = var.vmdiskstorage #"VM_Storage"
                  size = var.vmdisksize #"40G"
                }
            }
        }
      ide{
          ide1{
              cloudinit{
                  storage = var.cloudinitstorage #"VM_Storage"
                }
            }
        }
    }

  network {
    model  = var.network_model
    bridge = var.netbridge
    tag = var.vlantag
  }
  ipconfig0 = var.ipaddress #"ip=172.16.10.6/24,gw=172.16.10.1"
}


