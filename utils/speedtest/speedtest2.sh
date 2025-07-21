#!/bin/bash
# آماده‌سازی فایل‌های موردنیاز
wget -O utils/speedtest/lite-linux-amd64.gz https://github.com/xxf098/LiteSpeedTest/releases/download/v0.14.1/lite-linux-amd64-v0.14.1.gz
gzip -d utils/speedtest/lite-linux-amd64.gz
wget -O utils/speedtest/lite_config.json https://raw.githubusercontent.com/tahmaseb73/Iran_Config_Collector/main/utils/speedtest/lite_config.json
# اجرای LiteSpeedTest
chmod +x utils/speedtest/lite-linux-amd64
utils/speedtest/lite-linux-amd64 --config utils/speedtest/lite_config.json --test https://raw.githubusercontent.com/tahmaseb73/Iran_Config_Collector/main/bulk/merge3.txt --output utils/speedtest/out.json > utils/speedtest/speedtest_output.log 2>&1
