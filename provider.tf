provider "vault" {
  address        ="https://vault.pdevops.online:8200"
  token          = var.vault_token
  skip_tls_verify = true
}
