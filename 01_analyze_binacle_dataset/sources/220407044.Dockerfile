FROM damsl/k3-perf
ADD k3 /usr/bin/k3
RUN chmod +x /usr/bin/k3
ADD run_k3.sh /usr/bin/run_k3
RUN chmod +x /usr/bin/run_k3
