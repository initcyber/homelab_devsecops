# outputs.tf

output "vm1_id" {
  description = "The VM ID of vm1"
  value       = module.vm1.vm_id
}
# Repeat for vm2, vm3, vm4, and vm5