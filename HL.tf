# This file is used to Upload HumanityLink install script and then execute script 

resource "aws_instance" "App" {
  # ...
# Upload HumanityLink install script
  provisioner "file" {
    source      = "Install_HL.sh"
    destination = "/tmp/HL/Install_HL.sh"
  }
# Execute HumanityLink install script on remote instance
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/HL/Install_HL.sh",
      "/tmp/HL/Install_HL.sh args",
    ]
  }
}
