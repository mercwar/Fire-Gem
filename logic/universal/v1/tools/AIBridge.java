package universal.v1.tools;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

public class AIBridge {
    private final String openAiKey = System.getenv("OPENAI_API_KEY");
    private final String geminiKey = System.getenv("GEMINI_API_KEY");
    private final HttpClient httpClient = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(10))
            .build();

    public String queryChatGPT(String prompt) throws Exception {
        String jsonPayload = """
        {
            "model": "gpt-4o",
            "messages": [{"role": "user", "content": "%s"}]
        }
        """.formatted(prompt.replace("\"", "\\\""));

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://openai.com"))
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + openAiKey)
                .POST(HttpRequest.BodyPublishers.ofString(jsonPayload))
                .build();

        return httpClient.send(request, HttpResponse.BodyHandlers.ofString()).body();
    }

    public String queryGemini(String prompt) throws Exception {
        String jsonPayload = """
        {
            "contents": [{"parts":[{"text": "%s"}]}]
        }
        """.formatted(prompt.replace("\"", "\\\""));

        String url = "https://googleapis.com" + geminiKey;

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(jsonPayload))
                .build();

        return httpClient.send(request, HttpResponse.BodyHandlers.ofString()).body();
    }
}
