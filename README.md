# Risk-Compliance-Analytics-SQL-Portfolio-Project
## Business problem
How can organizations prioritize entities for compliance review using data-driven risk indicators?

## Data model
The analysis is based on four logical tables:
- entities
- financials
- compliance_events
- audit_history

## Risk scoring logic
The total risk score is calculated as a weighted combination of:
- financial anomalies (zero tax payments)
- compliance event severity
- historical audit outcomes

Missing data is handled explicitly to avoid invalid risk scores.

## SQL techniques used
- Common Table Expressions (CTEs)
- LEFT JOINs for data completeness
- COALESCE for NULL handling
- Window functions (RANK) for prioritization

## Output
The final query produces a ranked list of entities based on their calculated risk score,
supporting risk-based audit and compliance decision-making.

## Supporting material
- [SQL queries]
- [Query execution screenshots]
