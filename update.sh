#!/bin/bash
set -e

if [ ! -f .env ]; then
  echo "Error: .env file not found."
  echo "Please copy .env.example to .env and configure the variables before running."
  exit 1
fi

echo "Pulling latest n8n image..."
docker compose pull n8n

echo "Recreating n8n container..."
docker compose up -d n8n

echo "n8n updated successfully!"
