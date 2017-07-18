provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "ACCESS_KEY_HERE"
  region     = "eu-west-1"
}
resource "aws_instance" "App" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"

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