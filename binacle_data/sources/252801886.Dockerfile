FROM mysql  
  
MAINTAINER Eduardo Rozario <eduardoagrj@gmail.com>  
  
COPY mysql/utf8.cnf /etc/mysql/conf.d/  
  
ADD database/database.sql /docker-entrypoint-initdb.d/0.sql  
ADD foreign-key/foreign-key.sql /docker-entrypoint-initdb.d/1.sql  
ADD inserts/estado.sql /docker-entrypoint-initdb.d/2.sql  
ADD inserts/cidade.sql /docker-entrypoint-initdb.d/3.sql  
ADD inserts/bairro.sql /docker-entrypoint-initdb.d/4.sql  
ADD inserts/comprador.sql /docker-entrypoint-initdb.d/5.sql  
ADD inserts/vendedor.sql /docker-entrypoint-initdb.d/6.sql  
ADD inserts/imoveis.sql /docker-entrypoint-initdb.d/7.sql  
ADD inserts/oferta.sql /docker-entrypoint-initdb.d/8.sql  
ADD inserts/faixa_imovel.sql /docker-entrypoint-initdb/9.sql  

