FROM mhrivnak/pulp-k8s-base:f26

USER apache

ENTRYPOINT ["pulp-manage-db"]
