FROM omio/quay.io.calico.node:v2.5.1

# https://github.com/projectcalico/calico/issues/907
# https://github.com/projectcalico/calico/pull/927
# https://github.com/projectcalico/calico/pull/927/commits/2a51ad3839ab2b057015599355b0b3fdff76c57d#diff-20d6a7bab14def3ef9cfe72fc8472213
RUN sed -i 's@from @sed @' /etc/calico/confd/templates/bird_ipam.cfg.template
