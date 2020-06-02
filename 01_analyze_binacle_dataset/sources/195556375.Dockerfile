FROM node:argon

#Copy over, and grant executable permission to the startup script
COPY ./entrypoint.sh /
RUN chmod +x ./entrypoint.sh

#Run Startup script
ENTRYPOINT [ "/entrypoint.sh" ]
