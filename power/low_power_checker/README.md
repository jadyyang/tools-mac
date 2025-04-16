低电量提醒
---


## 安装方法

**clone项目**

```bash
mkdir -p ~/code/jadyyang/tools/ && cd ~/code/jadyyang/tools/ && git clone git@github.com:jadyyang/tools-mac.git mac
```

**配置脚本**

先把脚本设置成可执行的（如果有必要，可以把代码提交）

```bash
chmod +x ~/code/jadyyang/tools/mac/power/low_power_checker/low_power_checker.sh
```

在把脚本的绝对路径，更新 `./me.jadyyang.low_power_checker.plist` 中。

**配置任务**

把项目下的 `me.jadyyang.low_power_checker.plist` 添加到 `~/Library/LaunchAgents/` 中。

```bash
ln -s ~/code/jadyyang/tools/mac/power/low_power_checker/me.jadyyang.low_power_checker.plist ~/Library/LaunchAgents/me.jadyyang.low_power_checker.plist
```

然后启动任务
```bash
launchctl load ~/Library/LaunchAgents/me.jadyyang.low_power_checker.plist
```