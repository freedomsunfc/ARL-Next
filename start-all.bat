@echo off
cd /d %~dp0
echo ========================================
echo    ARL-Next Local Deployment Launcher
echo ========================================
echo.

echo [1/5] Starting MongoDB...
if netstat -an | findstr ":27018.*LISTENING" >nul 2>&1 (
    echo   MongoDB already running.
) else (
    echo   MongoDB NOT running. Please start it manually:
    echo   Check: C:\Program Files\MongoDB\Server\*\bin\mongod.exe
)

echo [2/5] Starting RabbitMQ...
if netstat -an | findstr ":5673.*LISTENING" >nul 2>&1 (
    echo   RabbitMQ already running.
) else (
    echo   Starting RabbitMQ...
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c %~dp0start-rabbitmq.bat" -WindowStyle Hidden
)

echo [3/5] Starting Flask Backend...
if netstat -an | findstr ":5003.*LISTENING" >nul 2>&1 (
    echo   Flask Backend already running.
) else (
    echo   Starting Flask Backend...
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c %~dp0start-backend.bat" -WindowStyle Hidden
)

echo [4/5] Starting Celery Worker...
tasklist /FI "IMAGENAME eq celery.exe" 2>nul | findstr /I "celery.exe" >nul 2>&1
if %ERRORLEVEL%==0 (
    echo   Celery Worker already running.
) else (
    echo   Starting Celery Worker...
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c %~dp0start-worker.bat" -WindowStyle Hidden
)

echo [5/5] Starting Frontend...
if netstat -an | findstr ":5173.*LISTENING" >nul 2>&1 (
    echo   Frontend already running.
) else (
    echo   Starting Frontend...
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c %~dp0start-frontend.bat" -WindowStyle Hidden
)

echo.
echo ========================================
echo    All services launched!
echo    Access: http://localhost:5173
echo    Login:  admin / arlpass
echo ========================================
echo.
echo Waiting 15 seconds for services to initialize...
timeout /t 15 /nobreak >nul

echo.
echo Service Status Check:
netstat -an | findstr ":27018.*LISTENING" && echo   MongoDB:   RUNNING || echo   MongoDB:   NOT RUNNING
netstat -an | findstr ":5673.*LISTENING" && echo   RabbitMQ:  RUNNING || echo   RabbitMQ:  NOT RUNNING
netstat -an | findstr ":5003.*LISTENING" && echo   Backend:   RUNNING || echo   Backend:   NOT RUNNING
netstat -an | findstr ":5173.*LISTENING" && echo   Frontend:  RUNNING || echo   Frontend:  NOT RUNNING
pause
