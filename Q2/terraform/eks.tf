module "eks" {

source="terraform-aws-modules/eks/aws"

cluster_name="asiyo"

cluster_version="1.31"

vpc_id=module.vpc.vpc_id

subnet_ids=module.vpc.private_subnets

eks_managed_node_groups={

main={

instance_types=["t3.large"]

desired_size=2

min_size=2

max_size=5

}
}

}