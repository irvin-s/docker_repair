FROM debian:wheezy
RUN apt-get update && apt-get install -y cntlm
ADD cntlm_start.sh /usr/local/bin/cntlm_start.sh
ADD get_ntlm.sh /usr/local/bin/get_ntlm.sh
RUN chmod +x /usr/local/bin/cntlm_start.sh
RUN chmod +x /usr/local/bin/get_ntlm.sh
EXPOSE 3128
ENTRYPOINT ["/usr/local/bin/cntlm_start.sh"]
