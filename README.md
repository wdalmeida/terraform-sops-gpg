# terraform-sops-gpg

Terraform configuration that use data from an encrypted sops json with gpg to its output

## Prerequisiste

* `brew install gnupg sops terraform`

## Terraform command

```bash
terraform init
terraform plan -out chain
terraform apply
```

## GPG

### Generate key

pgp key generate from [fluxcd documentation](https://fluxcd.io/flux/guides/mozilla-sops/)
run the following from on local environment

```bash
export KEY_NAME="Test2"
export KEY_COMMENT="test gpg2"
export KEY_EMAIL="test2@test.test"

gpg --batch --full-generate-key <<EOF
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Expire-Date: 0
Name-Comment: ${KEY_COMMENT}
Name-Real: ${KEY_NAME}
Name-Email: ${KEY_EMAIL}
EOF
```

### Export private key

```bash
gpg -k
gpg --armor --export-secret-key $keyid | pbcopy
```

Add key and passphrase as repository secret

# SOPS

`sops --encrypt --pgp=7BAE54F04229B19D7F559F260A861AE7F5DAF885 --in-place fake-secret.enc.json`
