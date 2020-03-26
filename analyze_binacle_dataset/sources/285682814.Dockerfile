FROM ethresearch/pyethapp

COPY default_data/config /root/.config/pyethapp
COPY filebeat.yml /etc/filebeat/filebeat.yml
RUN chmod go-w /etc/filebeat/filebeat.yml
COPY default_data/log /root/log
COPY start.sh /root/
EXPOSE 30303
EXPOSE 30303/udp
EXPOSE 8545

ENTRYPOINT ["sh","/root/start.sh"]
