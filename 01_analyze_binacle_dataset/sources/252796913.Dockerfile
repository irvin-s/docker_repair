FROM clockworksoul/frotz  
  
MAINTAINER Matt Titmus <matthew.titmus@gmail.com>  
  
ENV STORY_ZIP bureaucracy.zip  
ENV STORY_DAT bureaucracy/bureau/BUREAUCR.DAT  
  
COPY ${STORY_ZIP} story.zip  
  
RUN unzip story.zip \  
&& rm story.zip  
  
# Make a nice, simply-placed save file directory  
# We'll need to take root form to manage this.  
#  
USER root  
  
RUN mkdir /save \  
&& chown frotz:frotz /save \  
&& chmod 775 /save  
  
# We need to run from here because Frotz drops treats the working directory  
# as the save directoy  
#  
WORKDIR /save  
  
CMD chgrp frotz /save \  
&& chmod 775 /save \  
&& sudo -u frotz /usr/bin/frotz /home/frotz/${STORY_DAT}  

