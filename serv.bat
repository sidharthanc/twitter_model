@echo off

taskkill /F /IM jruby.exe
taskkill /F /IM javaw.exe
del tmp\pids\server.pid
rails s

EXIT