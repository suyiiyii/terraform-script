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

data "vsphere_virtual_machine" "template" {
  name          = "ubuntu-noble-24.04-cloudimg_240822"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

variable "ips" {
  type = list(string)
  default = [
    # "10.21.22.65",
    # "10.21.22.66",
    # "10.21.22.67",
    # "10.21.22.68",
    # "10.21.22.69",
  ]
}


locals {
  vm_name = "ubuntu"
  vms = {
    for ip in var.ips : ip => {
      ip       = ip
      hostname = "${local.vm_name}-${split(".", ip)[length(split(".", ip)) - 1]}"
    }
  }
}

resource "vsphere_virtual_machine" "vm" {
  for_each          = local.vms
  name              = each.value.hostname
  resource_pool_id  = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id      = data.vsphere_datastore.datastore.id
  num_cpus          = 4
  memory            = 4096
  guest_id          = data.vsphere_virtual_machine.template.guest_id
  scsi_type         = data.vsphere_virtual_machine.template.scsi_type
  nested_hv_enabled = true
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = 100
    thin_provisioned = true
  }
  cdrom {
    client_device = true
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }
  extra_config = {
    "guestinfo.userdata" = base64encode(templatefile("user-data.yaml.tpl", {
      "hostname"      = each.value.hostname
      "nerdctl"       = false
      "docker_dind"   = false
      "docker_ce"     = false
      "docker_ubuntu" = false
      "k8s_tools"     = false
      "helm"          = false
      "k9s"           = false
      "neofetch"      = false
      "k3s"           = false
    }))
    "guestinfo.userdata.encoding" = "base64"

    "guestinfo.metadata" = base64encode(templatefile("meta-data.yaml.tpl", {
      "ipv4" = each.value.ip
    }))
    "guestinfo.metadata.encoding" = "base64"
  }
}
