FROM rabbitmq:latest as build

# set the environment
ENV LANG=C.UTF-8

# install needed build tools
RUN apt-get -y update
RUN apt-get -y install \
        curl \
        erlang-dev \
        erlang-src \
        git \
        make \
        python \
        rsync \
        zip

# change work directory
ADD . rabbitmq-delimiter-exchange
WORKDIR rabbitmq-delimiter-exchange

# package
RUN make
RUN make dist

# copy the plugin to a temporary exchange
RUN cp plugins/rabbitmq_delimiter_exchange-*.ez /tmp/

# same image, different fs
FROM rabbitmq:latest

# copy the built plugin from the other phase through to this phase
COPY --from=build /tmp/rabbitmq_delimiter_exchange-*.ez ./plugins/

# enable the management plugin and the delimiter
RUN rabbitmq-plugins enable --offline \
        rabbitmq_management \
        rabbitmq_delimiter_exchange

# expose management ports
EXPOSE 15671 15672
