FROM quay.io/keycloak/keycloak:11.0.2
COPY themes/awgment /opt/jboss/keycloak/themes/awgment
# COPY themes/paisaplan /opt/jboss/keycloak/themes/paisaplan
# COPY themes/medunited /opt/jboss/keycloak/themes/medunited
COPY themes/cyberwasp /opt/jboss/keycloak/themes/cyberwasp
COPY themes/ayuvu-bharosa /opt/jboss/keycloak/themes/ayuvu-bharosa
COPY themes/redCrabs /opt/jboss/keycloak/themes/redCrabs
COPY themes/medUnitedE360 /opt/jboss/keycloak/themes/medUnitedE360
COPY themes/trovityE360 /opt/jboss/keycloak/themes/trovityE360
COPY themes/cybersophy /opt/jboss/keycloak/themes/cybersophy
COPY themes/channel360 /opt/jboss/keycloak/themes/channel360
COPY themes/techsophy /opt/jboss/keycloak/themes/techsophy
COPY themes/kimsE360 /opt/jboss/keycloak/themes/kimsE360
RUN mkdir /opt/jboss/keycloak/standalone/deployments/providers
COPY standalone/deployments/ts_awgment_user_register_spi.jar /opt/jboss/keycloak/standalone/deployments/ts_awgment_user_register_spi.jar
COPY standalone/deployments/providers/ /opt/jboss/keycloak/standalone/deployments/providers/
COPY imports/ /opt/jboss/keycloak/imports/
ADD config/standalone.xml /opt/jboss/keycloak/standalone/configuration/standalone.xml
