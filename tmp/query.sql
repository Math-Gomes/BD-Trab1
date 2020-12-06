SELECT DISTINCT
    -- s1.`time` as `time1`, 
    -- s2.`time` as `time2`,
    s1.`#t` as `s`, -- `#t1`,
    s2.`#t` as `t` -- `#t2`
    -- s1.`op` as `op1`,
    -- s2.`op` as `op2`,
    -- s1.`attr` as `attr1`,
    -- s2.`attr` as `attr2`
FROM 
    `Schedule` s1
    JOIN `Schedule` s2
    ON s1.`attr` = s2.`attr`
WHERE
    (s1.`time` < s2.`time`) AND
    (s1.`op` != 'C' AND s2.`op` != 'C') AND -- Remove linhas com commits
    (s1.`#t` != s2.`#t`) AND -- Remove linhas referentes a mesma transacao
    (
        (s1.`op` = 'R' AND s2.`op` = 'W') OR
        (s1.`op` = 'W' AND s2.`op` = 'R') OR
        (s1.`op` = 'W' AND s2.`op` = 'W')
    ) -- Mantém linhas com operações conflitantes

;