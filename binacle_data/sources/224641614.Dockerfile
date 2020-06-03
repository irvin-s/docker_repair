FROM tutum/lamp:latest

# we must change the SESSION_CACHE location because by default the server can not write into the /app/system folder
ENV CI_ENV="development" \
    DEV_BASE_URL="/" \
    MYSQL_USER="admin" \
    MYSQL_PASS="password" \
    MYSQL_DB="zsebtanar" \
    SESSION_CACHE="/tmp/ci_session_cache/"

RUN rm -fr /app && mkdir /app
ADD mysql-setup.sh /mysql-setup.sh
RUN chmod 755 /*.sh


EXPOSE 80 3306
CMD ["/run.sh"]