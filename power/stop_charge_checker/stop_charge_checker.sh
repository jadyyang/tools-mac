#!/bin/bash

# 配置参数
THRESHOLD=78                # 电量阈值
COOLDOWN_SECONDS=7200      # 冷却时间（2小时=7200秒）
COOLDOWN_FILE="/tmp/me_jadyyang_stop_charge_checker_battery_charge_cooldown"  # 冷却状态记录文件

# 获取当前电池信息
BATTERY_INFO=$(pmset -g batt)
CURRENT_PERCENTAGE=$(echo "$BATTERY_INFO" | grep -oE '\d+%' | cut -d% -f1)
POWER_SOURCE=$(echo "$BATTERY_INFO" | grep -oE 'AC Power|Battery Power')

# 仅在充电且电量超过阈值时检查
if [[ "$POWER_SOURCE" == "AC Power" && "$CURRENT_PERCENTAGE" -ge $THRESHOLD ]]; then
  # 检查冷却时间
  CURRENT_TIME=$(date +%s)
  LAST_TRIGGER_TIME=$(cat "$COOLDOWN_FILE" 2>/dev/null || echo 0)  # 文件不存在则默认0

  if [[ $((CURRENT_TIME - LAST_TRIGGER_TIME)) -ge $COOLDOWN_SECONDS ]]; then
    shortcuts run "Mac停止充电提醒"
    echo "$CURRENT_TIME" > "$COOLDOWN_FILE"   # 更新触发时间
  fi
fi