module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = var.aws_vpc_name
  cidr = var.aws_vpc_cidr

  azs             = var.aws_vpc_azs
  private_subnets = var.aws_vpc_private_subnets
  public_subnets  = var.aws_vpc_public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = merge(var.aws_project_tags, { "kubernetes.io/cluster/${var.aws_eks_name}" = "shared" })

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.aws_eks_name}" = "shared"
    "kubernetes.io/role/elb"                    = 1
  }

  private_subnet_tags = {
    "kubernets.io/cluster/${var.aws_eks_name}" = "shared"
    "kubernets.io/role/internal-elb"           = 1
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.10.0"

  cluster_name    = var.aws_eks_name
  cluster_version = "1.29"

  enable_cluster_creator_admin_permissions = true

  subnet_ids = module.vpc.private_subnets

  vpc_id                         = module.vpc.vpc_id
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      min_size       = 2
      max_size       = 2
      desired_size   = 2
      instance_types = var.aks_managed_node_groups_instance_types
      tags           = var.awsvar.aws_project_tags
    }
  }

  tags = var.aws.aws_project_tags
}