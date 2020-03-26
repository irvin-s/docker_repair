FROM rabbitmq:3.6.12

RUN rabbitmq-plugins enable --offline rabbitmq_management

ENV RABBITMQ_ERLANG_COOKIE changeThis

# Add files.
COPY ./cmd.sh /
COPY ./rabbitmq.config /etc/rabbitmq/rabbitmq.config

# Define default command.
CMD ["/cmd.sh"]

# default ports + management plugin ports
EXPOSE 4369 5671 5672 25672 15671 15672
