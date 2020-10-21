### 1) Execute o arquivo `run.sh` da pasta raiz, podendo ser via terminal com por exemplo:

`sh ./run.sh`

Este comando ira executar uma série de passos que você poderá acompanhar via terminal, referente a:
1) Build
2) Install das dependências do framework lumen/laravel
4) O ambiente pode ser acessado no http://localhost

### 2) Execute os seguintes passos separadamente no seu terminal dentro da pasta do projeto:

`docker-compose up --build -d`

`docker run --rm --interactive --tty -v $PWD/lumen:/app composer install`

`docker exec -it php php /var/www/html/artisan migrate`

O ambiente pode ser acessado no http://localhost

### Importante

Sempre fique atento que não exista outro processo rodando nas portas 80, 9000 e 3306 pois serão as portas utilizadas ao executar o docker