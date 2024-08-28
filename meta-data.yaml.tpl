instance-id: cloud-vm
local-hostname: cloud-vm
network:
  version: 2
  ethernets:
    interface0:
      match:
        name: ens**
      dhcp4: no
      addresses:
        - ${ipv4}/24
      gateway4: 10.21.22.1
      nameservers:
        addresses:
          - 223.5.5.5
          - 8.8.8.8
