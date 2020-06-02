FROM mshytikov/dvim:latest

ARG UID

RUN usermod -u $UID rat &&  chown -R rat /home/rat
