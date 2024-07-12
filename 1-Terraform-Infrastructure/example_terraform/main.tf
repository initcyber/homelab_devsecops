# --------------------------------
# Proxmox Full-Clone Terraform main.tf
# This is using Modules for each Virtual Machine
# --------------------------------
# This will create a new Virtual Machine from a cloud-init file, copy the entire "module" below
# and rename "vm1_id" below for each VM you want. Change the settings to match your environment/what youwant to use.
module "vm1_id" {
    source = "./modules/vm"
    vmid       = 100
    name       = "VM Name goes here"
    target_node = "Proxmox Node Goes Here"
    cores      = 2
    sockets    = 1
    cpu        = "host"    
    memory     = 4048
    disk_size  = "10G" #This is for Cloud Init I believe... I actually need to test this but I left it because it didn't break. I'll test it eventually (TM)
    os_type    = "cloud-init"
    clone = "ubuntu-2404-cloud-vm" #Set this to your cloud-img name in proxmox / Comment out if you use "cloud_vmid" instead
    # Uncomment below if you would rather use vmid to clone...
    #clone_vmid = 9000
    onboot = true # Set VM to start on boot (true/false)
    agent = 1     # Set to 1 to enable the QEMU Guest Agent.

    # --------------------------------
    # VM Network Settings
    # --------------------------------
    netbridge = "vmbr0"
    network_model  = "virtio"
    vlantag = 10
    # IP Address and Gateway - Again, we are using the count.index variable here, assuming we are NOT going above 10 virtual machines this should be OK.
    ipaddress = "ip=172.16.10.10#{count.index + 1}/24,gw=172.16.10.1"


    # --------------------------------
    # VM Hard Drive settings
    # --------------------------------
    scsihw = "virtio-scsi-pci"  # default virtio-scsi-pci
    vmdiskstorage = "VM_Storage"
    vmdisksize = "40G"
    cloudinitstorage = "VM_Storage"

    # --------------------------------
    # Environmental/Global Variables
    # The following variables are set in terraform.auto.tfvars
    # --------------------------------
    sshkeys = var.ssh_key # Set in terraform.auto.tfvars
    user = var.ci_user # Set in terraform.auto.tfvars
    password = var.ci_password # Set in terraform.auto.tfvars
}
