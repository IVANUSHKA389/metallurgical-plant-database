SET search_path TO metallurgicheskiyzavod;

-- Products, workshops and production dates for orders shipped in February 2025
SELECT p.name_produkt, c.name_ceh, pa.data_vyp
FROM Partiya pa
JOIN Produkt p ON pa.cod_produkt = p.cod_produkt
JOIN Operatsiya o ON pa.cod_op = o.cod_op
JOIN Ceh c ON o.cod_ceh = c.cod_ceh
JOIN Otgruzka ot ON pa.cod_zakaz = ot.cod_zakaz
WHERE ot.data_otgr >= DATE '2025-02-01'
  AND ot.data_otgr < DATE '2025-03-01'
ORDER BY p.name_produkt;

-- Quality classification for batches
SELECT
    pa.nomer_part,
    p.name_produkt,
    kk.prochnost_MPa,
    kk.pass_fail,
    CASE
        WHEN kk.pass_fail = FALSE THEN 'Брак'
        WHEN kk.prochnost_MPa > 400 THEN 'Высокое'
        WHEN kk.prochnost_MPa BETWEEN 350 AND 400 THEN 'Среднее'
        ELSE 'Низкое'
    END AS uroven_kachestva
FROM Partiya pa
JOIN Produkt p ON pa.cod_produkt = p.cod_produkt
JOIN Kontrol_kachestva kk ON kk.cod_part = pa.cod_part
ORDER BY pa.nomer_part;

-- Workshops with more than 800 tons of production in February 2025
SELECT c.name_ceh, SUM(v.massa_t) AS total_massa_t
FROM Vypusk v
JOIN Operatsiya o ON v.cod_op = o.cod_op
JOIN Ceh c ON o.cod_ceh = c.cod_ceh
WHERE v.data_vyp >= DATE '2025-02-01'
  AND v.data_vyp < DATE '2025-03-01'
GROUP BY c.cod_ceh, c.name_ceh
HAVING SUM(v.massa_t) > 800
ORDER BY total_massa_t DESC;

-- All workshops, including workshops with zero production
SELECT c.name_ceh, COALESCE(SUM(v.massa_t), 0) AS total_vypusk_t
FROM Ceh c
LEFT JOIN Operatsiya o ON c.cod_ceh = o.cod_ceh
LEFT JOIN Vypusk v ON o.cod_op = v.cod_op
GROUP BY c.cod_ceh, c.name_ceh
ORDER BY total_vypusk_t DESC;

-- Product with maximum batch mass
SELECT p.name_produkt, pa.massa_t
FROM Partiya pa
JOIN Produkt p ON pa.cod_produkt = p.cod_produkt
WHERE pa.massa_t = (SELECT MAX(massa_t) FROM Partiya)
ORDER BY p.name_produkt;
