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