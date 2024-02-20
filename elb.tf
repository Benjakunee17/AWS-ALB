/**
 * Create by : Benja kuneepong
 * Date : Thu, Sep  7, 2023  8:35:59 AM
 * Purpose : สร้าง ALB สำหรับ aurora http server
 */

resource "aws_lb" "alb_to_server" {
  name               = "${var.service_name}-${var.system_name}-${var.environment}-alb"
  internal           = true
  load_balancer_type = "application"
  subnets            = [var.subnet_app_b, var.subnet_app_c]
  security_groups     = ["${aws_security_group.alb_sg.id}"]

  enable_deletion_protection = false
  idle_timeout               = "60"
  enable_http2               = true
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-alb"
  }
}

resource "aws_lb_target_group" "http_server_tg" {
  name        = "${var.service_name}-${var.system_name}-${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-tg"
  }
}

 resource "aws_lb_listener" "http_server_listener" {
  load_balancer_arn = aws_lb.alb_to_server.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:elasticloadbalancing:ap-southeast-1:292572860030:targetgroup/tf-benja-http-lb-tg/6b58563337ee15a9"
  default_action {
    type             = "redirect"
    target_group_arn = "${aws_lb_target_group.http_server_tg.arn}"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-listener"
  }
}

# resource "aws_lb_listener" "https_server_listener" {
#   load_balancer_arn = aws_lb.alb_to_server.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "${var.ssl_policy}"
#   certificate_arn   = "${var.certificate_arn}"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.http_server_tg.arn
#   }

#   lifecycle {
#     create_before_destroy = true
#   }

#   tags = {
#     Name = "${var.service_name}-${var.system_name}-${var.environment}-https-listener"
#   }
# }

resource "aws_lb_target_group_attachment" "http_server_1_tg" {
  target_group_arn = aws_lb_target_group.http_server_tg.arn
  target_id        = aws_instance.ec2-instance.id
  port             = 80
}
