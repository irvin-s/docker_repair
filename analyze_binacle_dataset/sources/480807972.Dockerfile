FROM websphere-liberty
RUN installUtility install --acceptLicense mongodb-2.0
COPY mongoDBSample /config
