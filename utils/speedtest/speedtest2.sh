#!/bin/bash
# آماده‌سازی فایل‌های موردنیاز
wget -O lite-linux-amd64.gz https://github.com/xxf098/LiteSpeedTest/releases/download/v0.14.1/lite-linux-amd64-v0.14.1.gz
gzip -d lite-linux-amd64.gz
wget -O lite_config.json https://raw.githubusercontent.com/tahmaseb73/Iran_Config_Collector/main/utils/speedtest/lite_config.json
# اجرای LiteSpeedTest
chmod +x ./lite-linux-amd64
./lite-linux-amd64 --config ./lite_config.json --test https://raw.githubusercontent.com/tahmaseb73/Iran_Config_Collector/main/bulk/merge3.txt > speedtest_output.log 2>&1
