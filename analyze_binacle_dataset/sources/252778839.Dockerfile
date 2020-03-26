FROM bukj/php7-node-docker-ci:slim  
  
RUN composer global require jakub-onderka/php-parallel-lint  
RUN composer global require phpstan/phpstan-nette

