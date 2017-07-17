# Configure the VMware vSphere Provider
provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

# Create a folder
resource "vsphere_folder" "HumanityLink" {
  path = "HumanityLink"
}

# Create a file
resource "vsphere_file" "ubuntu_disk_UPload" {
  datastore        = "local"
  source_file      = "/VDM/my_disks/HumanityLink_ubuntu.vmdk"
  destination_file = "/MAC_DC/disks/HumanityLink_ubuntu.vmdk"
}

# Create a disk image
resource "vsphere_virtual_disk" "extraStorage" {
  size       = 2
  vmdk_path  = "myDisk.vmdk"
  datacenter = "MAC Datacenter"
  datastore  = "VSAN_MAC"
}

# Create a virtual machine within the folder
resource "vsphere_virtual_machine" "Web01" {
  name   = "MAC-HLD-WEB01"
  folder = "${vsphere_folder.HumanityLink.path}"
  vcpu   = 8
  memory = 16384

  network_interface {
    label = "VM Network"
  }

  disk {
    template = "centos-7"
  }
}