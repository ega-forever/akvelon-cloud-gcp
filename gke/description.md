To apply
2) required permissions for service account: editor, compute network admin, security admin
3) import domain with ``terraform import google_dns_managed_zone.website testsite1632122049153-com``
4) run ```terraform apply```
5) add GKE dev context and under dev context run ```kubectl apply -k overlays/dev``` 
6) add GKE prod context and under prod context run ```kubectl apply -k overlays/prod``` 

To destroy
1) destroy all resources under GKE ```kubectl delete -k overlays/{environment}```
2) remove from state dns zone: ```terraform state rm google_dns_managed_zone.website```
3) run ```terraform destroy```