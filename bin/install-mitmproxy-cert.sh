#!/bin/sh
sudo ln -s ~/.mitmproxy/mitmproxy-ca-cert.cer /usr/lib/ssl/certs/mitmproxy_ca_cert.pem
sudo c_rehash /usr/lib/ssl/certs
