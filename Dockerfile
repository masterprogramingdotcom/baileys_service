# Use the official Bun image since this is a Bun-native project
FROM oven/bun:alpine

# Install git so we can clone the source code
RUN apk update && apk add --no-cache git

# Set the working directory inside the container
WORKDIR /app

# Clone the actual Baileys API repository into the container's working directory
RUN git clone https://github.com/fazer-ai/baileys-api.git .

# Install the project dependencies using Bun natively
RUN bun install

# Create a startup script that ensures the API key is injected
RUN echo 'bun scripts/manage-api-keys.ts create admin ${API_KEY:-87f4e9a8ea7d2abff66acdcb365bf2a6} && bun src/index.ts' > /app/start.sh

# Patch package.json so ANY start command Render uses will execute our script
RUN sed -i 's|"start": "bun src/index.ts"|"start": "sh /app/start.sh"|g' package.json

# Expose the port the app runs on
EXPOSE 3025

# Command to run the application using Bun natively
CMD ["sh", "/app/start.sh"]
