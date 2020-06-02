FROM wagahigh

COPY bin /app/ashe
COPY run_ashe.sh /

USER root
RUN chmod a+rx /run_ashe.sh

USER wagahigh
ENTRYPOINT [ "/run_ashe.sh" ]
