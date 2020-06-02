FROM metasploitframework/metasploit-framework

LABEL maintainer="Andrés Mauricio Montoya Sánchez <andresmontoyafcb@gmail.com>"

WORKDIR /usr/src/avmod

COPY . .

RUN pip3 install --upgrade pip
RUN pip3 install --editable .

RUN echo "alias msfconsole='/usr/src/metasploit-framework/msfconsole'" >> /usr/src/metasploit-framework/.profile
RUN echo "alias msfvenom='/usr/src/metasploit-framework/msfvenom'" >> /usr/src/metasploit-framework/.profile
RUN source /usr/src/metasploit-framework/.profile

# The metasploit-framework docker image needs to stay here.
WORKDIR /usr/src/metasploit-framework

ENTRYPOINT ["avmod"]