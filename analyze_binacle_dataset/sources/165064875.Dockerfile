FROM textlab/glossa-base
MAINTAINER Anders Nøklestad <anders.noklestad@iln.uio.no>, Michał Kosek <michalkk@student.iln.uio.no>

# Copy the application code to the container and fix links/permissions
ADD . /glossa/
RUN script/docker_glossa_postinst.sh

# Make thin reachable to other containers
EXPOSE 3000

# Run the application with an SQLite database
USER glossa
ENV DATABASE_URL sqlite3:////corpora/glossa.sqlite3
CMD rake db:migrate && exec rails server -p 3000
