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


resource "vsphere_virtual_machine" "vm" {
  name             = "clone_test"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 1
  memory           = 1024
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
    # customize {
    #   linux_options {
    #     host_name = "foo"
    #     domain    = "example.com"
    #   }
    # }
  }
  extra_config = {
    "guestinfo.userdata"          = var.userdata
    "guestinfo.userdata.encoding" = "base64"
    "guestinfo.metadata"          = "aW5zdGFuY2UtaWQ6IGNsb3VkLXZtCmxvY2FsLWhvc3RuYW1lOiBjbG91ZC12bQpuZXR3b3JrOgogIHZlcnNpb246IDIKICBldGhlcm5ldHM6CiAgICBpbnRlcmZhY2UwOgogICAgICBtYXRjaDoKICAgICAgICBuYW1lOiBlbnMqKgogICAgICBkaGNwNDogbm8KICAgICAgYWRkcmVzc2VzOgogICAgICAgIC0gMTAuMjEuMjIuMjIvMjQKICAgICAgZ2F0ZXdheTQ6IDEwLjIxLjIyLjEKICAgICAgbmFtZXNlcnZlcnM6CiAgICAgICAgYWRkcmVzc2VzOgogICAgICAgICAgLSAyMjMuNS41LjUKICAgICAgICAgIC0gOC44LjguOA=="
    "guestinfo.metadata.encoding" = "base64"
  }
}
