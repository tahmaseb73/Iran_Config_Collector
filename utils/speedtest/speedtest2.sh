#!/bin/bash
set -e  # خروج در صورت بروز خطا
set -x  # چاپ دستورات برای دیباگ

# ایجاد دایرکتوری‌های لازم
mkdir -p utils/speedtest logs

# آماده‌سازی فایل‌های موردنیاز
echo "Downloading lite-linux-amd64.gz..."
wget --timeout=30 -O utils/speedtest/lite-linux-amd64.gz https://github.com/xxf098/LiteSpeedTest/releases/download/v0.14.1/lite-linux-amd64-v0.14.1.gz || { echo "Failed to download lite-linux-amd64.gz"; exit 1; }
echo "Extracting lite-linux-amd64.gz..."
gzip -d utils/speedtest/lite-linux-amd64.gz || { echo "Failed to extract lite-linux-amd64.gz"; exit 1; }
echo "Downloading lite_config.json..."
wget --timeout=30 -O utils/speedtest/lite_config.json https://raw.githubusercontent.com/tahmaseb73/Iran_Config_Collector/main/utils/speedtest/lite_config.json || { echo "Failed to download lite_config.json"; exit 1; }

# بررسی وجود فایل‌ها
ls -l utils/speedtest/lite-linux-amd64 utils/speedtest/lite_config.json || { echo "Required files not found"; exit 1; }

# اجرای LiteSpeedTest با محدودیت زمانی
chmod +x utils/speedtest/lite-linux-amd64
echo "Running LiteSpeedTest with 10-minute timeout..."
timeout -v 600 utils/speedtest/lite-linux-amd64 --config utils/speedtest/lite_config.json --test https://raw.githubusercontent.com/tahmaseb73/Iran_Config_Collector/main/bulk/merge3.txt > utils/speedtest/speedtest_output.log 2>&1 || { echo "LiteSpeedTest failed or timed out"; exit 1; }

# انتقال out.json (در صورت تولید در ریشه)
[ -f out.json ] && mv out.json utils/speedtest/out.json || echo "out.json not generated"
