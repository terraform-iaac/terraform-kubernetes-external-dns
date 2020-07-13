### Kubernetes external-dns module. Dynamic update dns zone from ingress or service

#### Requirments: 
   1. Google Cloud, add to node pool next oauth scope: `"https://www.googleapis.com/auth/ndev.clouddns.readwrite"`
      
      AWS, add policy to IAM role with route53 permissions
      
   2. Terraform version >=0.12.26
   3. Kubernetes provider >=1.11.1