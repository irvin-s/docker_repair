FROM openjdk:8-jre-slim

ADD wisetime-inprotech-connect /wisetime-inprotech-connect
RUN chmod +x /wisetime-inprotech-connect/bin/inprotech-connector
ENV PATH /wisetime-inprotech-connect/bin:$PATH

ENTRYPOINT ["inprotech-connector"]
