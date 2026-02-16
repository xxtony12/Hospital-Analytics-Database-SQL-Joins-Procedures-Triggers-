This project demonstrates relational database design, query development, stored procedures, and trigger implementation using SQL.

# Overview

Built a relational hospital database integrating patient records, visit data, and billing information. Implemented analytical queries and procedural logic to simulate real-world healthcare reporting and data validation workflows.


## Tools Used
• MySQL
• Relational Database Design
• Stored Procedures
• Triggers
• Aggregation & Multi-table Joins

## Database Schema
<img width="775" height="251" alt="ERD" src="https://github.com/user-attachments/assets/01633660-180b-4662-a771-7371997723ef" />

## Business Objectives

This project simulates a hospital analytics database used to support operational and financial decision-making.

The database answers real-world business questions such as:

• Which visits were classified as Emergency admissions?
• Which patients accumulated high billing balances?
• What is the total billing exposure by visit?
• Which insurance providers are associated with specific billing amounts?
• Which patients were admitted within specific date ranges for reporting?
• How can data validation rules prevent incorrect patient records?

## Key Features
• Multi-table JOIN queries
• Aggregated billing analysis
• Date-range reporting stored procedure
• High-debt identification procedure
• Data validation trigger (age enforcement)
• Insurance normalization trigger

# Below is an example output from the High Debt stored procedure:


<img width="1080" height="725" alt="LeftJoinWhereOutput" src="https://github.com/user-attachments/assets/4a2ba691-58af-40f3-9ea2-09c8c313974b" />



