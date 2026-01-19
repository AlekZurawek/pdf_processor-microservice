#!/bin/bash
set -e

echo "=========================================="
echo "   Docling Remote Deployment"
echo "=========================================="
echo ""

# Check for Docker
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed"
    echo "Please install Docker first: https://docs.docker.com/get-docker/"
    exit 1
fi

# Auto-detect NVIDIA GPU
GPU_AVAILABLE=false
if command -v nvidia-smi &> /dev/null; then
    if nvidia-smi &> /dev/null; then
        if docker info 2>/dev/null | grep -q "nvidia"; then
            GPU_AVAILABLE=true
        fi
    fi
fi

echo "Building and starting Docling service..."
echo "Note: First build may take 5-10 minutes to download models"
echo ""

if [ "$GPU_AVAILABLE" = true ]; then
    echo "NVIDIA GPU detected - enabling GPU acceleration"
    docker compose -f docker-compose.yml -f docker-compose.gpu.yml up -d --build
else
    echo "No NVIDIA GPU detected - running on CPU"
    docker compose up -d --build
fi

echo ""
echo "=========================================="
echo "   Docling is now running!"
echo "=========================================="
echo ""
echo "Endpoint: http://$(hostname -I | awk '{print $1}'):9000"
echo ""
echo "Use this endpoint in Partner Foundry setup wizard."
echo ""
echo "To view logs:"
echo "  docker compose logs -f"
echo ""
