openssl enc -aes-256-cbc -md sha1 \
  -pass file:./keyfile.key \
  -in keyfile \
  -out keyfile.enc
