<a target="_self" title="CLICK HERE to ENTER the GATEWAY FREE!" href="https://mercwar.github.io/Constellation/index.html">
<img 
    src="https://raw.githubusercontent.com/mercwar/Robo-Knight-Gallery/refs/heads/main/Version%207/image_d2a07390.png" 
    alt="Mercwar Constellation" 
    style="width:100%; height:auto;"
/>
</a>

---

##  🔥 Fire-Gem-v2 for MSVC Windows 11 is here 💎 


<img 
    src="../images/ChatGPT%20Image%20Sep%201%2C%202026%2C%2003_19_26%20PM.png" 
    alt="Fire-Gem-v2" 
    style="width:100%; height:auto;"
/>


# FireGem V2

## 🔥 Overview
FireGem V2 is a Windows‑based lightweight engine that integrates **GGUF models** with a custom **Win32 UI**. It streamlines loading, managing, and running local LLM models using the **llama.cpp** backend, with a focus on simplicity, portability, and a self‑contained build system.

---

## ✨ Features
- **Self‑contained build system** — batch scripts isolate sources, headers, and libraries into a clean folder.
- **Win32 UI integration** — graphical interface with list boxes for model selection.
- **JSON model loader** — powered by cJSON to parse `models.json`.
- **llama.cpp backend** — links against `llama.lib` and `ggml` libraries for execution.
- **Portable repository layout** — all dependencies staged into `ggml_clean` for easy distribution.

---

## 📂 Repository Structure
```
C:\ggml_clean\
  ├── build.bat          # Compilation script
  ├── firegem.exe        # Built executable
  ├── models.json        # Model list configuration
  ├── json_loader.c/.h   # JSON parsing module
  ├── ui_main.c/.h       # Win32 UI module
  ├── llm_wrapper.c/.h   # llama.cpp wrapper module
  ├── main.c             # Application entry point
  ├── cJSON\             # cJSON dependency
  ├── include\           # llama.cpp + ggml headers
  └── lib\               # Prebuilt libraries (llama.lib, ggml.lib, etc.)
```

---

## ⚙️ Build Instructions
1. Install **Visual Studio 2022 Build Tools** with MSVC.  
2. Clone llama.cpp and build it to produce `llama.lib` and `ggml` libraries.  
3. Clone cJSON and place `cJSON.c` and `cJSON.h` in the `cJSON` folder.  
4. Run `build.bat` inside `C:\ggml_clean` to compile FireGem.  

---

## 🚀 Usage
- Edit `models.json` to list your GGUF models.  
- Launch `firegem.exe`.  
- Select a model from the UI list box.  
- FireGem initializes llama.cpp with the chosen model and provides an interactive session.  

---

## 📑 Example `models.json` 
#### Modify this file yourself with your local *.gguf files on disk
```json
[
    {
        "filename": "phi-4-IQ2_XS.gguf",
        "path": "E:\\Apache24\\htdocs\\FIRE-GEM\\LLM\\MODELS",
        "type": "GGUF File",
        "date_modified": "3/29/2026 8:11 PM",
        "size": "4.17 GB"
    },
    {
        "filename": "phi-4-Q4_K.gguf",
        "path": "E:\\Apache24\\htdocs\\FIRE-GEM\\LLM\\MODELS",
        "type": "GGUF File",
        "date_modified": "3/16/2026 5:31 AM",
        "size": "8.43 GB"
    },
    {
        "filename": "Qwen2.5-Coder-0.5B-f16.gguf",
        "path": "E:\\Apache24\\htdocs\\FIRE-GEM\\LLM\\MODELS",
        "type": "GGUF File",
        "date_modified": "4/4/2026 4:19 AM",
        "size": "948 MB"
    },
    {
        "filename": "qwen2.5-coder-0.5b-q8_0.gguf",
        "path": "E:\\Apache24\\htdocs\\FIRE-GEM\\LLM\\MODELS",
        "type": "GGUF File",
        "date_modified": "4/3/2026 7:14 PM",
        "size": "506 MB"
    },
	    {
        "filename": "qwen2.5-coder-1.5b-instruct-q4_k_m.gguf",
        "path": "E:\\models",
        "type": "GGUF File",
        "date_modified": "4/4/2026 4:23 AM",
        "size": "1.1 MB"
    },
    {
        "filename": "Qwen2.5-VL-7B-Instruct-UD-IQ1_M.gguf",
        "path": "E:\\models",
        "type": "GGUF File",
        "date_modified": "4/4/2026 4:30 AM",
        "size": "2.2 GB"
    }
]
```

---

## 📜 License
FireGem V2 is distributed under the MIT License. See LICENSE file for details.

---

## 🙌 Credits
- Built on [llama.cpp](https://github.com/ggerganov/llama.cpp)  
- Uses [cJSON](https://github.com/DaveGamble/cJSON)  

---
