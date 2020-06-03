FROM ansibleplaybookbundle/apb-base  
  
LABEL "com.redhat.apb.spec"=\  
"dmVyc2lvbjogMS4wCm5hbWU6IHRpbGxlci1hcGIKZGVzY3JpcHRpb246IEluc3RhbGxzIHRpbGxl\  
ciBmb3Igc2luZ2xlLW5hbWVzcGFjZSB1c2UKYmluZGFibGU6IEZhbHNlCmFzeW5jOiBvcHRpb25h\  
bAptZXRhZGF0YToKICBkaXNwbGF5TmFtZTogdGlsbGVyCnBsYW5zOgogIC0gbmFtZTogZGVmYXVs\  
dAogICAgZGVzY3JpcHRpb246IFRoaXMgZGVmYXVsdCBwbGFuIGRlcGxveXMgdGlsbGVyLWFwYgog\  
ICAgZnJlZTogVHJ1ZQogICAgbWV0YWRhdGE6IHt9CiAgICBwYXJhbWV0ZXJzOiBbXQo="  
  
COPY playbooks /opt/apb/actions  
COPY roles /opt/ansible/roles  
RUN chmod -R g=u /opt/{ansible,apb}  
USER apb  

