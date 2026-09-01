<a target="_self" title="CLICK HERE to ENTER the GATEWAY FREE!" href="https://mercwar.github.io/Constellation/index.html">
<img 
    src="https://raw.githubusercontent.com/mercwar/Robo-Knight-Gallery/refs/heads/main/Version%207/image_d2a07390.png" 
    alt="Mercwar Constellation" 
    style="width:100%; height:auto;"
/>
</a>

---

## 🔥 ...And now, the Official Fire-Gem-v2  Readme 💎 


<img 
    src="../images/ChatGPT%20Image%20Sep%201%2C%202026%2C%2003_19_26%20PM.png" 
    alt="Fire-Gem-v2" 
    style="width:100%; height:auto;"
/>


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

------------------------------
## 💎 Operations & Compilation Guide 💎
    src="../images/ChatGPT%20Image%20Sep%201%2C%202026%2C%2003_19_26%20PM.png" 
    alt="Fire-Gem-v2" 
    style="width:100%; height:auto;"
/>

## **This guide provides the exact operational steps to: **

- configure 
- build  
- run  
- FireGem V2 Win64.
<img 
    src="../images/ChatGPT%20Image%20Sep%201%2C%202026%2C%2003_19_26%20PM.png" 
    alt="Fire-Gem-v2" 
    style="width:100%; height:auto;"
/>

------------------------------
## 🛠️ Step 1: Prepare the Windows Environment
You need the native Microsoft C++ compiler toolchain (cl.exe) to build this project without relying on bloated dependencies.

   1. Download and open the Visual Studio 2022 Installer.
   2. Select the Desktop development with C++ workload.
   3. Verify that the MSVC v143 build tools and Windows 11 SDK components are checked on the right-hand configuration panel.
   4. Complete the installation and restart your system if prompted.

------------------------------
## 📂 Step 2: Establish the Workspace Structure
Open a Windows Command Prompt (cmd.exe) and execute the following block to create the standardized file sandbox:

mkdir C:\ggml_clean
mkdir C:\ggml_clean\cJSON
mkdir C:\ggml_clean\include
mkdir C:\ggml_clean\lib

------------------------------
## 📦 Step 3: Extract and Stage Dependencies
FireGem relies on two external components: llama.cpp for tensor math and cJSON for reading your model lists.
## 1. Compile llama.cpp

   1. Clone the repository to your disk: git clone https://github.com C:\llama_source
   2. Open a terminal inside that folder and run CMake to build the optimized libraries:
   
   cmake -B build -S . -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DLLAMA_BUILD_EXAMPLES=OFF
   cmake --build build --config Release
   
   3. Move the Assets:
   * Move the generated static libraries (llama.lib, ggml.lib, and any variant sub-libs like ggml-base.lib) into C:\ggml_clean\lib\.
      * Move all core engine headers (.h files) from the source include directories into C:\ggml_clean\include\.
   
## 2. Stage cJSON

   1. Download cJSON.c and cJSON.h directly from the [Official cJSON GitHub](https://github.com/DaveGamble/cJSON).
   2. Save both files directly inside C:\ggml_clean\cJSON\.

------------------------------
## ⚡ Step 4: Execute the Compilation Matrix
Create an automated build script named build.bat inside C:\ggml_clean\. This script loads the compiler shell, sets up optimizations, includes your header structures, and links the native Windows graphical subsystems (user32, gdi32) alongside your engine libraries:

@echo off
:: Initialize the x64 native MSVC compiler tools environment variables
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"

echo [*] Compiling FireGem V2 Release Architecture...
cl.exe /O2 /W3 /MT /EHsc main.c json_loader.c ui_main.c llm_wrapper.c cJSON\cJSON.c /I. /I.\include /link /LIBPATH:.\lib llama.lib ggml.lib user32.lib gdi32.lib shell32.lib /OUT:firegem.exe

if %ERRORLEVEL% EQU 0 (
    echo [─── SUCCESS ───] Target binary generated: firegem.exe
)
pause

------------------------------
## 🏃 Step 5: Configure Inventory and Launch
Before firing up the interface, the app needs to know where your model weights are saved on your computer.

   1. Create a file named models.json inside C:\ggml_clean\.
   2. Add your local .gguf file information using the layout below (ensure all folder backslashes are properly escaped with a double \\):
   
   [
       {
           "filename": "phi-4-IQ2_XS.gguf",
           "path": "E:\\LLM\\MODELS",
           "size": "4.17 GB"
       }
   ]
   
   3. Run build.bat to compile the source code.
   4. Launch firegem.exe. The application will instantly open a Win32 list box window displaying your available models. Select your target profile and click the initialization button to launch your local engine.

------------------------------

