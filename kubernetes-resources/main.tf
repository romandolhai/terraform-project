# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

data "terraform_remote_state" "eks" {
  backend = "local"
  config = {
    path = "../eks-cluster/terraform.tfstate"
  }
}

# Retrieve EKS cluster configuration

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}


data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
    command     = "aws"
  }
}

# Create namespaces required for cert-manager and nginx ingress

resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
}
resource "kubernetes_namespace" "ingress-nginx" {
  metadata {
    name = "ingress-nginx"
  }
}
