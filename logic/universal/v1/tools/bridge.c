#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>

void query_chatgpt(const char* prompt) {
    CURL *curl = curl_easy_init();
    if(curl) {
        struct curl_slist *headers = NULL;
        char auth_header[256];
        snprintf(auth_header, sizeof(auth_header), "Authorization: Bearer %s", getenv("OPENAI_API_KEY"));
        
        headers = curl_slist_append(headers, "Content-Type: application/json");
        headers = curl_slist_append(headers, auth_header);

        char payload[1024];
        snprintf(payload, sizeof(payload), "{\"model\": \"gpt-4o\", \"messages\": [{\"role\": \"user\", \"content\": \"%s\"}]}", prompt);

        curl_easy_setopt(curl, CURLOPT_URL, "https://openai.com");
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, payload);

        curl_easy_perform(curl);
        curl_easy_cleanup(curl);
        curl_slist_free_all(headers);
    }
}
