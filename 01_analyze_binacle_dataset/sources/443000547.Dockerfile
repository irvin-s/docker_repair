#
# ojo-bot production stack
#
# Pat Cappelaere Vightel
# pat@cappelaere.com
#
FROM cappelaere/ojo_publisher_base_stack:v1

MAINTAINER Pat Cappelaere <pat@cappelaere.com>


COPY app 				/app/user/app
COPY config				/app/user/config
COPY lib				/app/user/lib
COPY locale				/app/user/locale
COPY models				/app/user/models
COPY public				/app/user/public
COPY python				/app/user/python

COPY data				/app/user/tmp

COPY server.js			/app/user/server.js
COPY qserver.js			/app/user/qserver.js
COPY settings.js		/app/user/settings.js
COPY subsetregions.js	/app/user/subsetregions.js
COPY package.json		/app/user/package.json
COPY README.md			/app/user/README.md

COPY rccp_coffeecrops3.geojson /app/user/rccp_coffeecrops3.geojson
COPY rcmrd_teacrops3.geojson /app/user/rcmrd_teacrops3.geojson
COPY imerg_regions.yaml	/app/user/imerg_regions.yaml

#COPY Procfile		/app/user

COPY envs.docker.sh /app/user/envs.docker.sh
# Add to .basrc to have envs available when you run the shell
RUN echo 'source /app/user/envs.docker.sh' >> ~/.bashrc
COPY envs.docker.sh /etc/profile.d

WORKDIR /app/user

RUN npm install

# Alternate npm install when very poor connection
#RUN npm config set registry http://registry.npmjs.org/
#RUN npm config set strict-ssl=false
#RUN npm install --loglevel=verbose 

# make vim available to change files right in vm environment
RUN apt-get install -y vim 

# Missing from CONDA
RUN pip install boto3

