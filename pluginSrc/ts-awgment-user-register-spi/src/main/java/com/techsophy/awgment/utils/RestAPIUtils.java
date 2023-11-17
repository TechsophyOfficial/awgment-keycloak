package com.techsophy.awgment.provider.utils;

import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import javax.xml.xpath.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.techsophy.awgment.dto.UserRequestPayload;
import com.techsophy.awgment.utils.Rsa4096;
import org.apache.http.*;
import org.apache.http.client.*;
import org.apache.http.client.methods.*;
import org.apache.http.client.utils.*;
import org.apache.http.entity.*;
import org.apache.http.impl.client.*;
import org.apache.http.util.*;
import org.xml.sax.*;

public class RestAPIUtils {
    public static void addUserToAwgment(String eventType,
                                        String userName,
                                         String userId,
                                         String realm,
                                         String clientId,
                                         String identityProvider) throws Exception {
        try (CloseableHttpClient httpclient = HttpClients.createDefault()) {

            HttpPost httpPost = new HttpPost("http://localhost:8082/user/"+eventType+"/"+realm+"/"+clientId+"/"+identityProvider);

            UserRequestPayload post = UserRequestPayload.builder()
                    .department("dept")
                    .lastName("lastName")
                    .emailId(userName)
                    .firstName(userName)
                    .mobileNumber("mobileNo")
                    .userName(userName)
                    .build();
            ObjectWriter ow = new ObjectMapper().writer();
            String strJson = ow.writeValueAsString(post);
            Rsa4096 rsa4096 = new Rsa4096();
            httpPost.setHeader("Signature", rsa4096.encryptToBase64("Keycloak-to-Awgment"));
            StringEntity strEntity = new StringEntity(strJson, ContentType.APPLICATION_JSON);
            httpPost.setEntity(strEntity);
            httpPost.setHeader("Content-type", "application/json");

            try (CloseableHttpResponse response = httpclient.execute(httpPost)) {
                Integer statusCode = response.getStatusLine().getStatusCode();
            } catch (ParseException e) {
                e.printStackTrace();
            }

        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

}
