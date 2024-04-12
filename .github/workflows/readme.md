# Projeto CI/CD com GitHub Actions

Este projeto utiliza GitHub Actions para implementar um pipeline de Integração Contínua/Entrega Contínua (CI/CD). O pipeline é definido no arquivo `cicd.yml`.

## Pré-requisitos

- Uma conta no GitHub
- AWS CLI instalado e configurado
- Terraform instalado

## Como usar

1. Clone o repositório:
   ```
   git clone <url do repositório>
   ```

2. Configure suas credenciais da AWS como segredos no repositório do GitHub. Vá para `Settings > Secrets` no seu repositório e adicione os seguintes segredos:
   - `AWS_REGION`
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

3. Faça alterações no seu código e faça commit das alterações. O pipeline de CI/CD será acionado automaticamente quando você fizer push das alterações para a branch `main`.

## Pipeline de CI/CD

O pipeline de CI/CD é composto por dois jobs:

1. `setup`: Este job configura o ambiente de execução e configura a AWS CLI com suas credenciais da AWS.

2. `provision-eks` (opcional): Este job executa o Terraform para provisionar um cluster EKS. Você pode configurar o backend do Terraform se necessário.

Por favor, note que este é apenas um exemplo de um pipeline de CI/CD e você pode precisar ajustá-lo para atender às suas necessidades específicas.