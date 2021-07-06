/*
output "alb_hostname" {
  value = aws_lb.pointlinq.dns_name
}
*/
output "elasticsearch_ip" {
  value = aws_instance.elasticsearch.private_ip
}
output "logstash_ip" {
  value = aws_instance.logstash.private_ip
}
output "kibana_url" {
  value = "http://${aws_instance.kibana.public_ip}:5601"
}

/*
#### ELK security_groups output ####
output "elk_sc_id" {
    value = aws_security_group.elk_sc_default.id
}

output "esearch_sc_id" {
    value = aws_security_group.elk_sc_esearch.id
}

output "elasticsearch_sc_id" {
    value = aws_security_group.elasticsearch.id
}
*/
