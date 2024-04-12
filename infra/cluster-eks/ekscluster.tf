resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
    count                   = 3
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.${count.index}.0/24"
    map_public_ip_on_launch = true
}
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.27"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }
    vpc_id     = aws_vpc.main.id
    subnet_ids = aws_subnet.main.*.id

  # Self Managed Node Group(s)
  self_managed_node_group_defaults = {
    instance_type                          = "t3a.medium"
    update_launch_template_default_version = true
    iam_role_additional_policies = {
      AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    }
  }

  self_managed_node_groups = {
    one = {
      name         = "mixed-1"
      max_size     = 3
      desired_size = 1

      use_mixed_instances_policy = true
      mixed_instances_policy = {
        instances_distribution = {
          on_demand_base_capacity                  = 0
          on_demand_percentage_above_base_capacity = 10
          spot_allocation_strategy                 = "capacity-optimized"
        }

        override = [
          {
            instance_type     = "t3a.medium"
            weighted_capacity = "1"
          },
          {
            instance_type     = "t3.medium"
            weighted_capacity = "2"
          },
        ]
      }
    }
  }

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3a.medium", "t3a.large"]
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t3a.large"]
      capacity_type  = "SPOT"
    }
  }

  # aws-auth configmap
  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::66666666666:role/role1"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::account-id:user/user-id"
      username = "user1"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_accounts = [
    "account-id",
  ]

  tags = {
    Environment = "dev"
    Terraform   = "true"
    Autor       = "Amanda Leandro Soares"
  }
}
module "prometheus" {
  source  = "cloudposse/prometheus/aws"
  version = "0.12.0"

  namespace = "cp"
  stage     = "prod"
  name      = "app"

  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.main.*.id
}

module "grafana" {
  source  = "cloudposse/grafana/aws"
  version = "0.12.0"

  namespace = "cp"
  stage     = "prod"
  name      = "app"

  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.main.*.id

  security_groups = [module.prometheus.security_group_id]

  grafana_admin_user     = "admin"
  grafana_admin_password = "password"

  grafana_image_url = "grafana/grafana:7.3.5"

  grafana_provisioning_configmaps = [
    {
      configmap_namespace = kubernetes_namespace.grafana.metadata[0].name
      configmap_name      = kubernetes_config_map.grafana_provisioning.name
    }
  ]
}