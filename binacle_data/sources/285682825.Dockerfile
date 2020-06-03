FROM ethresearch/pyethapp

COPY default_data/config /root/default_config
COPY filebeat.yml /etc/filebeat/filebeat.yml
RUN chmod go-w /etc/filebeat/filebeat.yml
COPY default_data/log /root/log
COPY start.sh /root/
EXPOSE 30303
EXPOSE 30303/udp
EXPOSE 8545

ENTRYPOINT ["sh","/root/start.sh"]
CMD ["pyethapp", "-m", "0", "--password", "/root/.config/pyethapp/password.txt", "-l", "eth.chain:info,eth.chainservice:info,eth.validator:info", "--log-file", "/root/log/log.txt", "-b", "$BOOTSTRAP_NODE", "run"]
