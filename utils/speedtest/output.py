import json
import base64
import os
import time

out_json = './utils/speedtest/out.json'
sub_all_base64 = "./sub/sub_merge_base64.txt"
sub_all = "./sub/sub_merge.txt"
Base64_file_base64 = "./Base64.txt"
V2_file = "./V2.txt"
Allconfig_Base = "./Allconfig"
splitted_output = "./sub/splitted/"

def read_json(file):
    if not os.path.isfile(file):
        with open('logs/output_py.log', 'w') as f:
            f.write("Error: out.json not found")
        exit(1)
    with open(file, 'r', encoding='utf-8') as f:
        proxies_all = json.load(f)["nodes"]
        f.close()
    return proxies_all

def output(list, num):
    def arred(x, n): return x * (10 ** n) // 1 / (10 ** n)
    output_list = []

    for item in list:
        info = "id: %s | remarks: %s | protocol: %s | ping: %s MS | avg_speed: %s MB | max_speed: %s MB | Link: %s\n" % (
            str(item["id"]), item["remarks"], item["protocol"], str(item["ping"]), str(arred(item["avg_speed"] * 0.00000095367432, 3)),
            str(arred(item["max_speed"] * 0.00000095367432, 3)), item["link"])
        output_list.append(info)

    with open('./LogInfo.txt', 'w') as f1:
        f1.writelines(output_list)
        f1.close()

    output_list = [item["link"] for item in list]

    content = '\n'.join(output_list)
    content_base64 = base64.b64encode(content.encode('utf-8')).decode('ascii')
    content_base64_part = base64.b64encode('\n'.join(output_list[0:num]).encode('utf-8')).decode('ascii')

    os.makedirs(splitted_output, exist_ok=True)
    vmess_outputs = []
    vless_outputs = []
    trojan_outputs = []
    ssr_outputs = []
    ss_outputs = []

    for output in output_list:
        if str(output).startswith("vmess://"):
            vmess_outputs.append(output)
        elif str(output).startswith("vless://"):
            vless_outputs.append(output)
        elif str(output).startswith("trojan://"):
            trojan_outputs.append(output)
        elif str(output).startswith("ssr://"):
            ssr_outputs.append(output)
        elif str(output).startswith("ss://"):
            ss_outputs.append(output)

    with open(os.path.join(splitted_output, "vmess.txt"), 'w') as f:
        vmess_content = "\n".join(vmess_outputs)
        f.write(vmess_content)
        f.close()

    with open(os.path.join(splitted_output, "vless.txt"), 'w') as f:
        vless_content = "\n".join(vless_outputs)
        f.write(vless_content)
        f.close()

    with open(os.path.join(splitted_output, "trojan.txt"), 'w') as f:
        trojan_content = "\n".join(trojan_outputs)
        f.write(trojan_content)
        f.close()

    with open(os.path.join(splitted_output, "ssr.txt"), 'w') as f:
        ssr_content = "\n".join(ssr_outputs)
        f.write(ssr_content)
        f.close()

    with open(os.path.join(splitted_output, "ss.txt"), 'w') as f:
        ss_content = "\n".join(ss_outputs)
        f.write(ss_content)
        f.close()

    with open(sub_all_base64, 'w+', encoding='utf-8') as f:
        f.write(content_base64)
        f.close()

    with open(Base64_file_base64, 'w+', encoding='utf-8') as f:
        f.write(content_base64_part)
        f.close()

    with open(sub_all, 'w') as f:
        f.write(content)
        f.close()

    with open(Allconfig_Base, 'w') as f:
        f.write(content)
        f.close()

    with open(V2_file, 'w') as f:
        f.write('\n'.join(output_list[0:num]))
        f.close()

    return content

if __name__ == '__main__':
    num = 200
    value = read_json(out_json)
    output(value, value.__len__() if value.__len__() <= num else num)
