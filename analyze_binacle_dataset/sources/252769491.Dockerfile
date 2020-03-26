FROM ansibleplaybookbundle/apb-base  
  
LABEL "com.redhat.apb.spec"=\  
"dmVyc2lvbjogMS4wCm5hbWU6IGRlbW8tZXh0LWFwaS1hcGIKZGVzY3JpcHRpb246IENvbm5lY3Rp\  
b24gdG8gZXh0ZXJuYWwgQVBJIG9mIGNhdHMgKHRoZWNhdGFwaS5jb20pCmJpbmRhYmxlOiBUcnVl\  
CmFzeW5jOiBvcHRpb25hbAptZXRhZGF0YToKICBkaXNwbGF5TmFtZTogRXh0ZXJuYWwgQ2F0IEFQ\  
SSAoQVBCKQogIGltYWdlVXJsOiBodHRwczovL3BuZy5pY29uczguY29tL2NhdC9vZmZpY2UvODAK\  
cGxhbnM6CiAgLSBuYW1lOiBkZWZhdWx0CiAgICBkZXNjcmlwdGlvbjogQ3JlYXRlcyB0aGUgZXh0\  
ZXJuYWwgY3JlZGVudGlhbHMKICAgIGZyZWU6IFRydWUKICAgIG1ldGFkYXRhOiB7fQogICAgcGFy\  
YW1ldGVyczoKICAgICAgLSBuYW1lOiBhcGlfa2V5CiAgICAgICAgdGl0bGU6IEFQSSBLZXkKICAg\  
ICAgICB0eXBlOiBzdHJpbmcKICAgICAgICBkZXNjcmlwdGlvbjogR2VuZXJhdGVkIGlmIGxlZnQg\  
YmxhbmsKICAgICAgICBkaXNwbGF5X2dyb3VwOiBBUEkgU2V0dGluZ3MKICAgICAgLSBuYW1lOiBh\  
cGlfc2VjcmV0CiAgICAgICAgdGl0bGU6IEFQSSBTZWNyZXQKICAgICAgICB0eXBlOiBzdHJpbmcK\  
ICAgICAgICBkZXNjcmlwdGlvbjogR2VuZXJhdGVkIGlmIGxlZnQgYmxhbmsKICAgICAgICBkaXNw\  
bGF5X3R5cGU6IHBhc3N3b3JkCiAgICAgICAgZGlzcGxheV9ncm91cDogQVBJIFNldHRpbmdzCg=="  
  
  
  
  
  
COPY playbooks /opt/apb/actions  
COPY roles /opt/ansible/roles  
RUN chmod -R g=u /opt/{ansible,apb}  
USER apb  

