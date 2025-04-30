package dao;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.oauth2.Oauth2;
import com.google.api.services.oauth2.model.Userinfo;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Arrays;

public class GoogleUtils {

    private static final String CLIENT_ID = System.getenv("GOOGLE_CLIENT_ID");
    private static final String CLIENT_SECRET = System.getenv("GOOGLE_CLIENT_SECRET");
    private static final String REDIRECT_URI = "http://localhost:8080/ClothingShop_war_exploded/oauth2callback";

    private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();
    private static final NetHttpTransport HTTP_TRANSPORT = new NetHttpTransport();

    // Khởi tạo Google OAuth2 flow
    private static GoogleAuthorizationCodeFlow flow() throws IOException {
        return new GoogleAuthorizationCodeFlow.Builder(
                HTTP_TRANSPORT, JSON_FACTORY, CLIENT_ID, CLIENT_SECRET,
                Arrays.asList("https://www.googleapis.com/auth/userinfo.profile", "https://www.googleapis.com/auth/userinfo.email"))
                .setAccessType("offline")
                .build();
    }

    // Lấy access token từ authorization code
    public static String getAccessTokenFromCode(String code) throws IOException {
        GoogleAuthorizationCodeFlow flow = flow();
        // Thực hiện trao đổi code để lấy token response
        GoogleTokenResponse tokenResponse = flow.newTokenRequest(code)
                .setRedirectUri(REDIRECT_URI)
                .execute();
        // Trả về access token
        return tokenResponse.getAccessToken();
    }

    // Lấy thông tin người dùng từ Google
    public static Userinfo getUserInfo(String accessToken) throws IOException {
        Oauth2 oauth2 = new Oauth2.Builder(HTTP_TRANSPORT, JSON_FACTORY, null)
                .setApplicationName("Google OAuth 2.0")
                .build();
        Oauth2.Userinfo.Get request = oauth2.userinfo().get();
        request.setOauthToken(accessToken);
        return request.execute();
    }

    // GoogleUtils.java
    public static String getOAuthURL() throws UnsupportedEncodingException {
        String baseUrl = "https://accounts.google.com/o/oauth2/auth";
        String scope = URLEncoder.encode("https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email", "UTF-8");

        return baseUrl
                + "?client_id=" + CLIENT_ID
                + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                + "&response_type=code"
                + "&scope=" + scope
                + "&access_type=offline";
    }

}