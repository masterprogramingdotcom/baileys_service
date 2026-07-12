# Use an official Node.js runtime as a parent image (Alpine for a smaller footprint)
FROM node:20-alpine

# Install git so we can clone the source code
RUN apk update && apk add --no-cache git

# Set the working directory inside the container
WORKDIR /app

# Clone the actual Baileys API repository into the container's working directory
RUN git clone https://github.com/fazer-ai/baileys-api.git .

# Install bun (required for some scripts in the repo)
RUN npm install -g bun

# Install the project dependencies (ignore-scripts to skip failing git-hooks)
RUN npm install --legacy-peer-deps --ignore-scripts

# Build the TypeScript code (if required by the repo)
RUN npm run build || true

# Expose the port the app runs on
EXPOSE 3025

# Command to run the application
CMD ["npm", "start"]
