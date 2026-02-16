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
