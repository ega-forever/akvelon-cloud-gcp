To apply
2) required permissions for service account: editor, compute network admin, security admin
3) import domain with ``terraform import google_dns_managed_zone.website testsite1632122049153-com``
4) run ```terraform apply```

To destroy
2) remove from state dns zone: ```terraform state rm google_dns_managed_zone.website```
3) run ```terraform destroy```