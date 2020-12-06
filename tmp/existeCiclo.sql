SELECT COUNT(*) > 0 AS `existeCiclo` -- Retorna 1 caso exista ciclo, 0 caso contrário
FROM
    (
        SELECT DISTINCT
            s1.`#t` as `s`,
            s2.`#t` as `t`
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
    ) P
    JOIN
    (
        SELECT DISTINCT
            s1.`#t` as `s`,
            s2.`#t` as `t`
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
    ) Q
    ON P.s = Q.t AND P.t = Q.s
;