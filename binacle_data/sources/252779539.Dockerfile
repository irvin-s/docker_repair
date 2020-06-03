FROM calebj/red-selfbot:data  
  
RUN apt-get update && \  
apt-get install -y \--no-install-recommends python3.5 git ca-certificates && \  
apt-get install -y python3-pip && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
RUN git clone -b "$RED_BRANCH" \--single-branch "$RED_REPO" /opt/red/ && \  
mv cogs stock_cogs && mv data stock_data && \  
ln -s /data/red/cogs && ln -s /data/red/data  
  
COPY run_selfred.py custom_requirements.txt /opt/red/  
  
RUN pip3 install -r custom_requirements.txt  
  
RUN chown -R red:red /data/red /opt/red  
  
USER red  
  
ENTRYPOINT ["/usr/bin/python3.5", "/opt/red/run_selfred.py"]  

