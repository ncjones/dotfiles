#!/bin/sh

install_system_cert() {
  sudo ln -s "$mitmproxy_ca_cert" /usr/lib/ssl/certs/mitmproxy_ca_cert.pem
  sudo c_rehash /usr/lib/ssl/certs
}

install_java_cert() {
  java_bin_dir="$(dirname "$(readlink -f "$(which java)")")"
  jre_home=$(cd "$java_bin_dir/.." && pwd)
  java_keystore=$jre_home/lib/security/cacerts
  sudo keytool -import \
    -trustcacerts \
    -noprompt \
    -storepass changeit \
    -alias mitmproxy \
    -file "$mitmproxy_ca_cert" \
    -keystore "$java_keystore"
}

mitmproxy_ca_cert=$HOME/.mitmproxy/mitmproxy-ca-cert.cer
install_system_cert
which java && install_java_cert
