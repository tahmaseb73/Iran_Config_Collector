#准备好所需文件
wget -O lite-linux-amd64.gz https://github.com/xxf098/LiteSpeedTest/releases/download/v0.14.1/lite-linux-amd64-v0.14.1.gz
gzip -d lite-linux-amd64.gz
wget -O lite_config.json https://raw.githubusercontent.com/tahmaseb73/Iran_Config_Collector/main/utils/speedtest/lite_config_yaml.json
#运行 LiteSpeedTest
chmod +x ./lite-linux-amd64
sudo nohup ./lite-linux-amd64 --config ./lite_config.json --test https://raw.githubusercontent.com/tahmaseb73/Iran_Config_Collector/main/bulk/b64_merge1.txt > speedtest.log 2>&1 &
