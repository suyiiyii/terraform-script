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
locals {
  hostname = "ubuntu-99"
  userdata_origin = templatefile("user-data.yaml.tpl", {
    "hostname"      = local.hostname
    "nerdctl"       = false
    "docker_dind"   = false
    "docker_ce"     = true
    "docker_ubuntu" = false
    "k8s_tools"     = false
    "helm"          = false
    "k9s"           = false
    "neofetch"      = false
  })
  userdata          = base64encode(local.userdata_origin)
  userdata-encoding = "base64"

  metadata_origin = templatefile("meta-data.yaml.tpl", {
    "ipv4" = "10.21.22.99"
  })
  metadata          = base64encode(local.metadata_origin)
  metadata-encoding = "base64"
}

resource "vsphere_virtual_machine" "vm" {
  name             = "clone_test"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 8
  memory           = 4096
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
  cdrom {
    client_device = true
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }
  extra_config = {
    "guestinfo.userdata"          = local.userdata
    "guestinfo.userdata.encoding" = local.userdata-encoding
    "guestinfo.metadata"          = local.metadata
    "guestinfo.metadata.encoding" = local.metadata-encoding
  }
}
