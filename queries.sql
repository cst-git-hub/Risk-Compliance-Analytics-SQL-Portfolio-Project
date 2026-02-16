WITH financial_risk AS (
    SELECT
        f.entity_id,
        AVG(
            CASE 
                WHEN f.tax_paid = 0 AND f.revenue > 0 THEN 1
                ELSE 0
            END
        ) AS zero_tax_ratio
    FROM financials f
    GROUP BY f.entity_id
),
compliance_risk AS (
    SELECT
        c.entity_id,
        COUNT(*) AS total_events,
        AVG(c.severity) AS avg_severity
    FROM compliance_events c
    GROUP BY c.entity_id
),
audit_risk AS (
    SELECT
        a.entity_id,
        SUM(
            CASE 
                WHEN a.audit_result = 'Negative' THEN 1
                ELSE 0
            END
        ) AS negative_audits
    FROM audit_history a
    GROUP BY a.entity_id
),
risk_score AS (
    SELECT
        e.entity_id,
        e.entity_name,
        COALESCE(fr.zero_tax_ratio, 0) * 0.5 +
        COALESCE(cr.avg_severity, 0) * 0.3 +
        COALESCE(ar.negative_audits, 0) * 0.2 AS total_risk_score
    FROM entities e
    LEFT JOIN financial_risk fr ON e.entity_id = fr.entity_id
    LEFT JOIN compliance_risk cr ON e.entity_id = cr.entity_id
    LEFT JOIN audit_risk ar ON e.entity_id = ar.entity_id
    where e.country = 'US'
)
SELECT
    entity_id,
    entity_name,
    total_risk_score,
    RANK() OVER (ORDER BY total_risk_score DESC) AS risk_rank
FROM risk_score
ORDER BY risk_rank;
