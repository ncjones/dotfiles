#!/bin/sh
mitmproxy_ca_cert=$HOME/.mitmproxy/mitmproxy-ca-cert.cer
java_bin_dir=$(dirname $(readlink -f $(which java)))
jre_home=$(cd "$java_bin_dir/.." && pwd)
java_keystore=$jre_home/lib/security/cacerts
sudo keytool -import \
  -trustcacerts \
  -noprompt \
  -storepass changeit \
  -alias mitmproxy \
  -file $mitmproxy_ca_cert \
  -keystore $java_keystore
sudo ln -s $mitmproxy_ca_cert /usr/lib/ssl/certs/mitmproxy_ca_cert.pem
sudo c_rehash /usr/lib/ssl/certs
