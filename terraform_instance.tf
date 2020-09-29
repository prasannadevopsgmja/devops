resource "aws_instance" "testsystem1" {
    ami = "${lookup(var.AMI, var.Aws_Region)}"
    instance_type = "t2.micro"
    user_data = "${file("script.sh")}"
    key_name = "prasanna"
    vpc_security_group_ids = ["${aws_security_group.web_sg1.id}"]
    subnet_id = "${aws_subnet.main.id}" 
 
    tags = {
        Name = "testsystem1"
    }

}

resource "aws_security_group" "my_sg1" {
  name        = "my_sg1"
  description = "Allow http traffic"
  vpc_id      = "${aws_vpc.main_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
