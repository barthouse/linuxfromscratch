# Run as root

# Verify that we are in the  chown environment without /tools

# 7.5.3 Setup /etc/hostname

cp etc-hostname /etc/hostname

# 7.5.4 Setup /etc/hosts

cp etc-host /etc/hosts

# 7.6.2 Setup /etc/inittab

cp etc-inittab /etc/inittab

# 7.6.4 Setup /etc/sysconfig/clock

cp etc-sysconfig-clock /etc/sysconfig/clock

# 7.7 /etc/profile

cp etc-profile /etc/profile

# 7.8 /etc/inputrc

cp etc-inputrc /etc/inputrc

# 7.9 /etc/shells

cp etc-shells /etc/shells

# 8.2 /etc/fstab

cp etc-fstab /etc/fstab

# Build kernel

bash boot-linux.sh


