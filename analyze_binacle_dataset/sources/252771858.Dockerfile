FROM python:latest  
  
# Updates and package installs  
RUN apt-get update && apt-get install -y --no-install-recommends \  
git gnupg tesseract-ocr imagemagick unpaper ghostscript bash  
  
# Download paperless  
RUN git clone https://github.com/danielquinn/paperless.git  
  
# Install python dependencies  
RUN pip install --user --requirement /paperless/requirements.txt  
  
# ADD start scripts  
ADD start.sh /start.sh  
ADD firstrun.sh /firstrun.sh  
  
# Fix Permissions on start scripts  
RUN chmod +x /start.sh && \  
chmod +x /firstrun.sh  
  
# Expose Web Port  
EXPOSE 8000  
# Start Script  
CMD ["./start.sh"]  

