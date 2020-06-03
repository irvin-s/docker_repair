FROM node

RUN adduser --disabled-password --gecos '' noroot && adduser noroot sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER noroot