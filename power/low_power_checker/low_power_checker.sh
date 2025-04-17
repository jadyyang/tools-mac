#!/bin/bash

LOW_BATTERY_THRESHOLD=26
PREVIOUS_PERCENTAGE_FILE="/tmp/me_jadyyang_low_power_checker_previous_battery_percentage"  # 临时文件记录前一次电量

# 读取前一次电量（文件不存在时默认为空）
PREVIOUS_PERCENTAGE=$(cat "$PREVIOUS_PERCENTAGE_FILE" 2>/dev/null)

# 获取当前电池信息
BATTERY_INFO=$(pmset -g batt)
CURRENT_PERCENTAGE=$(echo "$BATTERY_INFO" | grep -oE '\d+%' | cut -d% -f1)
POWER_SOURCE=$(echo "$BATTERY_INFO" | grep -oE 'AC Power|Battery Power')

# 触发条件：未充电 + 当前电量 < 阈值 + 前一次电量 ≥ 阈值
if [[ "$POWER_SOURCE" == "Battery Power" && \
      "$CURRENT_PERCENTAGE" -lt $LOW_BATTERY_THRESHOLD && \
      -n "$PREVIOUS_PERCENTAGE" && \
      "$PREVIOUS_PERCENTAGE" -ge $LOW_BATTERY_THRESHOLD ]]; then
  shortcuts run "Mac电量低提醒"
fi

# 保存当前电量到文件（供下次比较）
echo "$CURRENT_PERCENTAGE" > "$PREVIOUS_PERCENTAGE_FILE"