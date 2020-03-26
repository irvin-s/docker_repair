FROM kibana:4.5.4

RUN kibana plugin --install elastic/sense
