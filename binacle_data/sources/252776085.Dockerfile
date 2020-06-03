FROM mesosphere/mesos-slave:0.22.0-1.0.ubuntu1404  
ENTRYPOINT ["mesos-slave"]  
  
# On 18.03.2015 I asked for a fix, on 02.05.2015 there were no fix:  
# https://twitter.com/ibobrik/status/589362154735800320  
# This makes me sad :(  

