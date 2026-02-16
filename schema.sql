CREATE DATABASE RiskAnalyticsPortfolio;
GO

USE RiskAnalyticsPortfolio;
GO

CREATE TABLE entities (
    entity_id INT PRIMARY KEY,
    entity_name VARCHAR(100),
    industry VARCHAR(50),
    country VARCHAR(50),
    registration_date DATE
);

CREATE TABLE financials (
    entity_id INT,
    year INT,
    revenue DECIMAL(18,2),
    profit DECIMAL(18,2),
    tax_paid DECIMAL(18,2)
);

CREATE TABLE compliance_events (
    entity_id INT,
    event_date DATE,
    event_type VARCHAR(50),
    severity INT
);

CREATE TABLE audit_history (
    entity_id INT,
    audit_year INT,
    audit_result VARCHAR(20),
    adjustment_amount DECIMAL(18,2)
);

INSERT INTO entities VALUES
(1, 'Alpha Logistics', 'Transport', 'US', '2015-03-12'),
(2, 'Beta Consulting', 'Professional Services', 'US', '2018-07-01'),
(3, 'Gamma Trading', 'Wholesale', 'UK', '2012-11-20'),
(4, 'Delta Manufacturing', 'Manufacturing', 'DE', '2010-01-15');

INSERT INTO financials VALUES
(1, 2022, 1200000, 150000, 0),
(1, 2023, 1300000, 170000, 0),
(2, 2022, 800000, 90000, 18000),
(2, 2023, 850000, 95000, 19000),
(3, 2022, 2000000, 250000, 50000),
(4, 2023, 3000000, 400000, 80000);

INSERT INTO compliance_events VALUES
(1, '2023-05-10', 'Late Filing', 3),
(1, '2023-10-22', 'Missing Report', 4),
(3, '2022-06-18', 'Incorrect Declaration', 5),
(4, '2023-03-02', 'Minor Breach', 2);

INSERT INTO audit_history VALUES
(1, 2022, 'Negative', 50000),
(1, 2023, 'Negative', 30000),
(2, 2023, 'Positive', 0),
(3, 2022, 'Negative', 70000);

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
