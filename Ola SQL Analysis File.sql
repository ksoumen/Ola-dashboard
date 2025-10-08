CREATE TABLE Bookings (
    date TIMESTAMP, 
    time TIME,
    booking_id VARCHAR(20) PRIMARY KEY,
    booking_status VARCHAR(50),
    customer_id VARCHAR(20),
    vehicle_type VARCHAR(30),
    pickup_location VARCHAR(100),
    drop_location VARCHAR(100),
    v_tat INTEGER,
    c_tat INTEGER,
    canceled_rides_by_customer TEXT,
    canceled_rides_by_driver TEXT,
    incomplete_rides VARCHAR(10),
    incomplete_rides_reason TEXT,
    booking_value NUMERIC(10,2),
    payment_method VARCHAR(30),
    ride_distance NUMERIC(10,2),
    driver_ratings NUMERIC(2,1),
    customer_rating NUMERIC(2,1),
    vehicle_images TEXT
);

select * from Bookings;

COPY public.bookings
FROM 'C:\\Users\\ksoum\\Downloads\\Bookings - July.csv'
DELIMITER ',' CSV HEADER
NULL 'null';


1. Retrieve all successful bookings:

	CREATE VIEW Successful_Bookings AS
	SELECT * FROM Bookings
	WHERE booking_status = 'Success';
	
	SELECT * FROM  Successful_Bookings;

2. Find the average ride distance for each vehicle type:

	CREATE VIEW ride_distance_for_each_vehicle AS
	SELECT vehicle_type,AVG(ride_distance) AS AVG_Distance
	FROM Bookings
	GROUP BY vehicle_type;
	
	SELECT * FROM ride_distance_for_each_vehicle;

3. Get the total number of cancelled rides by customers:

 	i)	SELECT COUNT(Canceled_Rides_by_Customer) AS Total_cancelled_rides_by_customers
		FROM Bookings;
	
	
 	ii) CREATE VIEW canceled_rides_by_customers AS
 		SELECT COUNT(*) FROM bookings
		WHERE Booking_Status = 'Canceled by Customer';
		
		SELECT * FROM canceled_rides_by_customers;

4. List the top 5 customers who booked the highest number of rides:
	
	CREATE View Top_5_Customers AS
	SELECT Customer_ID, COUNT(Booking_ID) AS total_rides
	FROM Bookings
	WHERE Booking_Status = 'Success'
	GROUP BY Customer_ID
	ORDER BY total_rides DESC
	LIMIT 5;

	SELECT * FROM  Top_5_Customers;
	
5. Get the number of rides cancelled by drivers due to personal and car-related issues:
	
	CREATE VIEW canceled_by_driver AS
	SELECT COUNT(*)
	FROM Bookings
	WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';
	
	SELECT * FROM canceled_by_driver;

6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

	CREATE VIEW Min_Max_Driver_Rating AS
	SELECT MIN(Driver_Ratings) AS Min_Rating,
	MAX(Driver_Ratings) AS Max_Rating 
	FROM Bookings
	WHERE Vehicle_Type = 'Prime Sedan';
 
 	SELECT * FROM Min_Max_Driver_Rating;
	
 
7. Retrieve all rides where payment was made using UPI:
	
	CREATE VIEW Upi_Payment AS
	SELECT * FROM Bookings
	WHERE Payment_Method = 'UPI';
	
	SELECT * FROM Upi_Payment;

	
8. Find the average customer rating per vehicle type:
	
	CREATE VIEW Customer_Rating_By_Vehicle_Type AS
	SELECT Vehicle_Type,AVG(Customer_Rating) AS Avg_Customer_Rating
	FROM Bookings
	GROUP By Vehicle_Type;
	
	SELECT * FROM Customer_Rating_By_Vehicle_Type;
	

9. Calculate the total booking value of rides completed successfully:

	CREATE VIEW Total_Successful_Ride_Value As
	SELECT SUM(Booking_value) 
	AS Total_Successful_Value
	FROM Bookings
	WHERE Booking_Status = 'Success';

	SELECT * FROM Total_Successful_Ride_Value;
	

10. List all incomplete rides along with the reason
	
	CREATE VIEW Incomplete_Rides AS
	SELECT Booking_ID,Incomplete_Rides_Reason 
	FROM Bookings
	WHERE Incomplete_Rides = 'Yes';

	SELECT * FROM Incomplete_Rides;

