FROM bestwu/wine:official  
LABEL maintainer='Peter Wu <piterwu@outlook.com>'  
  
ENV APP=sap \  
GID=1000 \  
UID=1000 \  
EVAL=true  
  
RUN apt-get update && \  
apt-get install -y --no-install-recommends xz-utils && \  
apt-get -y autoremove && apt-get clean -y && apt-get autoclean -y && \  
rm -rf var/lib/apt/lists/* var/cache/apt/* var/log/* && \  
groupadd -o -g $GID sap && \  
useradd -d "/home/sap" -m -o -u $UID -g sap sap && \  
mkdir /SAPFiles && \  
chown -R sap:sap /SAPFiles && \  
ln -s "/SAPFiles" "/home/sap/SAPFiles"  
  
COPY sap.tar.xz /home/sap/  
COPY pdflm16.dll /home/sap/  
  
WORKDIR "/SAPFiles"  
VOLUME ["/SAPFiles"]  
  
ADD entrypoint.sh /  
RUN chmod +x /entrypoint.sh  
USER sap  
ENTRYPOINT ["/entrypoint.sh"]

