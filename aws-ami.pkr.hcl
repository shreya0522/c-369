source "amazon-ebs" "ubuntu" {
  ami_name      = "nginx-ami"
  instance_type = "t2.micro"
  region        = "us-west-1"
  source_ami    = "ami-0a15fc3cf14435d43" 
  ssh_username  = "ubuntu"
}

build {
  name    = "nginx-3"
  sources = ["amazon-ebs.ubuntu"] 

  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /var/www/html/index.nginx-debian.html /var/www/html/index.html.backup",
      "sudo cp /tmp/index.html /var/www/html/",
      "sudo systemctl restart nginx"
    ]
  }
}
