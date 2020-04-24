data "http" "ip" {
  url = "http://checkip.amazonaws.com/json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  external-cidr = "${jsondecode(data.http.ip.body)}/32" 
}
