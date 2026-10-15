@echo off
cd /d %~dp0frontend
if not exist node_modules (
    echo Installing frontend dependencies...
    call npm install --legacy-peer-deps --quiet
)
npx vite --host 0.0.0.0 --port 5173
