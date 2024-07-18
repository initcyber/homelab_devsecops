resource "null_resource" "ansible_provision" {
    # provisioner "local-exec" {
    #     command = <<EOT
    #     echo "172.16.10.60 ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.ansible_private_key}" > ../ansible/inventory
    #     EOT
    # }

    provisioner "remote-exec" {
        inline = ["echo 'Starting Ansible Playbooks'"]
            connection {
        host = "172.16.10.60"
        user = var.user
        private_key = file(var.ansible_ssh_host_keys["priv"])
        agent = false
        timeout = "3m"
    } 
    }
    provisioner "local-exec" {
        working_dir = "../../2-Ansible-Provision/MOTD/"
        command = "ansible-playbook -u ${var.user} --key-file ${var.ansible_ssh_host_keys["priv"]} -i 172.16.10.60, MOTD.yml --ssh-common-args='-o StrictHostKeyChecking=no'"
    }
    provisioner "local-exec" {
        working_dir = "../../2-Ansible-Provision/set-time-zone/"
        command = "ansible-playbook -u ${var.user} --key-file ${var.ansible_ssh_host_keys["priv"]} -i 172.16.10.60, set-time-zone.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

    }  
    provisioner "local-exec" {
        working_dir = "../../2-Ansible-Provision/Docker-Install/"
        command = "ansible-playbook -u ${var.user} --key-file ${var.ansible_ssh_host_keys["priv"]} -i 172.16.10.60, Docker-Gitea-Act-Runner.yml --ssh-common-args='-o StrictHostKeyChecking=no'"
    }  

  depends_on = [
    proxmox_vm_qemu.vm
  ]
}