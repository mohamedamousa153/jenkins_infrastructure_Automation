
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Security group for EC2 instance"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 22 # SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere
  }

  ingress {
    from_port   = 443 
    to_port     = 443
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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

resource "aws_key_pair" "my_key" {
  key_name   = "ec2_public_key2"
  public_key = file("./id_rsa.pub") # Path to your public key file
}

resource "aws_instance" "ec2_test" {
  ami                    = "ami-080e1f13689e07408" # Specify the AMI ID of your choice
  instance_type          = "t2.micro"    # Instance type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = aws_key_pair.my_key.key_name
  security_groups        = [aws_security_group.instance_sg.id]
}


resource "null_resource" "append_public_ip" {
  provisioner "local-exec" {
    command = "echo ${aws_instance.ec2_test.public_ip} > /var/jenkins_home/workspace/first/ansible/inventory"
  }
}

