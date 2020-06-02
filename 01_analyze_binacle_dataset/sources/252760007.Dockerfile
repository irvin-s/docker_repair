FROM jupyterhub/singleuser

RUN conda install -c conda-forge jupyterlab

USER root
ADD startup.sh /srv/singleuser/startup.sh
RUN chmod +x /srv/singleuser/startup.sh

CMD ["/srv/singleuser/startup.sh"]
