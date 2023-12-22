# Terraform demo project
The idea of the project is to deploy EKS cluster and Kubernetes application secured with TLS letsencrypt certificate.
## Structure
```
├── eks-cluster # folder with manifest that deploys EKS cluster 
└── kubernetes-resources # folder with manifests that deploy cert-manager and ingress on previously deployed EKS cluster
    └── demo-app # folder with kubernetes application translated into terraform manifests (using tfk8s) to be deployed
```
