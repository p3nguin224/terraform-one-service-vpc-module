output "statement-app-bastion-instance" {
  value = {
    bastion = module.statement-app.bastion-instance
    web-app = module.statement-app.web-app-instance
  }
}
