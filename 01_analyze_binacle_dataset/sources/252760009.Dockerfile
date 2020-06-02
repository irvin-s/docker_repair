FROM jupyterhub/jupyterhub

RUN apt-get update && apt-get install -y curl
RUN pip install jupyterhub-ldapauthenticator oauthenticator
RUN pip install git+git://github.com/danielfrg/jupyterhub-kubernetes_spawner.git@0.1.1

USER root
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

CMD ["/startup.sh"]
