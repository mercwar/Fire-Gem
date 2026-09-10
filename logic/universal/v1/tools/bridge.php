<?php
/**
 * AVIS Core v1 - Unified AI Bridge
 */

class AIBridge {
    private $openai_key;
    private $gemini_key;

    public function __construct() {
        $this->openai_key = getenv('OPENAI_API_KEY');
        $this->gemini_key = getenv('GEMINI_API_KEY');
    }

    public function queryChatGPT($prompt, $model = "gpt-4o") {
        $url = "https://openai.com";
        $data = [
            "model" => $model,
            "messages" => [["role" => "user", "content" => $prompt]]
        ];
        
        return $this->executeCurl($url, $data, [
            "Authorization: Bearer " . $this->openai_key,
            "Content-Type: application/json"
        ]);
    }

    public function queryGemini($prompt, $model = "gemini-2.5-flash") {
        $url = "https://googleapis.com" . $model . ":generateContent?key=" . $this->gemini_key;
        $data = [
            "contents" => [["parts" => [["text" => $prompt]]]]
        ];

        return $this->executeCurl($url, $data, ["Content-Type: application/json"]);
    }

    private function executeCurl($url, $data, $headers) {
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        $response = curl_exec($ch);
        curl_close($ch);
        return json_decode($response, true);
    }
}
