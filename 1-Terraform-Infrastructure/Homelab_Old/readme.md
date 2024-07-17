# Terraform
Removing Ansible Configurations in favor of Terraform files.

To install terraform (using Ubuntu)

```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update
sudo apt install terraform
```
Then set up your Terraform User and API keys in Proxmox. 

Give your Terraform User appropriate permissions needed and secure the API key created above.


Set up your cloud init image (This is a one time set up - however this could be an ansible script if so desired - not worth setting up IMO unless you have a massive infrastructure, even then it's better off just cloning the image as needed after you make one to ensure it works)

Add libguest tools if not installed:

```bash
apt update -y && apt install libguestfs-tools -y
```
then download your cloud-init image:

```bash
wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
```

then modify the cloud init image for your user, add the SSH key, 
```bash
virt-customize -a noble-server-cloudimg-amd64.img --run-command 'useradd justin'
virt-customize -a noble-server-cloudimg-amd64.img --run-command 'mkdir -p /home/justin/.ssh'
virt-customize -a noble-server-cloudimg-amd64.img --ssh-inject justin:file:/root/id_rsa.pub ### For Proxmox I had to import my public key from my personal machine to my proxmox machine and create the image there
virt-customize -a noble-server-cloudimg-amd64.img --run-command 'chown -R justin:justin /home/justin'
```

then make it a virtual machine
```bash

qm create 9000 --name "ubuntu-2404-cloud-vm" --memory 1024 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 9000 noble-server-cloudimg-amd64.img local-zfs
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-zfs:vm-9000-disk-0
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --ide2 local-zfs:cloudinit
qm set 9000 --serial0 socket --vga serial0
qm set 9000 --agent enabled=1
```

Now make it a template

```bash
qm template 9000
```

Copy this template to other nodes in the GUI (when you clone this template it will make it a VM, number them 9001, 9002, or something high number, or whatever you want - then click the template button after renaming)

Set up the proxmox provider.tf, credentials.auto.tfvars, and ubuntu-clone.tf files accordingly.

provider.tf houses the proxmox provider, where we initialize the variables used for Terraform (hint, if we need other images such as Red Hat, add the variables here), etc.

rename credentials.auto.tfvars -EXAMPLE- file to "credentials.auto.tfvars", adjust variables accordingly

ubuntu-clone.tf is the meat and potatos of the files. This is where we create the VM's of the project.

To apply a specific TF plan, such as the template file ("template_ubuntu-clone.tf") - run:
```bash
terraform apply -target=proxmox_vm_qemu.ubuntu-vm
```
Which is found on top of the actual .tf file you want to apply ("resource "proxmox_vm_qemu" "ubuntu-vm")


--------------------
# Added 7/10/24
### Ansible Provisioning
Added Ansible Provisioning!

Also added in variables assuming the box you are deploying the TF files from has the appropriate SSH keys you wish to deploy to the box (under provider.tf)
```bash
variable "ssh_keys" {
	type = map
     default = {
       pub  = "~/.ssh/id_rsa.pub"
       priv = "~/.ssh/id_rsa"
     }
}
```