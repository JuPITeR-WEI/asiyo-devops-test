# 題目四

## 題目說明

試想已有一組 ELK / EFK 日誌服務集群，而今日有一新服務上線並且串接日誌紀錄，讓開發者能夠透過 Kibana 進行線上錯誤排查。

請描述如何串接日誌至 ELK / EFK，以及設計考量。

---

## 日誌架構

```
Application
↓
Filebeat / FluentBit
↓
Logstash
↓
Elasticsearch
↓
Kibana
```

---

## 一、定義日誌格式

先統一輸出格式。

範例：

```json
{
  "time": "",
  "service": "",
  "level": "",
  "trace_id": "",
  "message": ""
}
```

目的：

- 統一查詢
- 提升分析效率

---

## 二、收集日誌

依環境選擇：

VM：

- Filebeat

Kubernetes：

- FluentBit

收集：

- Application Log
- Access Log
- Error Log

範例：

```yaml
filebeat.inputs:
- type: log
```

---

## 三、Log 處理

由 Logstash 處理：

- Parse
- Filter
- Enrich
- 格式轉換

範例：

```ruby
grok {
}
```

補充欄位：

- env
- namespace
- hostname

---

## 四、寫入 Elasticsearch

Index 規則：

```text
service-yyyy-mm
```

建立：

- Index Template
- ILM
- Lifecycle Policy

保存策略：

| 類型 | 保存 |
|---|---|
| Error | 90 天 |
| Access | 30 天 |
| Debug | 7 天 |

---

## 五、Kibana 建置

建立：

- Dashboard
- Discover
- Search

提供：

- Trace 查詢
- Error 分析
- 即時監控

---

## 六、安全與治理

避免記錄：

- Password
- Token
- 個資

措施：

- masking
- RBAC
- Index Permission

---

## 七、監控與告警

建立告警：

- Error Rate
- 5xx
- Log Volume
- Service Down

通知：

- Slack
- Email
- Alertmanager

---

## 結論

完整流程：

```
收集
↓
清洗
↓
儲存
↓
查詢
↓
告警
```

同時兼顧：

- 可觀測性
- 成本控制
- 安全治理
- 可維運性