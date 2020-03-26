#Base image
FROM debian:stretch

#Update repository and install dependencies
RUN apt-get -qq update && apt-get -qqy install sudo autoconf build-essential pkg-config libssl-dev libboost-all-dev miniupnpc libminiupnpc-dev gettext qtbase5-dev qttools5-dev-tools libdb++-dev

#Set our work directory to /bitcoinair
WORKDIR /bitcoinair

#Copy our source code files
COPY . .

#Create the .BitcoinAir directory and change the permissions
RUN mkdir /root/.BitcoinAir
RUN chmod -R u=rwx,g=rx,o=rx /root/.BitcoinAir

#Install db4 deps
RUN ./contrib/install_db4.sh `pwd`
RUN ln -sf `pwd`/db4/include /usr/local/include/bdb4.8
RUN ln -sf `pwd`/db4/lib/*.a /usr/local/lib

#Run make
RUN ./autogen.sh && ./configure && make -j$(nproc)

#Set our work directory to /bitcoinair/src
WORKDIR /bitcoinair/src

#Expose ports 
EXPOSE 23672 32761

#Run daemon at startup
CMD ./BitcoinAird -daemon; tail -f /dev/null
