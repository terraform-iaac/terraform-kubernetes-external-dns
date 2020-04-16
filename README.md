### K8S module for GCP. Dynamic update dns zone from ingress or service

#### If you want add dns recods for service, please add annotaions in service: `external-dns.alpha.kubernetes.io/hostname: {{nginx.example.com.}}` Also service must be NodePort or LoadBalancer

#### If you want change ingress dynamic update url, please add  annotations in ingress: `external-dns.alpha.kubernetes.io/hostname: {{nginx-fall.example.com.}}`

#### External dns will update resource with annotations `external-dns: use`, you can chagne this value.
#### Note: Your node pool must exist next oauth scope: `"https://www.googleapis.com/auth/ndev.clouddns.readwrite"`