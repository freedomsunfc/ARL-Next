@echo off
set ERLANG_HOME=C:\Program Files\Erlang OTP
set RABBITMQ_BASE=C:\demo\code\opencode\ARL\rabbitmq-data
start "RabbitMQ" /B "C:\Program Files\RabbitMQ Server\rabbitmq_server-4.0.7\sbin\rabbitmq-server.bat"
