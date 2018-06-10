provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "aws_instance" "example" {
  ami = "${lookup(var.ami,var.region)}"

  connection = {
    user        = "ubuntu"
    private_key = "${file("${lookup(var.keypath,var.region)}")}"
  }

  instance_type   = "${var.instance}"
  security_groups = ["${aws_security_group.default.name}"]
  depends_on      = ["aws_security_group.default"]
  key_name        = "${lookup(var.key,var.region)}"

  tags {
    Name = "${var.Ec2Tag}"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt-get update",
      "sudo apt-get install apache2 -y",
    "sudo sh -c 'echo hi > /var/www/html/index.html'",
"wget https://raw.githubusercontent.com/rajeev8080/tfscript/master/php.sh -O /tmp/php.sh",
"chmod +x /tmp/php.sh",
"sh /tmp/php.sh" 
]
  }

provisioner "local-exec" {
    command = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
  }

}

resource "aws_security_group" "default" {
  name        = "Public-SG"
  description = "Created by terraform"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

