@echo off
cd /d %~dp0backend
set PYTHONIOENCODING=utf-8
if exist venv\Scripts\activate.bat (
    call venv\Scripts\activate.bat
) else (
    echo Creating Python virtual environment...
    python -m venv venv
    call venv\Scripts\activate.bat
    pip install -r requirements.txt --quiet
    pip install -e ARL-NPoC --quiet
)
celery -A app.celerytask.celery worker -l info -Q arltask_light,arltask_heavy,arlgithub
