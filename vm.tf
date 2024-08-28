provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
  api_timeout          = 10
}

data "vsphere_datacenter" "datacenter" {
  name = "Datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "0590"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_host" "esxi_host" {
  name          = "10.21.22.13"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template_from_ovf" {
  name          = "ubuntu-noble-24.04-cloudimg"
  datacenter_id = data.vsphere_datacenter.datacenter.id

}
data "vsphere_virtual_machine" "template" {
  name          = "ubuntu-noble-24.04-cloudimg"
  datacenter_id = data.vsphere_datacenter.datacenter.id

}

## Deployment of VM from Local OVF
resource "vsphere_virtual_machine" "vmFromLocalOvf" {
  name             = "local-foo"
  datacenter_id    = data.vsphere_datacenter.datacenter.id
  datastore_id     = data.vsphere_datastore.datastore.id
  host_system_id   = data.vsphere_host.esxi_host.id
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  ovf_deploy {
    allow_unverified_ssl_cert = false
    local_ovf_path            = "C:/Users/suyiiyii/Downloads/noble-server-cloudimg-amd64.ova"
    disk_provisioning         = "thin"
    ip_protocol               = "IPV4"
    ip_allocation_policy      = "STATIC_MANUAL"
    ovf_network_map = {
      "Network 1" = data.vsphere_network.network.id
      "Network 2" = data.vsphere_network.network.id
    }
  }
  
  cdrom {
    client_device = true
  }

  extra_config = {
    "guestinfo.userdata"          = var.userdata
    "guestinfo.metadata.encoding" = "base64"
  }

}
