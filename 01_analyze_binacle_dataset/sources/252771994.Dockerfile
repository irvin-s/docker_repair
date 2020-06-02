FROM ruby:alpine  
  
ENV CRONTAB="/var/spool/cron/crontabs/gca" \  
OUTPUT_REPO="/app/output" \  
ANALYZER_REPO="/app/ruby-git-commits-analyzer" \  
GCA_SCHEDULE="5 * * * *"  
VOLUME /data  
  
# Set up environment.  
RUN apk add --update \  
bash \  
gcc \  
git \  
libc-dev \  
make \  
openssh \  
su-exec \  
tzdata \  
&& rm -rf /var/cache/apk/* \  
&& adduser \  
-D `# Don't assign a password` \  
-h "/home/gca" \  
-s "/bin/bash" \  
gca \  
&& touch $CRONTAB \  
&& mkdir -p $OUTPUT_REPO \  
&& chown gca $OUTPUT_REPO \  
&& mkdir -p $ANALYZER_REPO \  
&& chown gca $ANALYZER_REPO  
  
# Clone application source repository.  
RUN su-exec gca /usr/bin/git clone \  
https://github.com/guillaumeaubert/ruby-git-commits-analyzer.git \  
$ANALYZER_REPO \  
&& cd $ANALYZER_REPO \  
&& bundle install  
  
# Copy supporting files.  
COPY analyze.sh /app/  
  
# Launch app.  
COPY start.sh /app/  
WORKDIR /app  
CMD ["/app/start.sh"]  

