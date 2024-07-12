# Proxmox Full-Clone Terraform main.tf
# This is using Modules for each Virtual Machine
# ---
# This will create a new Virtual Machine from a cloud-init file
module "ipa1" {
    source = "./modules/vm"
    vmid       = 3500
    name       = "ipa1.home.initcyber.net"
    target_node = "discovery"
    cores      = 2
    sockets    = 1
    cpu        = "host"    
    memory     = 4048
    disk_size  = "10G"
    os_type    = "cloud-init"
    clone = "ubuntu-2404-cloud-vm"
    # Uncomment below if you would rather use vmid to clone...
    #clone_vmid = 9000
    # Set VM to start on boot (true/false)
    onboot = true 
    # Set to 1 to enable the QEMU Guest Agent.
    agent = 1
    # VM Network Settings
    netbridge = "vmbr0"
    network_model  = "virtio"
    vlantag = 10

    # VM Hard Drive settings
    scsihw = "virtio-scsi-pci"  # default virtio-scsi-pci
    vmdiskstorage = "VM_Storage"
    vmdisksize = "40G"
    cloudinitstorage = "VM_Storage"
    cloudinitsize = "10G"

    # IP Address and Gateway - Again, we are using the count.index variable here, assuming we are NOT going above 10 virtual machines this should be OK.
    ipaddress = "ip=172.16.10.71/24,gw=172.16.10.1"
    # Set user name here

    # ---
    # Environmental/Global Variables
    # The following variables are set in terraform.auto.tfvars
    sshkeys = var.ssh_key # Set in terraform.auto.tfvars
    user = var.ci_user # Set in terraform.auto.tfvars
    password = var.ci_password # Set in terraform.auto.tfvars
}
#{count.index + 1}