FROM postgres:9.5

RUN apt-get update -y && \
    apt-get install -y cron php5-cli && \
    apt-get clean -y && \
    mkdir /var/log/backupper/

ENV ENV_FILE "/env.sh"
RUN touch $ENV_FILE && chmod +x $ENV_FILE

ADD bin /backupper_bin
WORKDIR /backupper_bin
CMD /backupper_bin/entrypoint.sh