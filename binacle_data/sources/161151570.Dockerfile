FROM tianon/gentoo-stage3

RUN touch /etc/init.d/functions.sh && \
  echo 'PYTHON_TARGETS="${PYTHON_TARGETS} python2_7"' >> /etc/portage/make.conf && \
  echo 'PYTHON_SINGLE_TARGET="python2_7"' >> /etc/portage/make.conf

RUN \
  emerge --sync && \
  emerge gcc distcc && \
  rm -rf /usr/portage/*

RUN ( \
    echo "#!/bin/sh" && \
    echo "eval \"\`gcc-config -E\`\"" && \
    echo "exec distccd \"\$@\"" \
  ) > /usr/local/sbin/distccd-launcher && \
  chmod +x /usr/local/sbin/distccd-launcher

CMD ["/usr/local/sbin/distccd-launcher", "--allow", "0.0.0.0/0", "--user", "distcc", "--log-level", "notice", "--log-stderr", "--no-detach"]

EXPOSE 3632
