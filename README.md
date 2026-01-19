# Docling Remote Deployment

## Quick Start (One Command)

### Windows:
Double-click `start.bat`

### Linux/Mac:
```
chmod +x start.sh && ./start.sh
```

That's it! GPU is auto-detected. No manual configuration needed.

## What Happens

1. Script detects if you have NVIDIA GPU
2. Automatically enables GPU acceleration if available
3. Falls back to CPU if no GPU found
4. Shows your endpoint when ready

## LLM Configuration

This package is pre-configured with your LLM settings from Partner Foundry:
- LLM Endpoint: http://host.docker.internal:8080
- Model: gemma3:27b

Docling uses this LLM for AI-powered document processing.

## After Starting

Enter in Partner Foundry setup wizard:
- Endpoint: http://YOUR_SERVER_IP:9000

## System Requirements

- Docker and Docker Compose
- Minimum 4GB RAM (8GB+ recommended)
- First build downloads ~2GB of models
- Network access to your LLM endpoint

## Troubleshooting

View logs:
```
docker compose logs -f
```

Test the service:
```
curl http://localhost:9000/health
```
