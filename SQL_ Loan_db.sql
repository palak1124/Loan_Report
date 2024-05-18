/* Total No. of Applications*/
select count(id) as Total_Applications from loan_table;
/* Total No. of MTD Applications*/
SELECT COUNT(id) AS MTD_Total_Applications FROM loan_table
WHERE Extract(MONTH from issue_date) = 12;
/* Total No. of Previous Applications*/
SELECT COUNT(id) AS PMTD_Total_Applications FROM loan_table
WHERE Extract(MONTH from issue_date) = 11;

/* Change in Application ref previous month vis this month*/
WITH current_month_count AS (
    SELECT COUNT(id) AS MTD_Total_Applications 
    FROM loan_table
    WHERE EXTRACT(MONTH FROM issue_date) = 12
),
previous_month_count AS (
    SELECT COUNT(id) AS PMTD_Total_Applications 
    FROM loan_table
    WHERE EXTRACT(MONTH FROM issue_date) = 11
)
SELECT 
    
    (SELECT MTD_Total_Applications FROM current_month_count) - (SELECT PMTD_Total_Applications FROM previous_month_count) AS Change_In_Applications;


/* Total Funded Amount*/
select sum(loan_Amount) as Total_Amount from loan_table;
/*Total Funded Amount MTD */
SELECT sum(loan_Amount) AS MTD_Total_Loan_Amount FROM loan_table
WHERE Extract(MONTH from issue_date) = 12 and Extract(year from issue_date) = 2021;
/*Total Funded Amount Last month */
SELECT sum(loan_Amount) AS PMTD_Total_Loan_Amount FROM loan_table
WHERE Extract(MONTH from issue_date) = 11 and Extract(year from issue_date) = 2021;
/* Total Amount Received*/
select sum(total_payment) as Total_Payment_Received from loan_table;
/* Total Amount Received This Month*/
select sum(total_payment) as MTD_Amount_Received FROM loan_table
WHERE Extract(MONTH from issue_date) = 12 and Extract(year from issue_date) = 2021;
/* Total Amount Received Last Month*/
select sum(total_payment) as Last_month_Amount_Received FROM loan_table
WHERE Extract(MONTH from issue_date) = 11 and Extract(year from issue_date) = 2021;

/* Average Interest Rates*/
SELECT AVG(int_rate) * 100 AS avg_int_rate 
FROM loan_table;

/*Average Interest Rate this Month*/

SELECT AVG(int_rate) * 100 AS mtd_avg_int_rate 
FROM loan_table 
WHERE Extract(MONTH from issue_date) = 12 and Extract(year from issue_date) = 2021;

/*Average Interest Rate last Month*/
SELECT AVG(int_rate) * 100 AS avg_int_rate_last_month 
FROM loan_table 
WHERE Extract(MONTH from issue_date) = 11 and Extract(year from issue_date) = 2021;


/* Average DTI*/
Select AVG(dti)*100 as avg_dti from loan_table;
/* Average_DTI this Month*/
 Select AVG(dti)*100 as avg_dti_this_month from loan_table 
 WHERE Extract(MONTH from issue_date) = 12 and Extract(year from issue_date) = 2021;
 /* Average_DTI Last Month*/
 Select AVG(dti)*100 as avg_dti_last_month from loan_table 
 WHERE Extract(MONTH from issue_date) = 11 and Extract(year from issue_date) = 2021;
 
 /*Good Loan Percentage*/
 select 
(count(
	Case when loan_Status ='Fully Paid' 
	         or loan_status ='Current' then id end)*100)/count(id)
			   as Good_Loan_Percentage 
			    from loan_table;
/*Good Loan Applications*/
 select  
 count(id) as good_loan_applications
  from loan_table
  where loan_Status ='Fully Paid' 
	         or loan_status ='Current' ;

/*Good Loan Funded*/
 select  
sum(loan_amount) as Good_Loan_Funded
  from loan_table
  where loan_Status ='Fully Paid' 
	         or loan_status ='Current' ;
		
/*Good Loan Received*/
 select  
sum(total_payment) as Good_Loan_Received
  from loan_table
  where loan_Status ='Fully Paid' 
	         or loan_status ='Current' ;
			 
/*Bad Loan Percentage*/
 select 
(count(
	Case when loan_Status ='Charged Off' 
	          then id end)*100)/count(id)
			   as Bad_Loan_Percentage 
			    from loan_table;
				
/* Bad Loan Funded*/
 select  
sum(loan_amount) as Bad_Loan_Funded
  from loan_table
  where loan_Status ='Charged Off' ;
		
/*Bad Loan Received*/
 select  
sum(total_payment) as bad_Loan_Received
  from loan_table
  where loan_Status ='Charged Off' ;
  
  /* Loan Status Grid View*/
  
   select loan_status, count(id), 
   sum(loan_amount) as Funded_Amount,
   sum(total_payment) as Amount_Received,
   avg(int_rate)*100 as interest_rate,
   avg(dti)*100  as dti
   from loan_table
   group by loan_status;
   
	/*This Month*/		 
    select loan_status ,
	count(id) as  Total_Applications_MTD, 
   sum(loan_amount) as Funded_Amount,
   sum(total_payment) as Amount_Received
   from loan_table
   where extract (month from issue_date) = 12
   group by loan_Status;
   
   /*	Month Wise Details */
  SELECT 
    EXTRACT(MONTH FROM issue_date) AS Month_Number,
    TO_CHAR(issue_date, 'Month') AS Month_Name,
    COUNT(id) AS Total_loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM 
    loan_table
GROUP BY 
    Month_Number,
    Month_Name
ORDER BY 
    Month_Number;
	
/* State Wise Data */
Select address_state,
Count(id) as Total_loans_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
	from loan_table
	group by address_state
	order by address_state;
	
/* Term Wise Data*/
Select term,
Count(id) as Total_loans_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
	from loan_table
	group by term;
	/* Employee Wise Data*/
	Select emp_length,
Count(id) as Total_loans_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
	from loan_table
	group by emp_length
	order by emp_length;
	/*Purpose*/
	Select purpose,
Count(id) as Total_loans_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
	from loan_table
	group by purpose
	order by purpose;
	/* House Ownership*/
	Select home_ownership,
Count(id) as Total_loans_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
	from loan_table
	group by home_ownership
	order by home_ownership;
	
	
	

   


 
