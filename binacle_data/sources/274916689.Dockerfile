# Runs on-top of the pgsql-cluster-manager-base image to install an appropriate test
# Postgres setup
FROM gocardless/pgsql-cluster-manager-base:v1

# Install Postgres configuration, including an empty data directory
RUN rm -rf /var/lib/postgresql/9.4/main
ADD main.tar.gz /var/lib/postgresql/9.4/
COPY postgres/postgresql.conf postgres/pg_hba.conf /etc/postgresql/9.4/main/

# Set PgBouncer to trust mode on everything- we don't care about authentication in our
# tests
COPY pgbouncer/userlist.txt pgbouncer/pgbouncer.ini.template /etc/pgbouncer/
RUN cp -v /etc/pgbouncer/pgbouncer.ini.template /etc/pgbouncer/pgbouncer.ini

COPY corosync/authkey /etc/corosync/
COPY resource_agents/pgsql /usr/lib/ocf/resource.d/heartbeat/
COPY stonith/docker /usr/lib/stonith/plugins/external/
# Pacemaker refuses to run stonith resources that have open permissions to group
# and other, and while this is executable in the git repository you can't
# specify permissions for group/other.
RUN chmod 700 /usr/lib/stonith/plugins/external/docker

ADD pgsql-cluster-manager/config.toml /etc/pgsql-cluster-manager/config.toml
RUN chown postgres:postgres /etc/pgsql-cluster-manager/config.toml

COPY start-cluster.bash /bin/start-cluster

EXPOSE 2379 5432 6432 8080
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["bash", "-c", "while :; do sleep 1; done"]
