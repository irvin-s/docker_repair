FROM node:latest

COPY startup.bash /

CMD ["/bin/bash", "/startup.bash"]
