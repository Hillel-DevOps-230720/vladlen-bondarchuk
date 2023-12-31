resource "aws_instance" "app" {
ami = "ami-01df11c049ae5c039"
instance_type = "t2.micro"
key_name = "lab-key"
vpc_security_group_ids = [aws_security_group.app.id]
tags = {
Name = "App server"
project = "Devops"

}

depends_on = [aws_instance.db]


connection {
type = "ssh"
host = self.public_ip
user = "ec2-user"
private_key = file("~/.ssh/lab-key.pem")
}

provisioner "remote-exec" {
    inline = [
      # Додавання запису в /etc/hosts
      "echo '${aws_instance.db.private_ip} db.server' | sudo tee -a /etc/hosts",	
    ]
  }

provisioner "file" {
source = "files/myapp.service"
destination = "/tmp/myapp.service"
}

provisioner "remote-exec" {
script = "files/deploy.sh"

}
}
