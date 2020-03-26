FROM fissile-cf-solo:latest

ADD solo-status.sh /opt/hcf/
ADD run-solo.sh /opt/hcf/

ENTRYPOINT ["/opt/hcf/run-solo.sh"]
