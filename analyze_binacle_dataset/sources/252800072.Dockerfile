from java:8  
maintainer My Training john.dinger@capstonec.com  
env BAR foo  
copy ./src /home/root/javahelloworld/src  
workdir /home/root/javahelloworld  
run mkdir bin  
run javac -d bin src/HelloWorld.java  
run ls -al  
env FOO bar  
entrypoint ["java", "-cp", "bin", "HelloWorld"]  

