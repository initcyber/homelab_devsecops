proxmox_api_url = "https://0.0.0.0:8006/api2/json"  # Your Proxmox IP Address or Hostname - Enter it here!
proxmox_api_token_id = "terraform@pam!terraform"  # This is where you put your API Token ID from your ProxMox Host
proxmox_api_token_secret = "This is a super secret API" # This is your ProxMox Token Secret - NOTE: Only displayed once, write it down
ssh_key = <<EOF 
     ssh-ed25519 SUPERSECRET-SSH-Public-Key-LOL-Goes-Here-Delete-This-Line justin@initcyber.com 
     EOF
ci_user = "YourUserNameForVM"     
ci_password = "SuperSecretPassword"