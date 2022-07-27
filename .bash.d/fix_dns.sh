# Used to generate a resolve.conf
# Note that this is run every time a session is started
# This is particularly important of wsl

cat > /tmp/resolv.conf.tmp <<EOF
nameserver 1.1.1.1
EOF
sudo mv /tmp/resolv.conf.tmp /etc/resolv.conf
