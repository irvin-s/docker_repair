FROM centos/python-35-centos7

USER root

ENV PATH=/opt/app-root/bin:/opt/rh/rh-python35/root/usr/bin:/opt/app-root/src/.local/bin/:/opt/app-root/src/bin:/opt/app-root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    LD_LIBRARY_PATH=/opt/rh/rh-python35/root/usr/lib64

RUN yum -y install libffi-devel; \
  pip install --upgrade pip; \
  pip install requests pkiutils pyopenssl; \
  yum clean all;

RUN mkdir -p /opt/event-controller

COPY ./src/ /opt/event-controller/

COPY ./bin/ /opt/event-controller/bin

RUN chown -R 1001:1001 /opt/event-controller

USER 1001

ENTRYPOINT ["/opt/event-controller/bin/start.sh"]
