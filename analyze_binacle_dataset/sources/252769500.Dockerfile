FROM ansibleplaybookbundle/apb-base  
  
LABEL "com.redhat.apb.spec"=\  
"dmVyc2lvbjogMS4wCm5hbWU6IHRoZWxvdW5nZS1hcGIKZGVzY3JpcHRpb246IFRoaXMgaXMgYSBz\  
YW1wbGUgYXBwbGljYXRpb24gZ2VuZXJhdGVkIGJ5IGFwYiBpbml0CmJpbmRhYmxlOiBGYWxzZQph\  
c3luYzogb3B0aW9uYWwKbWV0YWRhdGE6CiAgZGlzcGxheU5hbWU6IFRoZSBMb3VuZ2UgKEFQQikK\  
ICBpbWFnZVVybDogaHR0cHM6Ly9hc3NldHMtY2RuLmdpdGh1Yi5jb20vaW1hZ2VzL2ljb25zL2Vt\  
b2ppL3VuaWNvZGUvMWY0YWMucG5nCiAgZGVwZW5kZW5jaWVzOiBbJ2RvY2tlci5pby9keW11cnJh\  
eS9sb3VuZ2U6bGF0ZXN0J10KICBwcm92aWRlckRpc3BsYXlOYW1lOiAiUmVkIEhhdCwgSW5jLiIK\  
cGxhbnM6CiAgLSBuYW1lOiBkZWZhdWx0CiAgICBkZXNjcmlwdGlvbjogVGhpcyBkZWZhdWx0IHBs\  
YW4gZGVwbG95cyB0aGVsb3VuZ2UtYXBiCiAgICBmcmVlOiBUcnVlCiAgICBtZXRhZGF0YToge30K\  
ICAgIHBhcmFtZXRlcnM6IFtdCg=="  
  
COPY playbooks /opt/apb/actions  
COPY roles /opt/ansible/roles  
RUN chmod -R g=u /opt/{ansible,apb}  
USER apb  

