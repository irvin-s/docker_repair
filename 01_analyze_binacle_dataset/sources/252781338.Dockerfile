FROM bamx23/scipy-alpine:latest  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY requirements.txt /usr/src/app/  
RUN pip install --no-cache-dir setuptools \  
&& pip install --no-cache-dir -r requirements.txt  
  
COPY . /usr/src/app  
  
ENV TOKEN="your bot token here"  
CMD [ "python", "./hashflare-bot.py" ]  

