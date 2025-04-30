package util;

import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

public class Recaptcha {
    private static final String SECRET_KEY = "6Ld7jR8rAAAAAGvPn6bJlcUS5-Ato4HbKjeoBJOA";

    public static boolean verify(String responseToken) {
        try {
            URL url = new URL("https://www.google.com/recaptcha/api/siteverify");
            String postData = "secret=" + SECRET_KEY + "&response=" + responseToken;

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            try (OutputStream out = conn.getOutputStream()) {
                out.write(postData.getBytes());
            }

            Scanner in = new Scanner(new InputStreamReader(conn.getInputStream()));
            StringBuilder json = new StringBuilder();
            while (in.hasNext()) {
                json.append(in.nextLine());
            }

            return json.toString().contains("\"success\": true");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
