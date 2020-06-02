FROM legcowatch/appserver

COPY bootstrap.sh ${PROJECT_PATH}/bootstrap.sh
ENTRYPOINT ["./bootstrap.sh"]
