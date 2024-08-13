# Toolkit de Exploração de Dados na AWS

<div align="center">
    <br><img src="https://github.com/ThiagoPanini/datadelivery/blob/v1.0.x/docs/_assets/imgs/logo/logo-com-nome.png?raw=true" width=280 alt="datadelivery-logo">
</div>

<div align="center">

  <a href="https://www.terraform.io/">
    <img src="https://img.shields.io/badge/terraform-grey?style=for-the-badge&logo=terraform&logoColor=B252D0">
  </a>

  <a href="https://www.mkdocs.org/">
    <img src="https://img.shields.io/badge/mkdocs-grey?style=for-the-badge&logo=markdown&logoColor=B252D0">
  </a>

  <a href="https://readthedocs.org/">
    <img src="https://img.shields.io/badge/readthedocs-grey?style=for-the-badge&logo=readthedocs&logoColor=B252D0">
  </a>

  <a href="https://github.com/">
    <img src="https://img.shields.io/badge/github-grey?style=for-the-badge&logo=github&logoColor=B252D0">
  </a>

  <br>

  ![GitHub release (latest by date)](https://img.shields.io/github/v/release/ThiagoPanini/datadelivery?color=purple)
  ![GitHub Last Commit](https://img.shields.io/github/last-commit/ThiagoPanini/datadelivery?color=purple)
  ![CI workflow](https://img.shields.io/github/actions/workflow/status/ThiagoPanini/datadelivery/ci-main.yml?label=ci)
  [![Documentation Status](https://readthedocs.org/projects/datadelivery/badge/?version=latest)](https://datadelivery.readthedocs.io/en/latest/?badge=latest)

</div>

## Visão Geral

O `datadelivery` é um módulo [Terraform](https://www.terraform.io/) que permite com que seus usuários criem recursos de infraestrutura em suas respectivas contas AWS visando aprimorar os primeiros passos na **exploração de dados** utilizando serviços de Analytics. Isto é feito através de processos já embarcados no módulo, tais como:

- 🪣 Criação de buckets S3 seguindo uma [arquitetura Data Mesh](https://www.datamesh-architecture.com/) ou [arquitetura medalhão](https://medium.com/@junshan0/medallion-architecture-what-why-and-how-ce07421ef06f)
- 🎲 Upload automático de datasets públicos em bucket S3
- 📦 Upload opcional de datasets customizados fornecidos pelo usuário
- ⏳ Agendamento automático de um Glue Crawler para criação de tabelas para os datasets
- 🔒 Criação de *policies* e *roles* IAM para execução do Glue Crawler
- 📈 Criação de um *workgroup* do Athena para facilitar a execução de *queries*

## Quickstart

Qualquer usuário que tenha um projeto Terraform pode realizar a chamada ao módulo `datadelivery` passando, como fonte, a referência deste repositório no GitHub:

```python
# Chamando o módulo datadelivery com as configurações padrão
module "datadelivery" {
  source = "git::https://github.com/ThiagoPanini/datadelivery"
}
```

## Variáveis

O módulo `datadelivery` possibilita algumas customizações específicas de seus recursos implantados através do fornecimento de algumas variáveis que podem ser configuradas em tempo de chamada.

Para acessar a lista completa de variáveis atualmente aceitas pelo módulo, consulta sua [página oficial de documentação](https://datadelivery.readthedocs.io/pt/latest/quickstart/variaveis/).

## Readthedocs

📚 Para saber mais sobre essa iniciativa, acesse a [página oficial de documentação do módulo](https://datadelivery.readthedocs.io/pt/latest/). Lá, os usuários poderão encontrar todos os detalhes de construção da solução, demonstração de etapas, visão de arquitetura, entre outros tópicos relevantes.

## Entre em Contato

- GitHub: [@ThiagoPanini](https://github.com/ThiagoPanini)
- LinkedIn: [Thiago Panini](https://www.linkedin.com/in/thiago-panini/)
- Hashnode: [panini-tech-lab](https://panini.hashnode.dev/)
- DevTo: [thiagopanini](https://dev.to/thiagopanini)


## Referências


**Terraform**

- [Terraform - Creating Modules](https://developer.hashicorp.com/terraform/language/modules/develop)
- [Terraform - Using Modules](https://developer.hashicorp.com/terraform/language/modules)
- [Terraform - Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)
- [Medium - Maintaining Reusable Terraform Modules](https://arunksingh16.medium.com/maintaining-reusable-terraform-modules-in-github-d0440753e784)
- [Terraform - Filesystem and Workspace Info](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

**AWS Glue**

- [Glue Crawler Prerequisites](https://docs.aws.amazon.com/glue/latest/dg/crawler-prereqs.html)

**GitHub**

- [GitHub - terraform-validate Action](https://github.com/marketplace/actions/terraform-validate)
