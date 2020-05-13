provider "aws" {
  region     = "us-east-2"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "myServer1" {                    # nazva servera "myServer1"
  count = 1                                              # ukazuem skilku xochem takux serveriv
  ami                    = "ami-0e38b48473ea57778"
  vpc_security_group_ids = [aws_security_group.DMZ.id]  #pruednuem security group do instansa imja yogo DMZ i yogo id
  instance_type          = "t2.micro"                   #["sg-f11111", "sg-f22222"] - mojem tak she dobavljaty securety group
  user_data              = file("user_data.tpl")        #user_data ./dir/user_data.tpl
  tags    = {
    Name  = "web-server"
    owner = "IvanD"
  }
  /* resource "aws_instance" "myServer2" {
    ami           = "ami-0e38b48473ea57778"
    vpc_security_group_ids = [aws_security_group.DMZ1.id] */
      /*
  resource "aws_eip" "my_static_ip" {
  instance = aws_instance.myServer1.id
  tags = {
    Name  = "Web Server IP"
    Owner = "IvanD"
  }   */
}
resource "aws_security_group" "DMZ" {
  name        = "DMZ-Security Groups"
  description = "my first security group"
ingress {
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]           # add a CIDR block here
 }
 ingress {
   from_port   = 443
   to_port     = 443
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 egress {                               # vuxodjashuy trafic iz servera
   from_port   = 0
   to_port     = 0
   protocol    = "-1"                  # -1 to lubuy protokol dostypnuy
   cidr_blocks = ["0.0.0.0/0"]
 }
tags = {
 Name  = "Secur Grop for terraform"
 owner = "Ivan D"
}
}

/*s3
resource "aws_s3_bucket" "buckets" {
 count = 3
 bucket = "My-Multi-Bucket-${count.index+1}"  */
