FROM ubuntu:14.04  
# Nainstalovat potřebné balíčky  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y \  
alien \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY oracle-xe-11.2.0-1.0.x86_64.rpm /tmp  
  
# Nastavit pracovní adresář  
WORKDIR /tmp  
  
# Zkonvertovat RPM balíček do formátu DEB  
RUN alien --scripts -d oracle-xe-11.2.0-1.0.x86_64.rpm \  
&& rm oracle-xe-11.2.0-1.0.x86_64.rpm  

