# **Pizza Hut Sales Analysis** 🍕📊  

A SQL-based project designed to analyze sales data from a pizza restaurant. This project provides valuable insights into key business metrics, such as revenue, order patterns, popular pizzas, and customer behavior.  

---

### **Live Demo** 🔗  
[View the PDF Report]([https://drive.google.com/file/d/your-pdf-link-here/view](https://drive.google.com/file/d/1yx6DXs6QLrtYnKIiPJKYk3iX4T9O_13m/view))  

---

## **Table of Contents**  

- [Project Overview](#project-overview)  
- [Features](#features)  
- [Key Insights](#key-insights)  
- [SQL Queries and Analysis](#sql-queries-and-analysis)  
- [Technologies Used](#technologies-used)  
- [Setup Guide](#setup-guide)  
- [Future Enhancements](#future-enhancements)  

---

## **Project Overview**  

The **Pizza Hut Sales Analysis** leverages SQL to extract and analyze sales data, providing actionable insights into restaurant performance. This project helps stakeholders understand trends, revenue breakdowns, and customer preferences to drive data-driven decisions.  

---  

## **Features**  

- **Total Sales Insights**: Analyze total orders, revenue, and cumulative performance over time.  
- **Pizza Popularity**: Identify top-selling pizzas and most common pizza sizes.  
- **Customer Behavior**: Explore ordering trends by time of day and average daily orders.  
- **Category Contributions**: Assess revenue distribution across pizza categories.  
- **Revenue Breakdown**: Determine top revenue-generating pizzas and categories.  

---

## **Key Insights**  

### **Basic Analysis**  
1. **Total Orders Placed**: Retrieve the total number of orders made.  
2. **Total Revenue Generated**: Calculate revenue from all pizza sales.  
3. **Highest-Priced Pizza**: Identify the most expensive pizza offered.  
4. **Most Common Pizza Size Ordered**: Determine customer preferences for pizza sizes.  
5. **Top 5 Most Ordered Pizza Types**: Highlight the most popular pizzas by quantity.  

### **Intermediate Analysis**  
6. **Quantity by Pizza Category**: Analyze how many pizzas were ordered in each category.  
7. **Order Distribution by Hour**: Examine peak order hours for operational planning.  
8. **Category-Wise Pizza Distribution**: Assess the number of pizzas per category.  
9. **Daily Average Orders**: Calculate the average number of pizzas ordered per day.  
10. **Top 3 Pizza Types by Revenue**: Discover the top revenue-generating pizzas.  

### **Advanced Analysis**  
11. **Revenue Contribution by Pizza Type**: Calculate each pizza type's percentage contribution to total revenue.  
12. **Cumulative Revenue Analysis**: Analyze revenue growth over time.  
13. **Top 3 Pizzas by Revenue (Per Category)**: Identify the top-performing pizzas in each category.  

---

## **SQL Queries and Analysis**  

### **Basic Analysis Queries**  
- **Retrieve Total Orders**:  
   ```sql  
   SELECT COUNT(orders.order_id) AS Total_Orders FROM orders;  
   ```  
- **Calculate Total Revenue**:  
   ```sql  
   SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) AS Total_Revenue  
   FROM order_details  
   JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id;  
   ```  
- **Highest Priced Pizza**:  
   ```sql  
   SELECT pizza_types.name, pizzas.price  
   FROM pizza_types  
   JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id  
   ORDER BY pizzas.price DESC LIMIT 1;  
   ```  

### **Intermediate Analysis Queries**  
- **Quantity by Pizza Category**:  
   ```sql  
   SELECT pizza_types.category, SUM(order_details.quantity) AS Quantity_Ordered  
   FROM pizza_types  
   JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id  
   JOIN order_details ON order_details.pizza_id = pizzas.pizza_id  
   GROUP BY pizza_types.category  
   ORDER BY Quantity_Ordered DESC;  
   ```  
- **Order Distribution by Hour**:  
   ```sql  
   SELECT HOUR(orders.order_time) AS Hour, COUNT(orders.order_id) AS Order_Count  
   FROM orders GROUP BY HOUR(order_time);  
   ```  

### **Advanced Analysis Queries**  
- **Revenue Contribution by Pizza Type**:  
   ```sql  
   SELECT pizza_types.category, CONCAT(ROUND((SUM(order_details.quantity * pizzas.price) /  
   (SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) AS Total_Revenue  
   FROM order_details JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id)) * 100, 2), ' %')  
   AS Percentage_Contribution_in_Revenue  
   FROM pizza_types  
   JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id  
   JOIN order_details ON order_details.pizza_id = pizzas.pizza_id  
   GROUP BY pizza_types.category;  
   ```  

---

## **Technologies Used**  

- **Database**: MySQL  
- **Data Processing**: SQL queries for aggregation, filtering, and analysis  
- **Visualization**: (Optional) Power BI or Tableau for presenting insights  

---

## **Setup Guide**  

1. **Clone the Repository**:  
   ```bash  
   git clone https://github.com/yourusername/pizza-hut-sales-analysis.git  
   ```  

2. **Load Data**:  
   - Import provided data files into your MySQL database.  

3. **Run SQL Scripts**:  
   - Execute the provided SQL queries to analyze the data and extract insights.  

4. **Optional Visualization**:  
   - Export query results and use Power BI/Tableau for dashboards.  

---

## **Future Enhancements**  

1. **Predictive Analysis**: Use machine learning for demand forecasting.  
2. **Enhanced Visualizations**: Create detailed dashboards for stakeholders.  
3. **Automated Reporting**: Schedule periodic report generation.  
4. **Real-time Analytics**: Implement live data pipelines for up-to-date insights.  
