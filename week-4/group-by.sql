/* GROUP BY Clause */

	/* Recall that: 
	1. The GROUP BY clause lists items from the select list over which aggregations are performed.
	2. It always follows the WHERE clause (if it exists).
	3. The number of records returned is determined by the number of unique combinations of
		values among items within the GROUP BY.
	4. HAVING filters the results after aggregation. WHERE filters records before aggregation.
	5. You must refer to original field names in the GROUP BY and HAVING clause.
	*/



/* Aggregation without grouping.

Table: person.[address]

1. How many records are in the table?
2. How many records are in the table that were modified after June 1, 2014?
3. How many records have a value of 'Cincinnati' for the field City?

*/

	/* Ex 1 */
	select count(*) as record_count from person.[address]


	/* Ex 2 */
	select count(*) as record_count 
	from person.[address]
	where modifieddate >= '6/1/2014'


	/* Ex 3 */
	select count(*) as record_count 
	from person.[address]
	where city='Cincinnati'





/* Aggregation with grouping by one item.

Table: person.[address]

1. How many records exist for each StateProvinceID? Sort by StateProvinceID in ascending order.
2. What value of StateProvinceID has the most number of records?
3. How many records exist for each City with StateProvinceID of 14? Order by City in alphabetical order.

*/
	
	/* Ex 1 */
	select stateprovinceid, count(*) as record_count 
	from person.[address]
	group by stateprovinceid
	order by stateprovinceid


	/* Ex 2 */
	select stateprovinceid, count(*) as record_count 
	from person.[address]
	group by stateprovinceid
	--order by --complete


	/* Ex 3 */
	select city, count(*) as record_count 
	from person.[address]
	--where --complete
	group by city
	--order by --complete
	
	--(1) What do we do if we want to include the StateProvinceID as part of the select list?
	--(2) Would it make sense to include AddressLine1 in the query?





/* Aggregation with grouping by multiple items.

Table: person.[address]

1. How many records exist for each StateProvinceID and City? Sort by StateProvinceID, then City in ascending order.
2. What value of City has the most number of records?
3. What value of StateProvinceID and City has the most number of records?

*/


	/* Ex 1 */
	select stateprovinceid, 
		city, 
		count(*) as record_count 
	from person.[address]
	group by stateprovinceid, city
	order by stateprovinceid, city


	/* Ex 2 */
	select 
		city, 
		count(*) as record_count 
	from person.[address]
	group by city
	--order by --complete


	/* Ex 3 */
	--complete in class





/* Filtering aggregated records.

Table: person.[address]

1. How many records exist for each StateProvinceID and City? Exlude State/City combination with fewer than 5 records.
	Sort by StateProvinceID, then City in ascending order.
2. How many records exist for each StateProvinceID and City with a City whose name begins with an A? 
	Only include State/City combination with 50-100 records.
	Sort by StateProvinceID, then City in ascending order.
*/


	/* Ex 1 */
	select stateprovinceid,
		city,
		count(*) as record_count
	from person.[address]
	group by stateprovinceid, city
		having count(*) >= 5
	order by stateprovinceid, city


	/* Ex 2 */
	select stateprovinceid,
		city,
		count(*) as record_count
	from person.[address]
	--where --complete
	group by stateprovinceid, city
	--having --complete
	order by stateprovinceid, city





/* Multiple Aggregations

Table: production.transactionhistory 

1. Explore table.
2. Return: the total quantity within each order, the total cost of each order, and the average
	cost of each order.
	The field for each order is ReferenceOrderID. The records each represent a line on an order. 
	Note that total cost is the product of Quantity and ActualCost.
	Exclude records with zero cost.
	Sort results by ReferenceOrderID in ascending order.

*/


	/* Ex 2 */
	select
	referenceorderid
	,sum(quantity) [quantity]
	,sum(quantity*actualcost) [total_cost]
	--,average cost?
	
	from production.transactionhistory
	
	where actualcost >= 0
	
	order by referenceorderid
