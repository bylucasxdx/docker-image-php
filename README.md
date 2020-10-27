### O que eu preciso saber sobre esse projeto
Esse projeto tem como função ajudar o desenvolvedor a testar uma aplicação nova em Laravel ou Lumen.

Para começar a utilizar você deve clonar um projeto desses frameworks para a pasta `/projects`;

Feito o clone da aplicação rode o comando abaixo para que a instalação e configuração prossigam;

### 1) Execute o arquivo `run.sh` da pasta raiz, podendo ser via terminal com por exemplo:

`sh ./run.sh`

#### Options
- `-p` Define a porta que o container do php vai rodar na sua máquina
- `-n` Define o nome do projeto utilizado para ser o volume do php
- `-v` Define a versão do PHP (7.2 ou 7.4)

Este comando ira executar uma série de passos que você poderá acompanhar via terminal, referente a:
1) Build
2) Instalação das dependências do framework lumen/laravel
3) Configurações base do Laravel/Lumen (.env, key:generate)
4) O ambiente pode ser acessado no http://localhost:PORT

#### Tutorial completo

```
# Clonando esse repositório
git clone https://github.com/bylucasxdx/docker-image-php.git

# Entrando na pasta de projetos
cd docker-image-php/projects

# Clonando o projeto que deseja testar
git clone URL_OUTRO_PROJETO.git

# Voltando para a raiz do projeto
cd ..

# Rodando o comando para preparar a aplicação
sh ./run.sh -n nome_projeto_clonado  
```

### Caso queira rodar os comando separadamente:

`docker-compose up --build -d `

`docker run --rm --interactive --tty -v $PWD/projects/project_name:/app composer install`

`docker exec -it php php /var/www/html/artisan migrate`

O ambiente pode ser acessado no http://localhost

### Importante

Sempre fique atento que não exista outro processo rodando nas portas 80, 9000 e 3306 pois serão as portas utilizadas ao executar o docker