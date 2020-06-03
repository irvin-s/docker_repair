FROM @@@PHP_REPO@@@:@@@PHP_REPO_TAG@@@

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install @@@PHP_EXTENSIONS@@@ \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && a2enmod rewrite

WORKDIR "@@@PROJECT_PATH_SERVER@@@"