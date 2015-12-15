#!/bin/sh
sudo ln -s ~/owasp_zap_root_ca.cer /usr/lib/ssl/certs/owasp_zap_root_ca.pem
sudo c_rehash /usr/lib/ssl/certs
