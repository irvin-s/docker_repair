FROM fedora:29

RUN dnf install -y python2-ipykernel python2-jupyter-core gcc python2-devel \
    bzip2 openssh openssh-clients python2-crypto python2-psutil glibc-locale-source && \
    localedef -c -i en_US -f UTF-8 en_US.UTF-8 && \
    pip install --no-cache-dir wheel psutil && \
    rm -rf /var/cache/yum

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

ENV NB_USER notebook
ENV NB_UID 10001

ENV APP_ROOT=/opt/app-root
ENV HOME=${APP_ROOT}
ENV USER_NAME=${NB_USER}

ENV PATH=${APP_ROOT}/bin:${PATH} 
COPY bin/ ${APP_ROOT}/bin/
RUN chmod -R u+x ${APP_ROOT}/bin && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd

RUN pip install --no-cache-dir ansible_kernel && \
    python -m ansible_kernel.install
USER ${NB_UID}
WORKDIR ${APP_ROOT} 

ENTRYPOINT [ "uid_entrypoint"]
CMD run
EXPOSE 8888
