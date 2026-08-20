# Caronas UFF

Sistema de gerenciamento de caronas para a comunidade da Universidade Federal Fluminense (UFF), desenvolvido em **Ruby on Rails**. O objetivo do projeto é facilitar a organização de caronas entre os alunos que se deslocam entre os diferentes campi da UFF, otimizando tempo, custo e reduzindo a quantidade de veículos individuais em circulação.

Este projeto foi desenvolvido individualmente por mim como parte do treinamento de integração do estágio na **STI (Superintendência de Tecnologia da Informação) da UFF**.

## Sobre o projeto

A UFF possui múltiplos campi espalhados por Niterói e região, e é comum que alunos precisem se deslocar entre eles ao longo do dia. O Caronas UFF nasceu para resolver esse problema, permitindo que qualquer aluno ofereça ou busque caronas de forma simples, rápida e organizada.

## Funcionalidades

- **Oferta de caronas**: criação de caronas informando origem, destino, data, horário e profissional/motorista responsável
- **Pontos intermediários**: suporte a paradas que não são necessariamente campus, como pontos de referência ao longo do trajeto
- **Observações**: campo livre para detalhes adicionais relevantes sobre a carona (bagagem, restrições, preferências, etc.)
- **Edição e exclusão** de caronas já cadastradas
- **Consulta de caronas**: listagem de todas as caronas disponíveis
- **Busca inteligente**: sistema de busca por caronas relevantes com **autocomplete** de locais e campus
- **Filtros avançados**: possibilidade de busca por bairro, cidade e outros detalhes específicos do trajeto

## Tecnologias utilizadas

- **Ruby on Rails** — framework principal da aplicação
- **RSpec** — testes automatizados
- **Active Record** — ORM e gerenciamento do banco de dados via migrations (banco padrão do Rails)

## Como executar o projeto

### Pré-requisitos

- Ruby (verifique a versão exigida em `.ruby-version`)
- Rails
- Bundler
- Banco de dados configurado (ver `config/database.yml`)

### Passo a passo

```bash
# Clone o repositório
git clone https://github.com/WallacePimentel/caronas-uff.git
cd caronas-uff

# Instale as dependências
bundle install

# Configure o banco de dados (padrão Rails)
rails db:create
rails db:migrate

# (Opcional) Popule o banco com dados de exemplo
rails db:seed

# Inicie o servidor
rails server
```

Acesse a aplicação em `http://localhost:3000`.

### Rodando os testes

```bash
bundle exec rspec
```

## Contexto do projeto

Este projeto foi desenvolvido em **janeiro e fevereiro de 2026**, como parte do treinamento técnico do estágio de Desenvolvimento Full Stack na STI-UFF, servindo como projeto prático para consolidar conhecimentos em Ruby on Rails aplicados a um caso de uso real da própria universidade.

## Autor

**Wallace da Rocha Pimentel Júnior**

- LinkedIn: [linkedin.com/in/wallace-pimentel](https://www.linkedin.com/in/wallace-pimentel-b5643021a/)
- GitHub: [@WallacePimentel](https://github.com/WallacePimentel)
