# 題目三

## 題目說明

找出分數排名第二名學生所在班級。

---

資料如下：

![Q3](../image/q3.jpg)

---

## SQL

```sql
SELECT class
FROM class
WHERE name=(
SELECT name
FROM score
ORDER BY score DESC
LIMIT 1 OFFSET 1
);