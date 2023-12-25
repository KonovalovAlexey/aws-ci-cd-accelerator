data "aws_route53_zone" "poc" {
  name   = var.route53_zone_name
}

# Create record ALB for region
resource "aws_route53_record" "region_record" {
  count   = length(var.environments)
  zone_id = data.aws_route53_zone.poc.zone_id
  name    = "${var.dns_record_names[count.index]}-${var.region}"
  type    = "A"

  alias {
    name                   = aws_lb.app.dns_name
    zone_id                = aws_lb.app.zone_id
    evaluate_target_health = true
  }
}

# Create record for example.com with routing base on "Latency"
resource "aws_route53_record" "main_record" {
  count   = length(var.environments)
  zone_id = data.aws_route53_zone.poc.zone_id
  name    = var.dns_record_names[count.index]
  type    = "A"

  set_identifier = var.region

  alias {
    name                   = aws_lb.app.dns_name
    zone_id                = aws_lb.app.zone_id
    evaluate_target_health = true
  }

  latency_routing_policy {
    region = var.region
  }
}