provider vsphere {
  user                  = var.user
  password              = var.password
  vsphere_server        = var.vsphere_server
  allow_unverified_ssl  = true
}

data "vsphere_datacenter" "dc" {
  name                      = var.data_center
}

data "vsphere_compute_cluster" "cluster" {
  name                      = var.cluster
  datacenter_id             = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name                      = var.workload_datastore
  datacenter_id             = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name                      = "vlan123-ITOM-IPV6-HYBRID04"
  datacenter_id             = data.vsphere_datacenter.dc.id
}
data "vsphere_virtual_machine" "vm_template" {
  name                      = "/IPV6-HYB/vm/projectautodeploy/windowstemplate/win2019-dc-temp"
  datacenter_id             = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "test" {
  name                      = var.vmname
  resource_pool_id          = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id              = data.vsphere_datastore.datastore.id
  folder                    = "projectautodeploy"
  num_cpus                  = 4
  memory                    = 8192
  guest_id                  = data.vsphere_virtual_machine.vm_template.guest_id

  scsi_type                 = data.vsphere_virtual_machine.vm_template.scsi_type
  firmware                  = "efi"

  provisioner "remote-exec" {
    connection {
      type = "winrm"
      user = var.windowsuser
      password = var.windowsuserpassword
      host = "${vsphere_virtual_machine.test.default_ip_address}"
      https = false
      insecure = true
    }

    inline = var.installation_commands
  }

  network_interface {
    network_id              = data.vsphere_network.network.id
  }
#wait_for_guest_net_timeout = 0

  disk {
    label                   = "disk0"
    size                    = data.vsphere_virtual_machine.vm_template.disks.0.size
   thin_provisioned         = data.vsphere_virtual_machine.vm_template.disks.0.thin_provisioned
  }

  clone {
    template_uuid           = data.vsphere_virtual_machine.vm_template.id
    }
}
