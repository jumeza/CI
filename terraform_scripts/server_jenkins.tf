# Create a new Ubuntu 18.04 t2.micro instance

resource "aws_instance" "server_jenkins" {
  ami           = "ami-02df9ea15c1778c9c"
  instance_type = "t2.micro"
  key_name 	= "key_terraform"
  vpc_security_group_ids = [
                  "${aws_security_group.allow_ssh.id}",
                  "${aws_security_group.allow_updates.id}",
                  "${aws_security_group.open_jenkins_port.id}"
]

tags = {
    Name = "server_jenkins"
  }

provisioner "local-exec" {
    command = "sleep 30s && ansible-playbook -u ubuntu -i '${self.public_ip},' --key-file 'key_terraform.pem' install_jenkins.yml"
   }

}

output "jenkins_public_ip" {
  value = "${aws_instance.server_jenkins.public_ip}"
  }
