FROM node:10-stretch
LABEL maintainer="Patrik J. Braun"


RUN git clone https://github.com/bpatrik/pigallery2.git && \
    cd /pigallery2 && \
    npm install --unsafe-perm && \
    npm run build-release && \
    cp -r /pigallery2/release /pigallery2-release && \
    rm /pigallery2 -R && \
    cd /pigallery2-release && \
    npm install --unsafe-perm

CMD cd /pigallery2-release && npm start
