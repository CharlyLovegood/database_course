WITH RECURSIVE cte AS
(
    SELECT MIN(CAST(dttm AS DATE)) AS dt FROM visits
        UNION ALL
	SELECT dt + INTERVAL 1 DAY
        FROM cte
    WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(dttm AS DATE)) FROM visits)
)
SELECT cte.dt, COUNT(DISTINCT visits.client)
    FROM visits RIGHT JOIN cte ON CAST(visits.dttm AS DATE) >= cte.dt 
    AND CAST(visits.dttm AS DATE) < cte.dt + INTERVAL 1 DAY
GROUP BY cte.dt
ORDER BY cte.dt;





EXPLAIN rusult:
+----+-------------+------------+------------+------+---------------+------+---------+------+-------+----------+----------------------------------------------------+
| id | select_type | table      | partitions | type | possible_keys | key  | key_len | ref  | rows  | filtered | Extra                                              |
+----+-------------+------------+------------+------+---------------+------+---------+------+-------+----------+----------------------------------------------------+
|  1 | PRIMARY     | <derived2> | NULL       | ALL  | NULL          | NULL | NULL    | NULL |     3 |   100.00 | Using temporary; Using filesort                    |
|  1 | PRIMARY     | visits     | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 32560 |   100.00 | Using where; Using join buffer (Block Nested Loop) |
|  2 | DERIVED     | visits     | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 32560 |   100.00 | NULL                                               |
|  3 | UNION       | cte        | NULL       | ALL  | NULL          | NULL | NULL    | NULL |     2 |   100.00 | Recursive; Using where                             |
|  5 | SUBQUERY    | visits     | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 32560 |   100.00 | NULL                                               |
+----+-------------+------------+------------+------+---------------+------+---------+------+-------+----------+----------------------------------------------------+
5 rows in set, 1 warning (0,06 sec)




