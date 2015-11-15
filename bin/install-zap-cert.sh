#!/bin/sh
sudo ln -s /usr/lib/ssl/certs/owasp_zap_root_ca.pem ~/owasp_zap_root_ca.cer
sudo c_rehash /usr/lib/ssl/certs
