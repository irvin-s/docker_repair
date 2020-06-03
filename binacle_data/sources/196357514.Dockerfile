FROM haproxy

ADD kube-haproxy /usr/local/bin/kube-haproxy
RUN chmod a+x /usr/local/bin/kube-haproxy

CMD [ "/usr/local/bin/kube-haproxy" ]
