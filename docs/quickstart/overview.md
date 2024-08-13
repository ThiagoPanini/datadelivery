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

</div>

## Visão Geral

O `datadelivery` é um módulo [Terraform](https://www.terraform.io/) que permite com que seus usuários criem recursos de infraestrutura em suas respectivas contas AWS visando aprimorar os primeiros passos na **exploração de dados** utilizando serviços de Analytics. Isto é feito através de processos já embarcados no módulo, tais como:

- 🪣 Criação de buckets S3 seguindo uma [arquitetura Data Mesh](https://www.datamesh-architecture.com/) ou [arquitetura medalhão](https://medium.com/@junshan0/medallion-architecture-what-why-and-how-ce07421ef06f)
- 🎲 Upload automático de datasets públicos em bucket S3
- 📦 Upload opcional de datasets customizados fornecidos pelo usuário
- ⏳ Agendamento automático de um Glue Crawler para criação de tabelas para os datasets
- 🔒 Criação de *policies* e *roles* IAM para execução do Glue Crawler
- 📈 Criação de um *workgroup* do Athena para facilitar a execução de *queries*

<small>
  :octicons-tools-16:
  **Um ambiente de bolso!** Como um módulo Terraform, todos os recursos proporcionados pelo `datadelivery` podem ser implantados através de um **único comando** (`terraform apply`). Da mesma forma, os usuários podem simplesmente eliminar todos estes recursos sempre que quiserem também com um **único comando** (`terraform destroy`).
</small>

## Pré Requisitos

Para utilizar o `datadelivery`, usuários precisam:
In order to start using `datadelivery`, users will need:

- ☁️ Ter uma [conta AWS](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/) disponível para uso
- 🔑 [Acesso programático](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html) nessa conta AWS via chaves `access_key_id` e `secret_access_key`
- ⛏ [Terraform](https://www.terraform.io/) instalado

## Chamando o Módulo

Com o ambiente preparado, usuários podem criar um arquivo Terraform de extensão `.tf` e chamar o módulo `datadelivery` no seguinte formato:

```python
# Chamando o módulo datadelivery com as configurações padrão
module "datadelivery" {
  source = "git::https://github.com/ThiagoPanini/datadelivery"
}
```

<small>
  :octicons-light-bulb-16:
  **Dica:** se você tem dúvidas sobre como configurar um projeto Terraform para a chamada de módulos, expanda o bloco abaixo para visualizar demonstrações práticas em um passo a passo completo utilizando o módulo `datadelivery`.
</small>

??? tip "Configuração básica de um projeto Terraform (passo a passo datadelivery)"
    Para quem possui pouca experiência com o Terraform e precisa de um guia detalhado sobre como utilizar o módulo `datadelivery` na prática, o processo poderia ser resumido nos seguintes passos:

    1. Criação de um diretório para organizar seu projeto Terraform
    2. Criação de um arquivo Terraform neste diretório (ex: arquivo `main.tf`)
    3. Escrever o código Terraform neste arquivo para chamar o módulo `datadelivery` (ver [código acima](#chamando-o-módulo))
    4. Usando um terminal ou uma IDE, execute o comando `terraform init` para inicializar os módulos chamados
    5. Para visualizar os recursos a serem criados em sua conta AWS, execute o comando `terraform plan`
    6. Por fim, para implantar os recursos, execute o comando `terraform apply`

    Um [módulo Terraform](https://developer.hashicorp.com/terraform/language/modules) pode ser chamado através de uma série de [origens](https://developer.hashicorp.com/terraform/language/modules/sources) em qualquer projeto Terraform.

    Um projeto Terraform pode ser qualquer diretório que possua arquivos Terraform e que, nada mais são, do que arquivos de extensão `.tf` onde os recursos de infraestrutura são configurados através de uma [linguagem declarativa](https://en.wikipedia.org/wiki/Declarative_programming) chamada [HCL](https://developer.hashicorp.com/terraform/language) (*Hashicorp Configuration Language*).

    Assim, vamos estruturar este passo a passo criando um arquivo Terraform chamado `main.tf` para armazenar nosso código Terraform.

    ??? example "Criando um projeto Terraform"
        ![Criando arquivo main.tf em um projeto Terraform](https://github.com/ThiagoPanini/datadelivery/blob/v1.0.x/docs/quickstart/_assets/gifs/datadelivery-quickstart-01-maintf.gif?raw=true)

    Uma vez criado o projeto Terraform (isto é, pelo menos um arquivo `.tf` em um diretório qualquer), podemos declarar os recursos a serem implantados. Neste caso, os recursos estão encapsulados em um módulo Terraform. A chamada de módulos exige, essencialmente, apontar para a [origem](https://developer.hashicorp.com/terraform/language/modules/sources) onde o código fonte do módulo está armazenado e isto pode ser diretórios locais, URLs HTTP, repositórios no GitHub, buckets no S3 e muitos outros.
    
    O código fonte do módulo `datadelivery` está hospedado em um repositório no GitHub e, dessa forma, sua chamada pode ser realizada conforme o exemplo abaixo:

    ??? example "Chamando o módulo datadelivery"
        ![Declarando um bloco de chamada de módulo para implantar os recursos encapsulados no módulo datadelivery](https://github.com/ThiagoPanini/datadelivery/blob/v1.0.x/docs/quickstart/_assets/gifs/datadelivery-quickstart-02-module.gif?raw=true)

    E assim, podemos executar os comandos Terraform para obter os recursos encapsulados no módulo `datadelivery` na conta AWS alvo. O primeiro desses comandos atua como uma espécie de "aperte play para continuar" e auxilia os usuários a obterem toda a lógica do módulo em seu diretório/workspace de trabalho. Trata-se do `terraform init` e veremos como ele funciona no exemplo abaixo:

    ??? example "Inicializando o módulo com terraform init"
        ![Inicializando o módulo com terraform init](https://github.com/ThiagoPanini/datadelivery/blob/v1.0.x/docs/quickstart/_assets/gifs/datadelivery-quickstart-03-init.gif?raw=true)

    Após isso, nós podemos verificar exatamente quais recursos AWS serão criados, alterados ou até mesmo eliminados através da chamada deste módulo. O comando para ter essa visão é o `terraform plan` e seu retorno é um verdadeiro plano de implantação do Terraform no *provider* alvo.

    ??? example "Planejamento a implantação com terraform plan"
        ![Planejamento a implantação com terraform plan](https://github.com/ThiagoPanini/datadelivery/blob/v1.0.x/docs/quickstart/_assets/gifs/datadelivery-quickstart-04-plan.gif?raw=true)

    Por fim, após inicializar o módulo e validar o plano de implantação, podemos seguir, de fato, com a implantação através do comando `terraform apply`.

    ??? example "Implantando os recursos com terraform apply"
        ![Implantando os recursos com terraform apply](https://github.com/ThiagoPanini/datadelivery/blob/v1.0.x/docs/quickstart/_assets/gifs/datadelivery-quickstart-05-apply.gif?raw=true)
    
    E é assim que podemos criar um projeto Terraform e chamar módulos em qualquer ambiente de trabalho. No caso do `datadelivery`, o usuário poderá, após sua implantação, navegar até sua conta AWS e verificar os recursos criados para facilitar a jornada de exploração de dados com serviços de Analytics, tais como buckets no S3, tabelas no Glue Data Catalog, entre outros.

## Recursos Implantados

Uma vez chamado o módulo `datadelivery`, por padrão, alguns recursos são disponibilizados instantaneamente na conta AWS alvo da chamada. O GIF abaixo demonstra uma navegação em uma conta AWS através do management console e passa por alguns dos recursos criados pelo módulo.

???+ example "Recursos criados pelo módulo datadelivery"
    ![Recursos implantados na conta AWS alvo](https://github.com/ThiagoPanini/datadelivery/blob/v1.0.x/docs/quickstart/_assets/gifs/datadelivery-usage-demo.gif?raw=true)

    O GIF acima, apesar de extenso, mostra toda uma navegação no AWS Management Console e evidencia os recursos criados, tais quais:

    - Buckets no S3 (guidados pela variável `var.bucket_names_map` do módulo)
    - Arquivos físicos separados em diferentes prefixos e que simulam datasets públicos previamente escolhidos
    - Glue Crawler agendado automaticamente (delay de agendamento guiado pela variável `var.delay_to_run_crawler` do módulo)
    - Tabelas no Glue Data Catalog geradas através da execução do Glue Crawler

## Variáveis do Módulo 

O módulo `datadelivery` possui variáveis que podem ser configuradas pelos usuários para personalizar os recursos a serem implantados na conta AWS alvo. Para visualizar quais variáveis são aceitas e suas respectivas descrições, navegue até a página de [variáveis](./variables.md) desta documentação.
