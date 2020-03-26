# Copyright (C) 2016 Arista Networks, Inc.  
# Use of this source code is governed by the Apache License 2.0  
# that can be found in the COPYING file.  
FROM logstash  
  
COPY logstash.conf /etc/logstash/conf.d  
  
CMD ["logstash", "-f", "/etc/logstash/conf.d"]  

