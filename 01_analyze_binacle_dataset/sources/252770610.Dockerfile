FROM ansibleplaybookbundle/apb-base  
  
LABEL "com.redhat.apb.version"="0.1.0"  
LABEL "com.redhat.apb.spec"=\  
"dmVyc2lvbjogMS4wCm5hbWU6IGlvcy1hcHAtYXBiCmRlc2NyaXB0aW9uOiBTZXRzIHVwIGFuIGlP\  
UyBBcHAgcmVwcmVzZW50YXRpb24uCmJpbmRhYmxlOiBGYWxzZQphc3luYzogb3B0aW9uYWwKdGFn\  
czogCiAgLSBtb2JpbGUKbWV0YWRhdGE6CiAgZGlzcGxheU5hbWU6IGlPUyBBcHAKICBjb25zb2xl\  
Lm9wZW5zaGlmdC5pby9pY29uQ2xhc3M6IGZhIGZhLWFwcGxlCiAgZG9jdW1lbnRhdGlvblVybDog\  
Imh0dHA6Ly9kb2NzLmFlcm9nZWFyLm9yZyIKcGxhbnM6CiAgLSBuYW1lOiBkZWZhdWx0CiAgICBk\  
ZXNjcmlwdGlvbjogU2V0cyB1cCBhbiBpT1MgQXBwIHJlcHJlc2VudGF0aW9uLgogICAgZnJlZTog\  
VHJ1ZQogICAgbWV0YWRhdGE6IHt9CiAgICBwYXJhbWV0ZXJzOiAKICAgIC0gbmFtZTogYXBwTmFt\  
ZQogICAgICByZXF1aXJlZDogVHJ1ZQogICAgICBkZWZhdWx0OiBteWFwcAogICAgICB0eXBlOiBz\  
dHJpbmcKICAgICAgdGl0bGU6IEFwcGxpY2F0aW9uIE5hbWUKICAgIC0gbmFtZTogYXBwSWRlbnRp\  
aWZlcgogICAgICByZXF1aXJlZDogVHJ1ZQogICAgICB0eXBlOiBzdHJpbmcKICAgICAgdGl0bGU6\  
IEJ1bmRsZSBJRA=="  
  
COPY playbooks /opt/apb/actions  
COPY roles /opt/ansible/roles  
COPY mobile /usr/bin  
RUN chmod -R g=u /opt/{ansible,apb}  
USER apb  

