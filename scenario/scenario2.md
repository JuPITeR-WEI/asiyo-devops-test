# 題目二

## 題目說明

API 伺服器集群中某一台回應異常逾時，請描述如何排查與考量。

---

## 排查流程

Monitoring
↓
Load Balancer
↓
Node
↓
Container
↓
Application
↓
Database

---

## 一、確認問題範圍

先確認：

- 是否只有單一節點
- 是否近期部署
- 是否與流量有關

查看：

- ALB Target
- Pod 狀態
- Node 狀態

---

## 二、基礎資源

檢查：

```
top
htop
iostat
vmstat
free -m
df -h
```

確認：

- CPU
- Memory
- Disk IO

---

## 三、網路檢查
```
ss -s
netstat -an
iftop
```

確認：

- TCP Retransmit
- Connection 數量
- SYN backlog

---

## 四、Application

查看：

```
journalctl
kubectl logs
```

確認：

- Exception
- Timeout
- Thread Blocking


---

## 五、Runtime

Java：

```
jstack
jmap
```

Python：

```
py-spy
```

確認：

- GC
- Deadlock
- Thread

---

## 六、資料庫

查看：

```
SHOW PROCESSLIST;
```

確認：

- Slow Query
- Connection
- Lock

---

## 七、恢復策略

短期：

- Remove Target
- Drain Node

長期：

- 修正程式
- 增加監控

---

## 結論

由：

監控 → 資源 → 網路 → APP → DB

逐層定位問題。