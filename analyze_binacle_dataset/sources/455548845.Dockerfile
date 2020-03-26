FROM spire

RUN mkdir /opt/front-end
COPY build/libs/front-end-0.1-SNAPSHOT.jar /opt/front-end/front-end.jar
COPY spiffe-id-whitelist /opt/front-end
COPY run-frontend.sh /opt/front-end

RUN chmod +x /opt/front-end/run-frontend.sh
RUN chmod +x create-user.sh

#Create linux users for the workload (front-end app)
RUN ./create-user.sh frontend 1000
RUN ./create-user.sh frontend2 1001
