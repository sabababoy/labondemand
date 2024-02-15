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
    
    customize {
      windows_options{
        computer_name         = "Auto-deploy-001"
        join_domain           = var.join_domain
        domain_admin_user     = var.domain_admin_user
        domain_admin_password = var.domain_admin_password
        auto_logon           = "false"
      # auto_logon_count     = "5"
      }
    }
  }
}
