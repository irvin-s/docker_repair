FROM gitlab.kmee.com.br:5043/odoo/base-buildout:10-0

USER odoo
ENV ODOO_HOME /opt/odoo
WORKDIR $ODOO_HOME
COPY ["default.cfg", "buildout.cfg", "entrypoint.sh", "$ODOO_HOME/"]
RUN bin/buildout -N
USER root
RUN chown -R odoo:odoo $ODOO_HOME/
USER odoo
ENTRYPOINT ["./entrypoint.sh"]
CMD ["odoo"]
USER root
RUN chown -R odoo:odoo $ODOO_HOME/
USER odoo
