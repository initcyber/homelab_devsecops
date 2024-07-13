resource "null_resource" "ansible_provision" {
    provisioner "local-exec" {
        command = <<EOT
        echo "${proxmox_vm_qemu.vm.network.0.ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.ansible_private_key}" > ../ansible/inventory
        EOT
    }

    provisioner "remote-exec" {
        inline = ["echo 'Starting Ansible Playbooks'"]

    }
    provisioner "local-exec" {
        working_dir = "../../2-Ansible-Provision/MOTD/"
        command = "ansible-playbook -u ${var.user} --key-file ${var.ssh_keys["priv"]} -i 172.16.10.4${count.index + 1}, MOTD.yml --ssh-common-args='-o StrictHostKeyChecking=no'"
    }
    provisioner "local-exec" {
        working_dir = "../../2-Ansible-Provision/set-time-zone/"
        command = "ansible-playbook -u ${var.user} --key-file ${var.ssh_keys["priv"]} -i 172.16.10.4${count.index + 1}, set-time-zone.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

    }  
    provisioner "local-exec" {
        working_dir = "../../2-Ansible-Provision/Docker-Install/"
        command = "ansible-playbook -u ${var.user} --key-file ${var.ssh_keys["priv"]} -i 172.16.10.4${count.index + 1}, Docker-Gitea-Act-Runner.yml --ssh-common-args='-o StrictHostKeyChecking=no'"
    }  

  depends_on = [
    proxmox_vm_qemu.vm
  ]
}