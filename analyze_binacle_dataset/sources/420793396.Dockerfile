From php:5-apache
LABEL maintainer "Can Güney Aksakalli"

# Stacey v2.3.0
ENV STACEY_COMMIT=5cff57a35cfc3f30330d637443e25bec7c9dc6f3

RUN a2enmod rewrite \

    # install stacey
    && curl -fsSL "https://github.com/kolber/stacey/archive/$STACEY_COMMIT.tar.gz" -o stacey.tar.gz \
    && tar xf stacey.tar.gz && rm stacey.tar.gz \
    && mv ./stacey-$STACEY_COMMIT/* . \
    && rm -r stacey-$STACEY_COMMIT/ \

    # remove theme files
    && rm -r content \
    && rm -r public \
    && rm -r templates \

    # remove unnecessary files
    && rm -f LICENSE && rm -f .gitignore && rm -f README.md \

    # clean links
    && mv htaccess .htaccess

COPY content /var/www/html/content
COPY public /var/www/html/public
COPY templates /var/www/html/templates
