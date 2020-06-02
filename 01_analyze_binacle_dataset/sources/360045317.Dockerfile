FROM duraark/microservice-base

MAINTAINER Martin Hecher <martin.hecher@fraunhofer.at>

RUN mkdir /opt/duraark-pointcloud-viewer

COPY ./app /opt/duraark-pointcloud-viewer/app
COPY ./public /opt/duraark-pointcloud-viewer/www

WORKDIR /opt/duraark-pointcloud-viewer/app

EXPOSE 5016

RUN npm install

CMD ["npm", "start"]
