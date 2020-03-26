FROM wagahigh

COPY bin /app/toa
COPY run_toa.sh /

USER root
RUN chmod a+rx /run_toa.sh

USER wagahigh
ENTRYPOINT [ "/run_toa.sh" ]
