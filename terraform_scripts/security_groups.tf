# Adding SSH access to EC2 instances

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    # SSH 
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "open_nginx_port" {
  name        = "open_nginx_port"
  description = "Open Nginx to all inbound traffic"

  ingress {
    # SSH
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "open_nginx_port"
  }
}

resource "aws_security_group" "open_jenkins_port" {
  name        = "open_jenkins_port"
  description = "Open Jenkins to all inbound traffic"

  ingress {
    # SSH
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "open_jenkins_port"
  }
}

resource "aws_security_group" "allow_updates" {
  name        = "allow_updates"
  description = "Allow outbound traffic for package updated purpose"

  egress {
    # Outbound traffic
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_updates"
  }
}
