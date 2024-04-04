terraform {
  backend "s3" {
    endpoints = {
      s3 = var.s3-url
    }
    bucket = "terraform"
    key = var.bucket-path
    region = "main"
    access_key = var.s3-access-key
    secret_key = var.s3-secret-key
    skip_credentials_validation = true
    skip_requesting_account_id = true
    skip_metadata_api_check = true
    skip_region_validation = true
    use_path_style = true
    workspace_key_prefix = ""
  }
}

provider vsphere {
  user                  = var.user
  password              = var.password
  vsphere_server        = var.vsphere_server
   #version = ">= 1.0"  
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
  name                      = "portGroup-1004"
  datacenter_id             = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "vm_template" {
  name                      = "kuntest-template"
  datacenter_id             = data.vsphere_datacenter.dc.id
}

data "vsphere_guest_os_customization" "gosc1" {
name          = "Windows2022_Standard_Customization_Spec"
}

resource "vsphere_virtual_machine" var.vmname {
  name                      = var.vmname
  resource_pool_id          = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id              = data.vsphere_datastore.datastore.id
  #folder                    = "dev_zone"
  num_cpus                  = 4
  memory                    = 8192
  guest_id                  = data.vsphere_virtual_machine.vm_template.guest_id
  scsi_type                 = data.vsphere_virtual_machine.vm_template.scsi_type
#  firmware                 = "efi"

  network_interface {
    network_id              = data.vsphere_network.network.id
  }
  
  wait_for_guest_net_timeout = 0

  disk {
    label                   = "disk0"
    size                    = data.vsphere_virtual_machine.vm_template.disks.0.size
   thin_provisioned         = data.vsphere_virtual_machine.vm_template.disks.0.thin_provisioned
  }

  clone {
    template_uuid           = data.vsphere_virtual_machine.vm_template.id
    customization_spec {
		  id = data.vsphere_guest_os_customization.gosc1.id
    }
  }
  
	provisioner "remote-exec" {
  	connection {
  		type     = "winrm"
  		user     = "Administrator"
  		password = "Tol3r8t3now!"
  		host        = self.default_ip_address
  		port     = 5986
  		https    = true
  		insecure    = true
  		timeout  = "15m"
  	 }

  	inline = var.instalation_script

  }
}
