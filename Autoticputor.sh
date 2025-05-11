#!/bin/bash
# 📜 License: MIT
# 🐱 Author: Rancade
# 🌸 用法: 此脚本仅供参考，请根据实际情况修改脚本内容。
# 脚本名称: Autoticputor.sh
# 功能: 自动化检测系统CPU状态。
# 用法: sh Autoticputor.sh
# 配置参数
warning_level="80"  # 警告阈值(%)
email="your_mail@mail.com"  # 接收邮箱

# 获取监控数据
timestamp="$(date "+%Y-%m-%d %H:%M:%S")"
cpu_usage="$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')"
mem_usage="$(free | awk '/Mem/{printf "%.1f", $3/$2*100}')"
disk_usage="$(df -h / | awk 'NR==2{print $5}' | tr -d '%')"
process_count="$(ps -e --no-headers | wc -l)"
load_avg="$(cat /proc/loadavg | awk '{print $1}')"  # 1分钟负载

# 生成报告
report="🕒 检测时间: $timestamp
💻 CPU使用率: ${cpu_usage}%
🧠 内存使用率: ${mem_usage}%
💾 根分区使用率: ${disk_usage}%
📊 总进程数: $process_count
⚖️ 系统负载(1min): $load_avg"

# 报警检查
alarm=false
alarm_reasons=()

check_threshold() {
  if (( $(echo "$1 > $warning_level" | bc -l) )); then
    alarm=true
    alarm_reasons+=("$2")
  fi
}

check_threshold "$cpu_usage" "CPU"
check_threshold "$mem_usage" "内存"
check_threshold "$disk_usage" "磁盘"

# 进程数报警（示例阈值500）
if [ "$process_count" -gt 500 ]; then
  alarm=true
  alarm_reasons+=("进程数")
fi

# 负载报警（根据CPU核心数设置阈值）
cpu_cores=$(nproc)
load_threshold=$(echo "$cpu_cores * 1.5" | bc)
if (( $(echo "$load_avg > $load_threshold" | bc -l) )); then
  alarm=true
  alarm_reasons+=("系统负载")
fi

# 发送报警
if [ "$alarm" = true ]; then
  subject="⚠️ 服务器告警: ${alarm_reasons[*]} 异常!"
  echo -e "$report\n\n❌ 异常项: ${alarm_reasons[*]}" | mailx -s "$subject" "$email"
  exit 1
else
  echo "✅ 系统状态正常"
  exit 0
fi

# history
echo "$timestamp,$cpu_usage,$mem_usage,$disk_usage" >> /var/log/server_stats.log
