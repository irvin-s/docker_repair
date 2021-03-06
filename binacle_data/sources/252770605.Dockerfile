FROM ansibleplaybookbundle/apb-base  
  
LABEL "com.redhat.apb.version"="0.1.0"  
LABEL "com.redhat.apb.spec"=\  
"dmVyc2lvbjogMS4wCm5hbWU6IGFlcm9nZWFyLWRpZ2dlci1hcGIKZGVzY3JpcHRpb246IE1vYmls\  
ZSBDSXxDRCBzZXJ2aWNlIHRoYXQgaW50ZWdyYXRlcyB3aXRoIEplbmtpbnMgUGlwZWxpbmVzIHRv\  
IHRlc3QgYW5kIGJ1aWxkIHlvdXIgbW9iaWxlIGJpbmFyaWVzLgpiaW5kYWJsZTogRmFsc2UKYXN5\  
bmM6IG9wdGlvbmFsCnRhZ3M6CiAgLSBtb2JpbGUtc2VydmljZQogIC0gbW9iaWxlLWNsaWVudC1l\  
bmFibGVkCm1ldGFkYXRhOgogIGRpc3BsYXlOYW1lOiBNb2JpbGUgQ0l8Q0QKICBsb25nRGVzY3Jp\  
cHRpb246ICJUbyB1c2UgdGhlIE1vYmlsZSBDSXxDRCBzZXJ2aWNlIHlvdSBtdXN0IGZpcnN0IGFn\  
cmVlIHRvIHRoZSBBbmRyb2lkIFNESyBMaWNlbnNlIEFncmVlbWVudC4gQnkgY2hlY2tpbmcgdGhp\  
cyBib3ggeW91IGFyZSBhZ3JlZWluZyB0byB0aGUgQW5kcm9pZCBTb2Z0d2FyZSBEZXZlbG9wbWVu\  
dCBLaXQgTGljZW5zZSBhZ3JlZW1lbnQgd2hpY2ggY2FuIGJlIHJlYWQgYXQgdGhlIGZvbGxvd2lu\  
ZyBVUkw6IGh0dHBzOi8vZGV2ZWxvcGVyLmFuZHJvaWQuY29tL3N0dWRpby90ZXJtcy5odG1sXG5c\  
bi4gSWYgdGhlIGJveCBpcyBub3QgY2hlY2tlZCB0aGUgaW5zdGFsbGVyIHdpbGwgdGFrZSBubyBh\  
Y3Rpb24uIgogIHNlcnZpY2VOYW1lOiBhZXJvZ2Vhci1kaWdnZXIKICBpbWFnZVVybDogImh0dHBz\  
Oi8vYWVyb2dlYXIub3JnL2ltZy9hZXJvZ2VhcmRpZ2dlcl9pY29uXzMycHhfY3JvcHBlZC5wbmci\  
CiAgZG9jdW1lbnRhdGlvblVybDogImh0dHBzOi8vYWVyb2dlYXIub3JnL2RpZ2dlci8iCiAgcHJv\  
dmlkZXJEaXNwbGF5TmFtZTogIlJlZCBIYXQsIEluYy4iCnBsYW5zOgogIC0gbmFtZTogZGVmYXVs\  
dAogICAgZGVzY3JpcHRpb246IERlZmF1bHQgcGxhbgogICAgZnJlZTogVHJ1ZQogICAgbWV0YWRh\  
dGE6IHt9CiAgICBwYXJhbWV0ZXJzOgogICAgLSBuYW1lOiBBTkRST0lEX0xJQ0VOU0VfQUdSRUVN\  
RU5UCiAgICAgIGRlZmF1bHQ6ICIiCiAgICAgIHBhdHRlcm46IF55ZXMkCiAgICAgIHR5cGU6IHN0\  
cmluZwogICAgICBkZXNjcmlwdGlvbjogIlR5cGUgJ3llcycgYWJvdmUgdG8gYWNjZXB0IHRoZSBB\  
bmRyb2lkIFNESyBMaWNlbnNlIEFncmVlbWVudC4gaHR0cHM6Ly9kZXZlbG9wZXIuYW5kcm9pZC5j\  
b20vc3R1ZGlvL3Rlcm1zLmh0bWwiCiAgICAgIHRpdGxlOiBBbmRyb2lkIFNESyBMaWNlbnNlIEFn\  
cmVlbWVudAogICAgICByZXF1aXJlZDogVHJ1ZQogICAgICBkaXNwbGF5X2dyb3VwOiBBbmRyb2lk\  
IFNESwogICAgLSBuYW1lOiBBTkRST0lEX1NES19DT05GSUcKICAgICAgZGVmYXVsdDogfAogICAg\  
ICAgIFtiYXNlXQogICAgICAgIHRvb2xzCiAgICAgICAgcGxhdGZvcm0tdG9vbHMKIAogICAgICAg\  
IFtwbGF0Zm9ybXNdCiAgICAgICAgYW5kcm9pZC0yNwogICAgICAgIGFuZHJvaWQtMjYKICAgICAg\  
ICBhbmRyb2lkLTI1CiAgICAgICAgIAogICAgICAgIFtidWlsZC10b29sc10KICAgICAgICAyNy4w\  
LjMKICAgICAgICAyNy4wLjIKICAgICAgICAyNy4wLjEKICAgICAgICAyNi4wLjIKICAgICAgICAy\  
Ni4wLjEKICAgICAgICAyNi4wLjAKICAgICAgICAyNS4wLjMKICAgICAgICAyNS4wLjIKICAgICAg\  
ICAgCiAgICAgICAgW2V4dHJhczpnb29nbGVdCiAgICAgICAgZ29vZ2xlX3BsYXlfc2VydmljZXMK\  
ICAgICAgICBtMnJlcG9zaXRvcnkKICAgICAgICAgCiAgICAgICAgW2V4dHJhczphbmRyb2lkXQog\  
ICAgICAgIG0ycmVwb3NpdG9yeQogICAgICAgICAKICAgICAgICBbZXh0cmFzOm0ycmVwb3NpdG9y\  
eTpjb206YW5kcm9pZDpzdXBwb3J0OmNvbnN0cmFpbnQ6Y29uc3RyYWludC1sYXlvdXRdCiAgICAg\  
ICAgMS4wLjAKICAgICAgICAxLjAuMQogICAgICAgIDEuMC4yCiAgICAgICAgIAogICAgICAgIFtl\  
eHRyYXM6bTJyZXBvc2l0b3J5OmNvbTphbmRyb2lkOnN1cHBvcnQ6Y29uc3RyYWludDpjb25zdHJh\  
aW50LWxheW91dC1zb2x2ZXJdCiAgICAgICAgMS4wLjAKICAgICAgICAxLjAuMgogICAgICAgICAK\  
ICAgICAgICBba2V5c3RvcmVdCiAgICAgICAgYWxpYXM9QW5kcm9pZERlYnVnS2V5CiAgICAgICAg\  
bmFtZT1BRwogICAgICAgIHVuaXQ9QWVyb0dlYXIKICAgICAgICBvcmc9UmVkSGF0CiAgICAgICAg\  
bG9jPVdhdGVyZm9yZAogICAgICAgIHN0YXRlPVdECiAgICAgICAgY291bnRyeT1JUkwKICAgICAg\  
ICBzdG9yZXBhc3M9YW5kcm9pZAogICAgICAgIGtleXBhc3M9YW5kcm9pZAogICAgICB0eXBlOiBz\  
dHJpbmcKICAgICAgZGlzcGxheV90eXBlOiB0ZXh0YXJlYQogICAgICBkZXNjcmlwdGlvbjogIkFu\  
ZHJvaWQgU0RLIGNvbmZpZyBjb250ZW50IgogICAgICB0aXRsZTogQW5kcm9pZCBTREsgcGFja2Fn\  
ZSBjb25maWcKICAgICAgcmVxdWlyZWQ6IEZhbHNlCiAgICAgIHVwZGF0YWJsZTogVHJ1ZQogICAg\  
ICBkaXNwbGF5X2dyb3VwOiBBbmRyb2lkIFNESwo="  
  
COPY playbooks /opt/apb/actions  
COPY roles /opt/ansible/roles  
COPY vars /opt/ansible/vars  
RUN chmod -R g=u /opt/{ansible,apb}  
USER apb  