DAU result:
+------------+-------------------------------+
| dt         | COUNT(DISTINCT visits.client) |
+------------+-------------------------------+
| 2018-07-18 |                           161 |
| 2018-07-19 |                           131 |
| 2018-07-20 |                           126 |
| 2018-07-21 |                           144 |
| 2018-07-22 |                           135 |
| 2018-07-23 |                           120 |
| 2018-07-24 |                           124 |
| 2018-07-25 |                           133 |
| 2018-07-26 |                           129 |
| 2018-07-27 |                           138 |
| 2018-07-28 |                           151 |
| 2018-07-29 |                           149 |
| 2018-07-30 |                           131 |
| 2018-07-31 |                             0 |
| 2018-08-01 |                           138 |
| 2018-08-02 |                           127 |
| 2018-08-03 |                           132 |
| 2018-08-04 |                           145 |
| 2018-08-05 |                           139 |
| 2018-08-06 |                           146 |
| 2018-08-07 |                           114 |
| 2018-08-08 |                             0 |
| 2018-08-09 |                             0 |
| 2018-08-10 |                             0 |
| 2018-08-11 |                             0 |
| 2018-08-12 |                             0 |
| 2018-08-13 |                             0 |
| 2018-08-14 |                             0 |
| 2018-08-15 |                             0 |
| 2018-08-16 |                             0 |
| 2018-08-17 |                             0 |
| 2018-08-18 |                           133 |
| 2018-08-19 |                           143 |
| 2018-08-20 |                           135 |
| 2018-08-21 |                           114 |
| 2018-08-22 |                           140 |
| 2018-08-23 |                           128 |
| 2018-08-24 |                           131 |
| 2018-08-25 |                           136 |
| 2018-08-26 |                           123 |
| 2018-08-27 |                           141 |
| 2018-08-28 |                           140 |
| 2018-08-29 |                           134 |
| 2018-08-30 |                           132 |
| 2018-08-31 |                             0 |
| 2018-09-01 |                           149 |
| 2018-09-02 |                           134 |
| 2018-09-03 |                           144 |
| 2018-09-04 |                           123 |
| 2018-09-05 |                           132 |
| 2018-09-06 |                           132 |
| 2018-09-07 |                           143 |
| 2018-09-08 |                             0 |
| 2018-09-09 |                             0 |
| 2018-09-10 |                             0 |
| 2018-09-11 |                             0 |
| 2018-09-12 |                             0 |
| 2018-09-13 |                             0 |
| 2018-09-14 |                             0 |
| 2018-09-15 |                             0 |
| 2018-09-16 |                             0 |
| 2018-09-17 |                             0 |
| 2018-09-18 |                           149 |
| 2018-09-19 |                           146 |
| 2018-09-20 |                           143 |
| 2018-09-21 |                           142 |
| 2018-09-22 |                           142 |
| 2018-09-23 |                           130 |
| 2018-09-24 |                           130 |
| 2018-09-25 |                           133 |
| 2018-09-26 |                           137 |
| 2018-09-27 |                           137 |
| 2018-09-28 |                           139 |
| 2018-09-29 |                           143 |
| 2018-09-30 |                           132 |
| 2018-10-01 |                           134 |
| 2018-10-02 |                           143 |
| 2018-10-03 |                           123 |
| 2018-10-04 |                           143 |
| 2018-10-05 |                           125 |
| 2018-10-06 |                           135 |
| 2018-10-07 |                           140 |
| 2018-10-08 |                             0 |
| 2018-10-09 |                             0 |
| 2018-10-10 |                             0 |
| 2018-10-11 |                             0 |
| 2018-10-12 |                             0 |
| 2018-10-13 |                             0 |
| 2018-10-14 |                             0 |
| 2018-10-15 |                             0 |
| 2018-10-16 |                             0 |
| 2018-10-17 |                             0 |
| 2018-10-18 |                           142 |
| 2018-10-19 |                           111 |
| 2018-10-20 |                           132 |
| 2018-10-21 |                           129 |
| 2018-10-22 |                           116 |
| 2018-10-23 |                           113 |
| 2018-10-24 |                           126 |
| 2018-10-25 |                           122 |
| 2018-10-26 |                           137 |
| 2018-10-27 |                           125 |
| 2018-10-28 |                           134 |
| 2018-10-29 |                           136 |
| 2018-10-30 |                           133 |
| 2018-10-31 |                             0 |
| 2018-11-01 |                           132 |
| 2018-11-02 |                           127 |
| 2018-11-03 |                           122 |
| 2018-11-04 |                           134 |
| 2018-11-05 |                           133 |
| 2018-11-06 |                           131 |
| 2018-11-07 |                           137 |
| 2018-11-08 |                             0 |
| 2018-11-09 |                             0 |
| 2018-11-10 |                             0 |
| 2018-11-11 |                             0 |
| 2018-11-12 |                             0 |
| 2018-11-13 |                             0 |
| 2018-11-14 |                             0 |
| 2018-11-15 |                             0 |
| 2018-11-16 |                             0 |
| 2018-11-17 |                             0 |
| 2018-11-18 |                           130 |
| 2018-11-19 |                           138 |
| 2018-11-20 |                           154 |
| 2018-11-21 |                           134 |
| 2018-11-22 |                           132 |
| 2018-11-23 |                           140 |
| 2018-11-24 |                           144 |
| 2018-11-25 |                           132 |
| 2018-11-26 |                           134 |
| 2018-11-27 |                           138 |
| 2018-11-28 |                           128 |
| 2018-11-29 |                           128 |
| 2018-11-30 |                           114 |
| 2018-12-01 |                           146 |
| 2018-12-02 |                           137 |
| 2018-12-03 |                           139 |
| 2018-12-04 |                           122 |
| 2018-12-05 |                           131 |
| 2018-12-06 |                           161 |
| 2018-12-07 |                           132 |
| 2018-12-08 |                             0 |
| 2018-12-09 |                             0 |
| 2018-12-10 |                             0 |
| 2018-12-11 |                             0 |
| 2018-12-12 |                             0 |
| 2018-12-13 |                             0 |
| 2018-12-14 |                             0 |
| 2018-12-15 |                             0 |
| 2018-12-16 |                             0 |
| 2018-12-17 |                             0 |
| 2018-12-18 |                           113 |
| 2018-12-19 |                           134 |
| 2018-12-20 |                           124 |
| 2018-12-21 |                           149 |
| 2018-12-22 |                           139 |
| 2018-12-23 |                           142 |
| 2018-12-24 |                           124 |
| 2018-12-25 |                           117 |
| 2018-12-26 |                           128 |
| 2018-12-27 |                           135 |
| 2018-12-28 |                           128 |
| 2018-12-29 |                           149 |
| 2018-12-30 |                           121 |
| 2018-12-31 |                             0 |
| 2019-01-01 |                           135 |
| 2019-01-02 |                           140 |
| 2019-01-03 |                           140 |
| 2019-01-04 |                           130 |
| 2019-01-05 |                           133 |
| 2019-01-06 |                           133 |
| 2019-01-07 |                           130 |
| 2019-01-08 |                             0 |
| 2019-01-09 |                             0 |
| 2019-01-10 |                             0 |
| 2019-01-11 |                             0 |
| 2019-01-12 |                             0 |
| 2019-01-13 |                             0 |
| 2019-01-14 |                             0 |
| 2019-01-15 |                             0 |
| 2019-01-16 |                             0 |
| 2019-01-17 |                             0 |
| 2019-01-18 |                           143 |
| 2019-01-19 |                           145 |
| 2019-01-20 |                           130 |
| 2019-01-21 |                           133 |
| 2019-01-22 |                           128 |
| 2019-01-23 |                           127 |
| 2019-01-24 |                           127 |
| 2019-01-25 |                           145 |
| 2019-01-26 |                           121 |
| 2019-01-27 |                           129 |
| 2019-01-28 |                           125 |
| 2019-01-29 |                           144 |
| 2019-01-30 |                           133 |
| 2019-01-31 |                             0 |
| 2019-02-01 |                           129 |
| 2019-02-02 |                           138 |
| 2019-02-03 |                           131 |
| 2019-02-04 |                           147 |
| 2019-02-05 |                           132 |
| 2019-02-06 |                           133 |
| 2019-02-07 |                           160 |
| 2019-02-08 |                             0 |
| 2019-02-09 |                             0 |
| 2019-02-10 |                             0 |
| 2019-02-11 |                             0 |
| 2019-02-12 |                             0 |
| 2019-02-13 |                             0 |
| 2019-02-14 |                             0 |
| 2019-02-15 |                             0 |
| 2019-02-16 |                             0 |
| 2019-02-17 |                             0 |
| 2019-02-18 |                           153 |
| 2019-02-19 |                           123 |
| 2019-02-20 |                           137 |
| 2019-02-21 |                           148 |
| 2019-02-22 |                           136 |
| 2019-02-23 |                           141 |
| 2019-02-24 |                           141 |
| 2019-02-25 |                           130 |
| 2019-02-26 |                           126 |
| 2019-02-27 |                           138 |
| 2019-02-28 |                           355 |
| 2019-03-01 |                           149 |
| 2019-03-02 |                           145 |
| 2019-03-03 |                           139 |
| 2019-03-04 |                           123 |
| 2019-03-05 |                           128 |
| 2019-03-06 |                           135 |
| 2019-03-07 |                           137 |
| 2019-03-08 |                             0 |
| 2019-03-09 |                             0 |
| 2019-03-10 |                             0 |
| 2019-03-11 |                             0 |
| 2019-03-12 |                             0 |
| 2019-03-13 |                             0 |
| 2019-03-14 |                             0 |
| 2019-03-15 |                             0 |
| 2019-03-16 |                             0 |
| 2019-03-17 |                             0 |
| 2019-03-18 |                           133 |
| 2019-03-19 |                           117 |
| 2019-03-20 |                           121 |
| 2019-03-21 |                           126 |
| 2019-03-22 |                           120 |
| 2019-03-23 |                           141 |
| 2019-03-24 |                           152 |
| 2019-03-25 |                           131 |
| 2019-03-26 |                           131 |
| 2019-03-27 |                           141 |
| 2019-03-28 |                           142 |
| 2019-03-29 |                           133 |
| 2019-03-30 |                           126 |
| 2019-03-31 |                             0 |
| 2019-04-01 |                           118 |
| 2019-04-02 |                           140 |
| 2019-04-03 |                           139 |
| 2019-04-04 |                           142 |
| 2019-04-05 |                           123 |
| 2019-04-06 |                           143 |
| 2019-04-07 |                           134 |
| 2019-04-08 |                             0 |
| 2019-04-09 |                             0 |
| 2019-04-10 |                             0 |
| 2019-04-11 |                             0 |
| 2019-04-12 |                             0 |
| 2019-04-13 |                             0 |
| 2019-04-14 |                             0 |
| 2019-04-15 |                             0 |
| 2019-04-16 |                             0 |
| 2019-04-17 |                             0 |
| 2019-04-18 |                           124 |
| 2019-04-19 |                           134 |
| 2019-04-20 |                           152 |
| 2019-04-21 |                           133 |
| 2019-04-22 |                           149 |
| 2019-04-23 |                           135 |
| 2019-04-24 |                           134 |
| 2019-04-25 |                           137 |
| 2019-04-26 |                           134 |
| 2019-04-27 |                           122 |
| 2019-04-28 |                           147 |
| 2019-04-29 |                           145 |
| 2019-04-30 |                           132 |
| 2019-05-01 |                           139 |
| 2019-05-02 |                           111 |
| 2019-05-03 |                           136 |
| 2019-05-04 |                           109 |
| 2019-05-05 |                           138 |
| 2019-05-06 |                           144 |
| 2019-05-07 |                           145 |
+------------+-------------------------------+