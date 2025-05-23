# 🎀 服务器健康守护脚本 (⁄ ⁄•⁄ω⁄•⁄ ⁄)

> ✨ 一个会卖萌的服务器监控小助手，24小时守护你的系统健康~

---

## 🛠️ 功能特点
- **多维度监控**：CPU 💻 | 内存 🧠 | 磁盘 💾 | 进程 📊 | 负载 ⚖️
- **智能告警**：超过阈值自动发送邮件 📧
- **历史记录**：自动保存监控日志 📝
- **可爱预警**：使用颜文字区分告警级别 (◕‿◕✿)

---

## 🧸 使用指南

### 1. 安装依赖
```bash
# Debian/Ubuntu 小可爱
sudo apt install bc mailutils lm-sensors -y

# RHEL/CentOS 小战士
sudo yum install bc mailx lm_sensors -y
```
### 2. 邮箱配置 (~/.mail.rc)
你的邮箱需启动POP3/IMAP/SMTP/Exchange/CardDAV 服务并且在你的邮箱中获取授权码
vim /etc/mail.rc
```bash
set from=your_gmail@gmail.com
# gmail type
set smtp=smtp.gmail.com
set smtp-auth-user=your_gmail@gmail.com
set smtp-auth-password=你的授权码 
set smtp-auth=login
set smtp-use-starttls
set ssl-verify=ignore
```
### 3. 部署脚本
```bash
chomod +x Autoticputor.sh
mv Autoticputor.sh ~/.local/bin/
```
### 4. 定时任务设置
```bash
crontab -e 
```
添加以下内容：
```bash
# 我这里方便演示设置11分15点执行，更具实际情况设置
11 15 * * * /bin/bash ~/.local/bin/Autoticputor.sh
```


---
## 🌈 监控指标说明
| 指标  | 正常范围     | 颜文字表情    |
| --- | -------- | -------- |
| CPU | <80%     | (ω)  |
| 内存  | <80%     | (◠‿◠✿)   |
| 磁盘  | <90%     | (╯✧▽✧)╯  |
| 进程数 | <500     | ٩(◕‿◕)۶ |
| 负载  | <核心数*1.5 | (•̀ᴗ•́)  |

---
## 🚨 告警示例
```bash
主题：⚠️ 服务器告警: CPU 内存 异常!  
内容：
🕒 检测时间: 2025-05-10 15:11:00  
💻 CPU使用率: 85%  
🧠 内存使用率: 82%  
💾 根分区使用率: 45%  
📊 总进程数: 210  
⚖️ 系统负载(1min): 1.2  

❌ 异常项: CPU 内存  
请及时处理喵~ (´･ω･`)
```

---
## 💖 高级技巧
### 1. 添加可爱语音报警 (需要espeak)
```bash
sudo apt install espeak
echo "Warning! CPU overload detected!" | espeak -v en+f4
```
## 🎀 项目结构
```bash
.
├── Autoticputor.sh    # 主脚本
├──  /etc/mail.rc               # 邮箱配置
└── /var/log/server_stats.log # 历史数据
```
> ✨ 提示：按Ctrl+Alt+🐱可以召唤隐藏菜单... (ฅ´ω`ฅ)

---

## 📜 更新日志
- **v1.1**  
    🎀 新增负载监控功能  
    🐾 优化颜文字报警表情
    
- **v1.0**  
    🍰 初始版本发布

[![GitHub Stars](https://img.shields.io/github/stars/yourname/server-guardia?style=social)](https://github.com/Rancade/install_MySQL)
