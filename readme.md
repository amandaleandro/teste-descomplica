# DESCOSHOP
UMA PLATAFORMA RESPONSAVEL PARA VENDA E EXIBICÀO DE CURSOS, COMPOSTA DE BACKEND EM KUBERNETS E FRONTEND COM S3 COM CLOUDFRONT  E BANCO DE DADOS POSTGRES RDS

# PRE REQUISITOS 
terraform
kubectl 
helm 
aws cli
grafana 
git actions

## usage
cd infra/cluster-eks/
terraform init 
terraform validate
terraform apply

cd infra/buckets3/
terraform init 
terraform validate
terraform apply

