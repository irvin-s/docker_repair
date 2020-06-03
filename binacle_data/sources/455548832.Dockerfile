FROM spire

RUN mkdir /opt/back-end
COPY build/libs/back-end-0.1-SNAPSHOT.jar /opt/back-end/back-end.jar
COPY spiffe-id-whitelist /opt/back-end
COPY run-backend.sh /opt/back-end

RUN chmod +x /opt/back-end/run-backend.sh
RUN chmod +x create-user.sh

#Create linux user for the workload (back-end app)
RUN ./create-user.sh backend 1000
