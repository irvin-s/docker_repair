FROM node:latest

########################################################################################################################

# Global install yarn package manager
RUN apt-get update && apt-get install -y curl apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn nano

########################################################################################################################

# Fix permissions
# https://github.com/docker-library/php/issues/222#issuecomment-211527819
# http://gbraad.nl/blog/non-root-user-inside-a-docker-container.html
# https://docs.docker.com/engine/reference/builder/#user
# https://vsupalov.com/docker-arg-env-variable-guide/
# /etc/passwd Example: www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
# /etc/group Example: www-data:x:33:
ARG HOST_UID
ARG HOST_GID
ENV HOST_UID $HOST_UID
ENV HOST_GID $HOST_GID
RUN sed -ri 's#^www-data:x:33:33:www-data:/var/www:#www-data:x:'"$HOST_UID"':'"$HOST_GID"':www-data:/home/www-data:#' /etc/passwd
RUN sed -ri 's#^www-data:x:33:#www-data:x:'"$HOST_GID"':#' /etc/group
RUN mkdir /home/www-data && chown -R www-data:www-data /home/www-data
USER www-data

########################################################################################################################

# Yarn Cache
ENV YARN_CACHE_FOLDER /home/www-data/.cache/yarn
RUN mkdir -p ${YARN_CACHE_FOLDER} && chmod 777 ${YARN_CACHE_FOLDER}
VOLUME ${YARN_CACHE_FOLDER}

########################################################################################################################

WORKDIR /var/www/project

ENTRYPOINT ["tail", "-f", "/dev/null"]