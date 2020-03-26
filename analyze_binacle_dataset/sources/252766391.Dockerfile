FROM redmine  
  
RUN cd /usr/src/redmine/plugins \  
&& git clone git://github.com/arkhitech/redmine_timesheet_plugin.git \  
&& cd redmine_timesheet_plugin  
  

