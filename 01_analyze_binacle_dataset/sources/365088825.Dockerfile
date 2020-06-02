FROM levvel/rabbitclusterbase
MAINTAINER Jay Johnson jay.p.h.johnson@gmail.com

# Create directories
RUN mkdir /opt/rabbit
RUN mkdir /opt/simulator
RUN mkdir /opt/simulator/tools

# Add the files from the local repository into the container
ADD rabbitmq.config     /etc/rabbitmq/
ADD rabbitmq-env.conf   /etc/rabbitmq/
ADD erlang.cookie       /var/lib/rabbitmq/.erlang.cookie
ADD startclusternode.sh /opt/rabbit/
ADD debugnodes.sh       /opt/rabbit/
ADD tl                  /bin/tl
ADD rl                  /bin/rl
ADD rst                 /bin/rst

# Add the simulator tooling
ADD simulator_tools/start_node.sh   /opt/simulator/tools/
ADD simulator_tools/stop_node.sh    /opt/simulator/tools/
ADD simulator_tools/join_cluster.sh   /opt/simulator/tools/
ADD simulator_tools/leave_cluster.sh  /opt/simulator/tools/
ADD simulator_tools/reset_first_time_running.sh /opt/simulator/tools/

# Set the file permissions in the container
RUN chmod 644 /etc/rabbitmq/rabbitmq.config
RUN chmod 644 /etc/rabbitmq/rabbitmq-env.conf
RUN chmod 400 /var/lib/rabbitmq/.erlang.cookie
RUN chmod 777 /opt/rabbit/startclusternode.sh
RUN chmod 777 /opt/rabbit/debugnodes.sh
RUN chmod 777 /bin/tl
RUN chmod 777 /bin/rl
RUN chmod 777 /bin/rst
RUN chmod 777 /opt/simulator
RUN chmod 777 /opt/simulator/tools
RUN chmod 777 /opt/simulator/tools/start_node.sh
RUN chmod 777 /opt/simulator/tools/stop_node.sh 
RUN chmod 777 /opt/simulator/tools/join_cluster.sh
RUN chmod 777 /opt/simulator/tools/leave_cluster.sh
RUN chmod 777 /opt/simulator/tools/reset_first_time_running.sh 

# Set ownership permissions on files in the container
RUN chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie

# Expose ports inside the container to the host
EXPOSE 1883
EXPOSE 8883
EXPOSE 5672
EXPOSE 15672
EXPOSE 25672
EXPOSE 4369
EXPOSE 9100
EXPOSE 9101
EXPOSE 9102
EXPOSE 9103
EXPOSE 9104
EXPOSE 9105

# Run this to debug the cluster nodes by allowing ssh login
#CMD /opt/rabbit/debugnodes.sh

# Run this to autostart the cluster nodes
CMD /opt/rabbit/startclusternode.sh

