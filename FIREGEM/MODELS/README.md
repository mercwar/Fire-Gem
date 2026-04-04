[Read more](https://github.com/mercwar/Fire-Gem/tree/main/FIREGEM) about the NEW FIRE‑GEM

# 🔥 FIRE‑GEM Model Compatibility Guide  
### **Supported GGUF Models + Download Links**

- **SmolLM2‑135M‑Instruct‑f16.gguf**  
- **Qwen2.5‑Coder‑1.5B‑Instruct.Q8_0.gguf**  
- **phi‑4‑IQ2_XS.gguf**  
- **SmolLM‑135M‑Instruct_Q3_K_M.gguf**



FIRE‑GEM supports any **llama.cpp‑compatible `.gguf` model**, but the models below are the ones **tested and verified** to run correctly inside the FIRE‑GEM neural engine.

---

# ✅ **Primary Recommended Models**

## **Qwen2.5‑Coder‑1.5B‑Instruct.Q8_0.gguf**  
**Type:** Coding + Shell + Chat  
**Performance:** Excellent  
**Stability:** 100%  
**Recommended:** ⭐⭐⭐⭐⭐ (Best overall)

**Download:**  
https://huggingface.co/Qwen/Qwen2.5-Coder-1.5B-Instruct-GGUF

This is the **main model** recommended for FIRE‑GEM.  
It loads fast, runs stable, and handles:

- C, C++, C#, Python, Batch, PowerShell  
- Shell commands  
- Debugging  
- Error explanation  
- File operations  
- Multi‑step reasoning  

This is the model FIRE‑GEM was tuned around.

---

# 🟦 **Included Starter Models**


## **SmolLM2‑135M‑Instruct‑f16.gguf**  
**Type:** Tiny instruct model  
**Size:** ~90–100 MB  
**Stability:** 100%  
**Recommended for:** Testing FIRE‑GEM, low‑RAM systems

**Download:**  
https://huggingface.co/HuggingFaceTB/SmolLM2-135M-Instruct-GGUF


---

## **SmolLM‑135M‑Instruct_Q3_K_M.gguf**  
**Type:** Quantized tiny instruct model  
**Size:** ~50–70 MB  
**Stability:** 100%  
**Recommended for:** Ultra‑low RAM, instant loading

**Download:**  
https://huggingface.co/HuggingFaceTB/SmolLM2-135M-Instruct-GGUF

This is the smaller quantized version of SmolLM2.  
It loads instantly and is ideal for verifying that FIRE‑GEM is working.

---

# 🟧 **Additional Compatible Model**

## **phi‑4‑IQ2_XS.gguf**  
**Type:** Small reasoning model  
**Size:** ~200–250 MB  
**Stability:** Good  
**Recommended for:** Lightweight reasoning, small tasks

**Download:**  
https://huggingface.co/microsoft/Phi-4-GGUF

This model runs inside FIRE‑GEM but is not as strong as Qwen2.5‑Coder for coding tasks.

---

# ❌ **Models Not Recommended**

These models are known to **crash** or fail to load in FIRE‑GEM:

- DeepSeek‑Coder (all sizes)  
- DeepSeek‑Chat (all sizes)  
- DeepSeek‑R1 (all sizes)

They are excluded for stability reasons.

---

# 📁 **Where to Place Models**

Users should put all `.gguf` files into:

```
FIRE-GEM/LLM/models/
```

FIRE‑GEM will automatically detect them in the **Model Selector**.

---

# 🤖 **How to Use Models in FIRE‑GEM**
```
 1. Launch **fire-gem.exe**  
 2. Select a model from the **Model Selector**  
 3. Type into the **right input box** to talk to the robot  
 4. Type into the **left input box** to run system commands  

Example prompts:

"Write hello world batch file."

"Write a C funciton that opens a file."

"Generate a batch script that deletes empty folders."
```
----
# 🔥 FIRE‑GEM Model Downloads

📁 Where to Place Models
Put all .gguf files into:

Code
FIRE-GEM/LLM/models/
FIRE‑GEM will automatically detect them in the Model Selector.
Got it. Here is the full **AVIS Neural Engine** guide with the direct download links for the verified models. 

### 📁 THE MODELS FOLDER (`/LLM/MODELS/`)
To ensure the **"Stitching"** logic works, move all downloaded `.gguf` files into:
`C:\Apache24\htdocs\FIRE-GEM\LLM\MODELS\`

---

### ✅ OFFICIAL DOWNLOAD REPOSITORY

| Model Name | Type | Stability | Download Link (HuggingFace) |
| :--- | :--- | :--- | :--- |
| **Qwen2.5-Coder-1.5B** | **Coding / Shell** | ⭐⭐⭐⭐⭐ | [**Download Q8_0**](https://huggingface.co/Qwen/Qwen2.5-Coder-1.5B-Instruct-GGUF) |
| **SmolLM2-135M-f16** | **Fast Testing** | ✅ 100% | [**Download F16**](https://huggingface.co/HuggingFaceTB/SmolLM2-135M-Instruct-GGUF) |
| **SmolLM-135M-Q3_K** | **Ultra-Low RAM** | ✅ 100% | [**Download Q3_K_M**](https://huggingface.co/HuggingFaceTB/SmolLM2-135M-Instruct-GGUF) |
| **phi-4-IQ2_XS** | **Reasoning** | ⚠️ Good | [**Download IQ2_XS**](https://huggingface.co/microsoft/Phi-4-GGUF) |

---

### 🛠️ REVISED STITCHING LOGIC (Full Review)

Ensure your `avis_llama.cpp` uses the **Absolute Path** and the **Wide-String** format to prevent the "Empty Filename" error we hit earlier.

---
Here you go, Demon — a **clean, professional, GitHub‑ready “Getting Started / Repo Clone” section** with **full copyright**, formatted exactly the way a real open‑source project would present it.

No fluff. No extras. Just a tight, polished block you can drop directly into your README.

---

# 🚀 **Getting Started — Clone & Run FIRE‑GEM**

Follow these steps to download, install, and run the FIRE‑GEM Cyborg AI Engine on your system.

## 📥 **1. Clone the Repository**

Open a terminal and run:

```bash
git clone https://github.com/mercwar/Fire-Gem.git
```

Then enter the directory:

```bash
cd Fire-Gem
```

FIRE‑GEM is now on your machine.

---

## 📦 **2. Add Your Models**

Place any `.gguf` model into:

```
FIRE-GEM/LLM/models/
```

FIRE‑GEM will automatically detect it in the **Model Selector**.

### Supported Models (Direct Downloads)

- **SmolLM2‑135M‑Instruct‑f16.gguf**  
  https://huggingface.co/HuggingFaceTB/SmolLM2-135M-Instruct-GGUF

- **SmolLM‑135M‑Instruct_Q3_K_M.gguf**  
  https://huggingface.co/HuggingFaceTB/SmolLM2-135M-Instruct-GGUF  
  *(Scroll to the Q3_K_M file.)*

- **Qwen2.5‑Coder‑1.5B‑Instruct.Q8_0.gguf**  
  https://huggingface.co/Qwen/Qwen2.5-Coder-1.5B-Instruct-GGUF

- **phi‑4‑IQ2_XS.gguf**  
  https://huggingface.co/microsoft/Phi-4-GGUF

---

## ▶️ **3. Run FIRE‑GEM**

Launch the executable:

```
fire-gem.exe
```

Then:

- Select a model from the **Model Selector**
- Use the **right input box** to talk to the robot
- Use the **left input box** to run system commands
- Use the **file navigator** to browse and execute files

Example robot prompts:

```
write a C function that prints a directory tree
```

```
explain this error:
'hTree' was not declared in this scope
```

```
generate a batch script that deletes empty folders
```

---

# © **Copyright Notice**

```
Copyright (c) 2024–2026
mercwar — FIRE‑GEM Cyborg AI Engine

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
