FROM centos:latest

RUN curl https://monitoringagent.blob.core.windows.net/agent007/monitoring-installer | sh -s cmBS5j5hvkrc-0mv2uLVtol8kdhAzw4uAVSy9QrbSRUBCKtRyK5-jzfisrDUfntmQpgkNupCQPu5GIG23be1FXw
RUN echo 'repo: agent007' >> /home/monitoring_agent/config.yml


RUN echo 'centosl-mon-inst-007' > /etc/monitoring_agent/server.key
RUN /home/monitoring_agent/monitoring-agent --first-time

CMD '/home/monitoring_agent/monitoring-agent'
