/**
 * AVIS Universal Connect Layer v1
 */

export class AIBridge {
    constructor() {
        this.openAiKey = process.env.OPENAI_API_KEY;
        this.geminiKey = process.env.GEMINI_API_KEY;
    }

    async queryChatGPT(prompt, model = "gpt-4o") {
        const response = await fetch("https://openai.com", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${this.openAiKey}`
            },
            body: JSON.stringify({
                model: model,
                messages: [{ role: "user", content: prompt }]
            })
        });
        return response.json();
    }

    async queryGemini(prompt, model = "gemini-2.5-flash") {
        const url = `https://googleapis.com{model}:generateContent?key=${this.geminiKey}`;
        const response = await fetch(url, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                contents: [{ parts: [{ text: prompt }] }]
            })
        });
        return response.json();
    }
}
