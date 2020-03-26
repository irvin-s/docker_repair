# Buildbox image for Go apps.  
FROM balser/buildbox  
  
ADD golang.sh /etc/profile.d/  
  
ENV GOPACKAGE go1.7.4.linux-amd64.tar.gz  
ENV CHECKSUM 47fda42e46b4c3ec93fa5d4d4cc6a748aa3f9411a2a2b7e08e3a6d80d753ec8b  
  
RUN \  
curl -sOL https://golang.org/dl/$GOPACKAGE && \  
echo "$CHECKSUM $GOPACKAGE" | sha256sum -c - && \  
tar -C /usr/local -xzf $GOPACKAGE && \  
rm $GOPACKAGE  

