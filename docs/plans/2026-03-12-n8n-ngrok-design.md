# Local n8n ngrok Exposure Implementation Plan

> **For Antigravity:** REQUIRED SUB-SKILL: Load executing-plans to implement this plan task-by-task.

**Goal:** Fix missing docker config for n8n image and re-configure ports to securely run fully locally, while providing an easy path for the user to expose n8n to the web using Ngrok only when needed for webhooks.

**Architecture:** We are updating the `docker-compose.yaml` to include the correct latest n8n image. We will bind the 5678 port to localhost (127.0.0.1) exclusively, preventing any incoming connections from the local network or internet by default. A separate script or command (Ngrok) can then be run by the user manually to safely tunnel traffic to this localhost port.

**Tech Stack:** Docker Compose, n8n, Ngrok (user-managed)

---

### Task 1: Add Missing n8n Image Definition

**Files:**
- Modify: `docker-compose.yaml:27-30`

**Step 1: Write the implementation**
The user commented out the `build: .` line but did not provide an image fallback. We need to define `image: docker.n8n.io/n8nio/n8n`.

**Expected Change:**
```yaml
  n8n:
    container_name: n8n
    image: docker.n8n.io/n8nio/n8n
    restart: unless-stopped
    ports:
      - "127.0.0.1:5678:5678"
```

### Task 2: Configure Port Binding and Webhook Environment Variable

**Files:**
- Modify: `docker-compose.yaml:55-58`

**Step 1: Write the implementation**
We will keep `127.0.0.1:5678:5678` as the port to secure n8n so only the machine running Docker can access it directly. We need to review the `WEBHOOK_URL` and `N8N_HOST` configuration to be aware that the domain might change dynamically via `ngrok`.
Note: Setting WEBHOOK_URL explicitly to ngrok breaks it when ngrok is off. Since this is an on-demand tunnel, we will leave the default webhook settings (which fallback to localhost) and advise the user.

**Expected Change:**
```yaml
      - N8N_HOST=${N8N_HOST:-localhost}
      - N8N_PORT=5678
      - N8N_PROTOCOL=${N8N_PROTOCOL:-http}
      # The webhook URL will automatically pick up N8N_HOST, but when running ngrok, 
      # the user needs to export WEBHOOK_URL=https://<ngrok-id>.ngrok.app in their terminal before launching compose,
      # OR just pass it as WEBHOOK_URL. We will define it smoothly.
      - WEBHOOK_URL=${WEBHOOK_URL:-${N8N_PROTOCOL}://${N8N_HOST}/}
```

### Task 3: Clean up comments and obsolete configs

**Files:**
- Modify: `docker-compose.yaml` (various lines)

**Step 1: Write the implementation**
Clean up the remaining parts of the file to make it production-ready and clearly documented for Ngrok tunnel usage.
Add a comment for the user detailing how to run it.

### Task 4: Verify syntax and complete

**Files:**
- Run: `docker compose config`
- Goal: Verify the `docker-compose.yaml` is valid markup.
