@echo off
title Telegram Bot Runner

echo ======================================================
echo       Starting Telegram Bot...
echo ======================================================
echo.

:: Check if .env exists
if exist .env goto check_token
if exist .env.example goto create_env
echo [X] Error: .env.example or .env file not found!
goto end_pause

:create_env
echo [!] .env file not found. Creating from .env.example...
copy .env.example .env > nul
echo [+] Created .env file successfully.
echo Please open .env and put your BOT_TOKEN, then run this file again.
start notepad.exe .env
goto end_pause

:check_token
:: Check if default token is changed
findstr /C:"YOUR_BOT_TOKEN_HERE" .env > nul
if %errorlevel% neq 0 goto run_bot
echo [X] Warning: You have not changed the default BOT_TOKEN in .env!
echo Please open .env and put your actual BOT_TOKEN.
start notepad.exe .env
goto end_pause

:run_bot
:: Run using virtual environment if it exists
if exist venv\Scripts\python.exe goto run_venv
echo [!] Virtual environment (venv) not found. Running with global python...
python bot.py
goto post_run

:run_venv
echo [+] Virtual environment found. Starting bot...
venv\Scripts\python.exe bot.py

:post_run
if %errorlevel% equ 0 goto end_pause
echo.
echo [X] Bot stopped running due to an error.

:end_pause
echo.
echo ======================================================
echo   Press any key to close this window.
echo ======================================================
pause
