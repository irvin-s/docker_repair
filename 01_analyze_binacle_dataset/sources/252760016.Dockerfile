FROM jupyterhub/singleuser

USER root
ADD startup.sh /srv/singleuser/startup.sh
RUN chmod +x /srv/singleuser/startup.sh

CMD ["/srv/singleuser/startup.sh"]
