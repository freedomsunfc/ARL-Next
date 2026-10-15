@echo off
set ERLANG_HOME=C:\Program Files\Erlang OTP
set RABBITMQ_BASE=%~dp0data\rabbitmq
for /d %%i in ("C:\Program Files\RabbitMQ Server\rabbitmq_server-*") do "%%i\sbin\rabbitmq-server.bat"
