FROM mhrivnak/pulp-k8s-base:f26

ADD run.sh /run.sh

USER apache

# Usage: /run.sh worker|beat|resource_manager
ENTRYPOINT ["/run.sh"]
