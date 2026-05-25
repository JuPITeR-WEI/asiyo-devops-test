# 題目一

## 題目說明

試想臨時有一活動網頁專案將於近日推出，預期推廣期間訪客流量可能達平日百倍以上，請簡易描述如何確保服務正常運作，以及考量細節。

---

## 目標

本次設計重點：

- 高可用（High Availability）
- 可擴展（Scalability）
- 可觀測（Observability）
- 快速恢復（Recoverability）

整體架構：

```
User
↓
CDN
↓
WAF
↓
Load Balancer
↓
Application Cluster
↓
Cache
↓
Database
```

---

## 一、容量評估與壓力測試

上線前先進行容量規劃與壓力測試。

確認項目：

- 預估 PV / UV
- 峰值 QPS
- API TPS
- 同時在線人數

工具：

- k6
- Locust
- JMeter

觀察指標：

- CPU
- Memory
- Response Time
- Error Rate
- DB Connection

目標：

- P95 < 500ms
- Error Rate < 1%

---

## 二、自動擴容（Auto Scaling）

避免人工擴容。

應用層：

- Kubernetes HPA
- AWS Auto Scaling Group

依據：

- CPU
- Memory
- QPS
- Queue Length

範例：

minReplicas = 3  
maxReplicas = 30  
CPU = 70%

---

## 三、CDN 與快取策略

降低源站壓力。

快取：

- HTML（短快取）
- JS / CSS（長快取）
- 圖片（長快取）

工具：

- CloudFront
- Cloudflare

應用快取：

- Redis
- Memory Cache

---

## 四、資料庫保護

避免資料庫成為瓶頸。

措施：

- Read Replica
- Connection Pool
- Redis Cache
- Slow Query

必要時：

- 讀寫分離

---

## 五、監控與告警

監控項目：

- CPU
- Memory
- Latency
- Error Rate
- DB

工具：

- Prometheus
- Grafana
- Alertmanager

通知：

- Slack
- Email

---

## 六、安全與穩定性

防止異常流量：

- WAF
- Rate Limit
- Bot Protection
- 黑白名單

---

## 七、降級策略

高流量時：

- 關閉推薦系統
- 關閉分析模組
- 保留核心交易

---

## 結論

透過：

壓測 → Auto Scaling → CDN → Cache → DB 優化 → 監控 → 降級

確保活動期間仍維持穩定服務。