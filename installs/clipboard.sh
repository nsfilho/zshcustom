#!/bin/bash

sed -i 's/#X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config
sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config
systemctl restart sshd
