@echo off
echo ==========================================
echo    Docling Remote Deployment
echo ==========================================
echo.

:: Check for Docker
where docker >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Docker is not installed
    echo Please install Docker Desktop first: https://docs.docker.com/desktop/windows/
    pause
    exit /b 1
)

:: Auto-detect NVIDIA GPU
set GPU_AVAILABLE=0
where nvidia-smi >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    nvidia-smi >nul 2>nul
    if %ERRORLEVEL% EQU 0 (
        set GPU_AVAILABLE=1
    )
)

echo Building and starting Docling service...
echo Note: First build may take 5-10 minutes to download models
echo.

if %GPU_AVAILABLE% EQU 1 (
    echo NVIDIA GPU detected - enabling GPU acceleration
    docker compose -f docker-compose.yml -f docker-compose.gpu.yml up -d --build
) else (
    echo No NVIDIA GPU detected - running on CPU
    docker compose up -d --build
)

echo.
echo ==========================================
echo    Docling is now running!
echo ==========================================
echo.
echo Endpoint: http://localhost:9000
echo.
echo Use this endpoint in Partner Foundry setup wizard.
echo.
echo To view logs:
echo   docker compose logs -f
echo.
pause
