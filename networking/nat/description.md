To apply
2) required permissions for service account: editor, compute network admin, security admin
3) import domain with ``terraform import google_dns_managed_zone.website testsite1632122049153-com``
4) run ```terraform apply```

To destroy
2) remove from state dns zone: ```terraform state rm google_dns_managed_zone.website```
3) run ```terraform destroy```

To run example:
1) run server ```node server/server.js```
2) run ngrok ```ngrok http 8080```
3) login to public instance and try ```curl <ngrok_http_address>```
4) login to private instance through public instance ```gcloud compute ssh instance-private --internal-ip```