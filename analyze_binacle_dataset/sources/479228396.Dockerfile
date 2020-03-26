FROM php:7-cli-alpine

LABEL "com.github.actions.name"="Php cs fixer"
LABEL "com.github.actions.description"="Lint php files against coding standards"
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/inextensodigital/actions"
LABEL "homepage"="http://github.com/inextensodigital"
LABEL "maintainer"="IED <contact@inextenso.digital>"

RUN wget https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.15.1/php-cs-fixer.phar -O /usr/local/bin/php-cs-fixer \
    && chmod a+x /usr/local/bin/php-cs-fixer

ENTRYPOINT ["php-cs-fixer", "fix", "--dry-run", "--diff"]