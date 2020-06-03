FROM euleros:latest
RUN mkdir -p /opt/mesher/conf &&\
    mkdir -p /etc/mesher/conf
COPY mesher /opt/mesher/
COPY start_mesher.sh /opt/mesher/
COPY wait_for_sc.sh /opt/mesher/
COPY VERSION /opt/mesher/
COPY conf/* /opt/mesher/conf/
RUN chmod 770 /opt/mesher/mesher &&\
    chmod 770 /opt/mesher/wait_for_sc.sh &&\
    chmod 770 /opt/mesher/start_mesher.sh
ENV CHASSIS_HOME=/opt/mesher/
ENTRYPOINT ["/opt/mesher/start_mesher.sh"]
