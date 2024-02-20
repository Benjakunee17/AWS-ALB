/**
 * Create by : Benja kuneepong
 * Date : Thu, Aug 31, 2023 12:02:55 PM
 * Purpose : สร้าง key pair สำหรับ EC2
 */
resource "aws_key_pair" "ec2-instance" {
  key_name   = "ec2-aws"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLIFw7WjRivsI7yNAxEHrA92ubSbCFeVo1bMU273uJgweFvVMELnSFSgxJYoL1pi0YBTGauLTdN7mYV4AjWsfGvHYY5f8KWsOVWt0Ez2LMMbzu3huTDkn2b61hpzS60opz4jA/uW0fhBUz9c8x26rc2eyZzQx2AtLwA4YOwXQ8HQjYadJhf9pEhDgpFdkZ9ZUgt+mgvmcW6b2901yesT2GeFC6iGlcZYumv3Y8eONJfORL6tLnS3WVqyz5G6p3LHyxV1yz0sme4MYqkcwWZSmjE3azTAA64ZXrGhBTlhvfH1cAq+viYZVBL8ILmiFfJXkPVpX8pV1edlA3L8drgyKbdfZig6ppNNIFpxmq6Hl6utPpJgIFAb1g7k4tcOQzjw0QbpmUzv1B1hZ0Vna6o1YYM0sv7F7pj1Ji7qrUsTWVH44CiCy7dDnAqFimNl2vHerjAa2PjJJS2NRkGduy7m6EkckNVRRaOmurSmToWqF5fsW8ztc7eeQT+o96rFTKw88= benjakun@GOS-5CD917484N"

}

/**
 * Create by : Benja kuneepong
 * Date : Thu, Aug 31, 2023 12:02:55 PM
 * Purpose : สร้าง EC2 สำหรับ Project website laos
 */
resource "aws_instance" "ec2-instance" {
  ami                         = var.ec2_instance_image
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = false

  key_name               = aws_key_pair.ec2-instance.key_name
  subnet_id              = var.subnet_app_b
  vpc_security_group_ids = [aws_security_group.ec2_web.id,aws_security_group.ec2_linux.id]

  root_block_device {
    volume_size           = "80"
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name        = "${var.service_name}-${var.system_name}-ec2-instance-${var.environment}-linux-server"
    DailyBackup = "Daily1"
  }

  volume_tags = {
    Name        = "${var.service_name}-${var.system_name}-ec2-instance-${var.environment}-linux-server-test"
    Service     = var.service_name
    Owner       = var.owner_name
    System      = var.system_name
    Environment = var.environment
    Createby    = var.create_by_name
  }

  # Keep this ami always
  lifecycle {
    ignore_changes = [ami,volume_tags,user_data]
  }

}
resource "aws_ebs_volume" "ec2_instance_1" {
  availability_zone = "ap-southeast-1b"
  size              = 100
  type              = "gp3"
  
  tags = {
    Name = "${var.service_name}-${var.system_name}-ec2-instance-${var.environment}-data"
  }
}

resource "aws_volume_attachment" "ec2_instance_1" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.ec2_instance_1.id
  instance_id = aws_instance.ec2-instance.id
}
