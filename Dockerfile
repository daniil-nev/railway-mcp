FROM node:16-bullseye

# Install system dependencies: Python, pip, Docker CLI, and curl
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    docker.io \
    curl \
  && rm -rf /var/lib/apt/lists/*

# Install global npm packages for uv (uvx removed)
RUN npm install -g uv

# Optionally, install uvicorn via pip if needed for any MCP servers
RUN pip3 install uvicorn

# Set the working directory
WORKDIR /app

# Copy package files and install Node dependencies (npx is included with Node)
COPY package*.json ./
RUN npm install

# Copy all application source files (index.js, config.json, etc.)
COPY . .

# Expose port 8000 (for uv/uvicorn based servers; adjust as needed)
EXPOSE 8000

# Start the application
CMD ["node", "index.js"]
