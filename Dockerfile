# ===== 1. Base Image =====
FROM node:22

# ===== 2. Install system dependencies =====
RUN apt-get update && apt-get install -y \
    git unzip python3 python3-pip tmux \
    wget apt-transport-https gnupg lsb-release \
    && rm -rf /var/lib/apt/lists/*

# ===== 3. Set working directory =====
WORKDIR /app

# ===== 4. Copy your project (instead of git clone) =====
COPY . .

# ===== 5. Install Node.js dependencies =====
RUN npm install

# ===== 6. Install Java (needed for Minecraft server) =====
RUN wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | apt-key add - \
    && echo "deb https://packages.adoptium.net/artifactory/deb $(lsb_release -cs) main" > /etc/apt/sources.list.d/adoptium.list \
    && apt-get update && apt-get install -y temurin-21-jdk

# ===== 7. Install AWS CLI (required by mindcraft-bots sometimes) =====
RUN wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -O awscliv2.zip \
    && unzip awscliv2.zip && ./aws/install

# ===== 8. Optional: Unzip server data if needed =====
RUN if [ -f server_data.zip ]; then unzip server_data.zip; fi

# ===== 9. Expose port for the bot =====
EXPOSE 8000

# ===== 10. Default command when container starts =====
CMD ["node", "main.js"]

