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
```bash
gpg2 --version
gpg (GnuPG/MacGPG2) 2.2.41
libgcrypt 1.8.10
Copyright (C) 2022 g10 Code GmbH
License GNU GPL-3.0-or-later <https://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Home: /Users/warren/.gnupg
Supported algorithms:
Pubkey: RSA, ELG, DSA, ECDH, ECDSA, EDDSA
Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
        CAMELLIA128, CAMELLIA192, CAMELLIA256
Hash: SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
Compression: Uncompressed, ZIP, ZLIB, BZIP2
```

### Generate key

pgp key generate from [fluxcd documentation](https://fluxcd.io/flux/guides/mozilla-sops/)
run the following from on local environment

```bash
export KEY_NAME="Test4"
export KEY_COMMENT="test gpg4"
export KEY_EMAIL="test4@test.test"

gpg2 --batch --full-generate-key <<EOF
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
gpg2 -k
gpg2 --armor --export-secret-key | pbcopy
```

Add key and passphrase as repository secret

# SOPS

`sops --encrypt --pgp=7BAE54F04229B19D7F559F260A861AE7F5DAF885 --in-place fake-secret.enc.json`
