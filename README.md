*Image* : https://hub.docker.com/r/aurel126/minecraft-ollama-bot

🧠 Minecraft + Local AI Bot (Dockerized)

This project provides a fully containerized environment that connects a Minecraft server with an AI-powered bot using Node.js, Ollama, and local LLM models.
It allows AI agents to join a live Minecraft world, chat with players, make decisions, explore, and perform real in-game actions — all without any manual setup.


✅ What’s Inside the Docker Image

✔ Node.js AI Bot — runs the bot logic and connects to Minecraft
✔ Ollama LLM Client — sends prompts to a local Ollama server for reasoning
✔ Java (Temurin 21) & Python 3 — required for Minecraft and AI libraries
✔ AWS CLI, Git, unzip, curl, system tools — preinstalled for automation
✔ Minecraft server support (via external container)
✔ Support for custom LLMs like sweaterdog/andy-4, embeddinggemma, etc.

You only need Docker & Docker Compose — no manual installation of Minecraft, Node.js, Java, or Python.


🚀 Features

🤖 AI agents that chat, navigate, interact and perform actions in Minecraft

🧠 Uses local LLM inference via Ollama (works completely offline)

🗺️ Compatible with Vanilla Minecraft 1.20.2

🔄 Optional ViaProxy support for cross-version player compatibility

📦 Everything packaged inside Docker — easy to deploy on any machine or server

💾 Persistent volumes for saving Minecraft worlds and Ollama model data


🛠️ Full automation: pull → compose up → bot connects automatically

```
docker pull aurel126/minecraft-ollama-bot:latest
docker compose up -d
```


Example docker-compose.yml :

```
services:
  app:
    image: aurel126/minecraft-ollama-bot:latest
    environment:
      - OLLAMA_HOST=http://ollama:11434
    depends_on:
      ollama:
        condition: service_healthy
      minecraft:
        condition: service_healthy

  ollama:
    image: ollama/ollama:latest
    ports:
      - "11434:11434"
    volumes:
      - ollama_data:/root/.ollama
    healthcheck:
      test: ["CMD", "ollama", "list"]
      interval: 10s
      retries: 5

  minecraft:
    image: itzg/minecraft-server
    environment:
      EULA: "TRUE"
      VERSION: "1.20.2"
    ports:
      - "25565:25565"
    volumes:
      - mc_data:/data
    healthcheck:
      test: ["CMD", "mc-health"]
      interval: 10s
      retries: 5

volumes:
  mc_data:
  ollama_data:

```


⚙️ Included Inside the Image

| Component             | Version / Type            |
| --------------------- | ------------------------- |
| Node.js               | 22                        |
| Java                  | Temurin 21 (OpenJDK)      |
| Python                | 3.x + pip + boto3         |
| Minecraft Integration | Via mineflayer & RCON     |
| LLM Support           | Ollama API                |
| System Tools          | git, unzip, curl, AWS CLI |
| OS Base Image         | node:22 (Debian)          |


🛑 Requirements

Docker & Docker Compose installed

At least 6 GB RAM recommended (Minecraft + LLM)

GPU optional (faster model inference with Ollama)

Linux, Windows or macOS supported
