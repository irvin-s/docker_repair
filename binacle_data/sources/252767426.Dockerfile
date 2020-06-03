FROM beevelop/cordova  
  
# Install git client, bower and grunt  
RUN apt-get -y update && apt-get install -y git && npm i -g bower grunt-cli  

