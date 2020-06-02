FROM jacknlliu/ros:kinetic-extensions

LABEL maintainer="Jack Liu <jacknlliu@gmail.com>"

RUN aptitude update -y && aptitude install -y -q -R qt5-default qtcreator qtdeclarative5-qtquick2-plugin

# configure Qt
RUN mkdir -p /home/ros/.config/QtProject

COPY ./config/QtCreator.ini  /home/ros/.config/QtProject/
RUN chown -R ros:ros  /home/ros/.config/

WORKDIR /home/ros
