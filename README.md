# n8n Docker Blueprint

This repository provides a docker-compose blueprint to run [n8n](https://n8n.io/) locally in a secure manner.

## Secure Local Deployment

By default, the `docker-compose.yaml` is configured to bind the n8n web interface exclusively to your local machine:
`127.0.0.1:5678:5678`

This ensures that no one else on your local network or the internet can access your n8n instance unless you explicitly expose it.

## Setup

Before running the application, set up your environment variables to ensure Docker doesn't throw warnings and your credentials remain secure:
```bash
cp .env.example .env
```
Edit the `.env` file to customize your database passwords and configure the `N8N_ENCRYPTION_KEY`.

## Exposing via Ngrok for Webhooks

If you need to test or receive webhooks from external services (e.g., GitHub, Stripe), you can temporarily expose your local instance using [Ngrok](https://ngrok.com/).

1. Start your n8n instance using the update script:
   ```bash
   ./update.sh
   ```
2. In a separate terminal, start Ngrok pointing to the n8n port:
   ```bash
   ngrok http 5678
   ```
3. Ngrok will provide a Forwarding URL (e.g., `https://<your-id>.ngrok-free.app`).
4. To ensure n8n uses this URL for webhook generation, open your `.env` file and update the `WEBHOOK_URL` variable:
   ```env
   WEBHOOK_URL=https://<your-id>.ngrok-free.app/
   ```
5. Restart your n8n instance by running `./update.sh` again to apply the changes!

## Updating n8n

To easily update to the latest n8n version without losing your configurations, run the provided update script:
```bash
./update.sh
```
This will pull the latest Docker image and restart the container seamlessly.
