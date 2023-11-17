package com.techsophy.awgment.provider;

import com.techsophy.awgment.provider.utils.RestAPIUtils;
import org.keycloak.events.Event;
import org.keycloak.events.EventListenerProvider;
import org.keycloak.events.admin.AdminEvent;

import java.util.Map;


public class SampleEventListenerProvider implements EventListenerProvider {

    public SampleEventListenerProvider() {
    }

    @Override
    public void onEvent(Event event) {
        System.out.println("Event Occurred:" + registerNewUser(event));
    }

    @Override
    public void onEvent(AdminEvent adminEvent, boolean b) {
        System.out.println("Admin Event Occurred");
    }

    @Override
    public void close() {

    }

    private String registerNewUser(Event event) {
        System.out.println("Event Type: "+event.getType().name());
        String eventType = "";
        String userName = "";
        String identityProvider = "";
        String realm = "";
        String userId = "";
        String clientId = "";

        eventType = event.getType().name();
        if(eventType.equalsIgnoreCase("REGISTER")) {
            userId = event.getUserId();
            clientId = event.getClientId();
            realm = event.getRealmId();

            if (event.getDetails() != null) {
                for (Map.Entry<String, String> e : event.getDetails().entrySet()) {
                    if (e.getKey().equalsIgnoreCase("username")) {
                        userName = e.getValue();
                    } else if (e.getKey().equalsIgnoreCase("identity_provider")) {
                        identityProvider = e.getValue();
                    }
                }
            }
            try {
                RestAPIUtils.addUserToAwgment(eventType, userName, userId, realm, clientId, identityProvider);
            } catch(Exception ex) {
                ex.printStackTrace();
            }
        }
        return "SUCCESS";
    }
}