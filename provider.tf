provider "vault" {
  address = "https://vault-internal.pdevops.online:8200"
  vault_token="hvs.fMGVYmkvteLqprw3itd1iXUe"
  skip_tls_verify = true
}
data "vault_generic_secret" "my_secret" {
  path = "common/data/common"
}