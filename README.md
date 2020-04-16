### K8S module for GCP. Dynamic update dns zone from ingress or service

#### If you want add dns recods for service, please add annotaions in service: `external-dns.alpha.kubernetes.io/hostname: {{nginx.example.com.}}`

#### If you want change ingress dynamic update url, please add  annotations in ingress: `external-dns.alpha.kubernetes.io/hostname: nginx-fall.local.luminant.space.`