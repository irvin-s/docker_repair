FROM ubuntu:16.04

# Instala o CMAKE
RUN apt-get update

# Copia tudo para o container
COPY . /vss-vision
WORKDIR /vss-vision

# Adiciona permissão de execução dos shellscripts
RUN chmod +x /vss-vision/configure.sh
RUN chmod +x /vss-vision/entrypoint.sh
RUN chmod +x /vss-vision/install_core.sh

# Executa a instalação na criação dos containers
RUN /vss-vision/install_core.sh
RUN /vss-vision/configure.sh development

# Script executado no docker run
ENTRYPOINT ["/vss-vision/entrypoint.sh"]