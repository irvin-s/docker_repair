# Guide here:
# https://github.com/KyleAMathews/docker-nginx

# Build docker file
# docker build -t prototype .

FROM kyma/docker-nginx

COPY dist /var/www

CMD 'nginx'
