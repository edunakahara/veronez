variable "aws_region" {
  description = "Região usada para criar os recurso AWS"
  type        = string
  nullable    = false
}

variable "aws_vpc_name" {
  description = "VPC default"
  type        = string
  nullable    = false
}

variable "aws_vpc_cidr" {
  description = "Range ip VPC"
  type        = string
  nullable    = false
}

variable "aws_vpc_azs" {
  description = "Available zones"
  type        = set(string) #string pq todas as azs estao na mesma região
  nullable    = false
}

variable "aws_vpc_private_subnets" {
  description = "subredes privadas da VPC"
  type        = set(string)
  nullable    = false
}

variable "aws_vpc_public_subnets" {
  description = "subredes publicas da VPC"
  type        = set(string)
  nullable    = false
}

variable "aws_eks_name" {
  description = "Registro nome EKS"
  type        = string
  nullable    = false
}

variable "aws_eks_version" {
  description = "subredes publicas da VPC"
  type        = string
  nullable    = false
}

variable "aks_managed_node_groups_instance_types" {
  description = "sempre colocar a descrição"
  type        = set(string)
  nullable    = false
}

variable "aws_project_tags" {
  description = "Colocar a descriçao"
  type        = map(any)
  nullable    = false
}