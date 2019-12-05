# Create a new Ubuntu 18.04 t2.micro instance

resource "aws_instance" "server_web" {
  ami           = "ami-02df9ea15c1778c9c"
  instance_type = "t2.micro"
  key_name 	= "key_terraform"
  vpc_security_group_ids = [
                  "${aws_security_group.allow_ssh.id}",
                  "${aws_security_group.allow_updates.id}",
                  "${aws_security_group.open_nginx_port.id}"
]

tags = {
    Name = "server_web"
  }

provisioner "local-exec" {
    command = "sleep 30s && ansible-playbook -u ubuntu -i '${self.public_ip},' --key-file 'key_terraform.pem' install_web.yml"
   }

connection {
     type       = "ssh"
     host = "${aws_instance.server_web.public_ip}"
     user       = "ubuntu"
     private_key= "${file("key_terraform.pem")}"
    }

provisioner "remote-exec" {
    inline = [
    "sudo chmod o+w /var/www/html"
     ]
    }
}

output "web_public_ip" {
  value = "${aws_instance.server_web.public_ip}"
  }
