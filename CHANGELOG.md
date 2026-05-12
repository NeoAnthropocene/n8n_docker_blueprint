# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- `.env.example` file to securely manage environment variables (like credentials and Ngrok URLs) and avoid Docker warnings.
- Environment existence check in `update.sh` to prevent execution without a `.env` file.
- `update.sh` script to easily pull the latest n8n image and restart the container.
- `README.md` containing usage documentation, secure deployment explanations, and Ngrok instructions.

### Changed
- Removed deprecated `version: '3.9'` attribute from `docker-compose.yaml` to fix runtime warnings.
- `docker-compose.yaml` port mappings are now bound exclusively to `127.0.0.1` for enhanced local security.
- Dynamically configurable `WEBHOOK_URL` in `docker-compose.yaml` to easily switch between local usage and Ngrok tunnels.
