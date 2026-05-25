# 題目三

## 題目說明

試想有一項目運行於 AWS EC2 機器之上，已確認服務仍正常運行，但由於不明原因導致無法再次透過 SSH 登入確認狀態（已排除網路異常及防火牆問題）。

請描述排查方式、恢復流程，以及可能造成無法登入的原因。

---

## 排查流程

SSM
↓
CloudWatch
↓
Disk
↓
SSH
↓
System

---

## 一、優先使用 AWS Systems Manager（SSM）

若服務仍正常運作：

優先使用：

AWS Systems Manager → Session Manager

目的：

- 避免直接重開機
- 不影響服務
- 取得主機存取權限

確認：

- SSM Agent 是否正常
- IAM Role 是否存在

---

## 二、查看 CloudWatch 指標

檢查：

- CPU
- Memory
- Disk
- Network
- Status Check

確認：

- 是否 OOM
- 是否異常重啟
- 是否資源耗盡

---

## 三、檢查磁碟與檔案系統

登入後確認：

```bash
df -h
df -i
du -sh /*
```

檢查：

- Disk Full
- inode 滿
- Log 爆量

常見現象：

- SSH 無法建立 Session
- 系統無法建立暫存檔

---

## 四、檢查 SSH 狀態

確認：

```bash
systemctl status sshd

journalctl -u sshd

cat ~/.ssh/authorized_keys
```

檢查：

- sshd 是否異常
- key 是否被覆蓋
- 權限是否異常

確認權限：

```bash
chmod 700 ~/.ssh

chmod 600 ~/.ssh/authorized_keys
```

---

## 五、檢查系統限制

查看：

```bash
ulimit -a

cat /proc/sys/fs/file-nr

ps -ef | wc -l
```

確認：

- File Descriptor 是否耗盡
- Process 是否爆量

可能造成：

- ssh 無法建立連線
- fork 失敗

---

## 六、查看核心與系統異常

檢查：

```bash
dmesg

journalctl -k
```

確認：

- OOM Killer
- Kernel Panic
- Disk Error

---

## 七、恢復方案

若無法修復：

建立：

AMI
↓

新 EC2
↓

掛載舊 EBS
↓

恢復服務

避免長時間停機。

---

## 可能造成無法登入原因

| 類型 | 說明 |
|---|---|
| Disk Full | 磁碟滿 |
| inode Full | 無法建立新檔 |
| OOM | sshd 被系統終止 |
| authorized_keys 被修改 | 金鑰失效 |
| File Descriptor 耗盡 | 無法建立新連線 |
| Process 爆量 | 系統拒絕建立程序 |
| SSHD Crash | SSH 服務異常 |
| Kernel Panic | 核心異常 |

---

## 結論

原則：

先保服務 → 取得存取 → 定位原因 → 恢復主機

避免直接重啟造成服務中斷。