resource "null_resource" "ansible_provision" {
  provisioner "local-exec" {
    command = <<EOT
      echo "${proxmox_vm_qemu.vm.network.0.ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.ansible_private_key}" > ../ansible/inventory
    EOT
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ../ansible/inventory ../ansible/playbook.yml"
  }

  depends_on = [
    proxmox_vm_qemu.vm
  ]
}