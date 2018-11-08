-- Retrieve Internet Sales Amount As Per Customer. In other words, we can say show the Detail of amount spent by customers during purchase from Internet.
select factinternetsales.customerkey,dimcustomer.firstname,dimcustomer.lastname,sum(salesamount) from factinternetsales
inner join dimcustomer using (customerkey)
group by factinternetsales.customerkey,dimcustomer.firstname,dimcustomer.lastname
order by customerkey;

-- View Internet Sales amount detail between year 2005 to 2008
select factinternetsales.customerkey,sum(salesamount),dimdate.calendaryear from factinternetsales
inner join dimdate on factinternetsales.duedatekey = dimdate.datekey
where(dimdate.calendaryear >= 2005 and dimdate.calendaryear <= 2008)
group by dimdate.calendaryear,factinternetsales.customerkey
order by 3,1;

--View Internet Sales by product category and sub-category
select dimproductcategory.englishproductcategoryname as "Categoria",  dimproductsubcategory.englishproductsubcategoryname as "Sub-Categoria", dimproduct.englishproductname as "Producto",sum(salesamount) as "Total"
from factinternetsales
inner join dimproduct using (productkey)
inner join dimproductsubcategory using(productsubcategorykey)
inner join dimproductcategory using(productcategorykey)
group by cube(1),cube(2),dimproduct.englishproductname
order by sum(salesamount),dimproductsubcategory.englishproductsubcategoryname,dimproduct.englishproductname ASC;

--View Internet Sales and Freight Cost by product category, sub-category and product
select  dimproduct.englishproductname as "Producto", count(salesordernumber) as "Cantidad de Ventas", SUM(freight) as "Precio de Envio",dimproduct.productsubcategorykey as "Sub - Categoria"
from factinternetsales
inner join dimproduct using (productkey)
group by dimproduct.productsubcategorykey, dimproduct.englishproductname
order by dimproduct.englishproductname,count(salesordernumber),SUM(freight) ASC;

--Retrieve only those products whose names begin with “A” and Internet sales amount <5000 
select dimproduct.englishproductname as "Producto", SUM(salesamount) as "Total"
from factinternetsales
inner join dimproduct using (productkey)
where dimproduct.englishproductname like '%A'
group by dimproduct.englishproductname
having SUM(salesamount::numeric) < 6000
order by SUM(salesamount) ASC;

-- What is sales amount in all the countries?
select sum(salesamount)as "Total", dimsalesterritory.salesterritorycountry as "Pais"
from factinternetsales
inner join dimsalesterritory using (salesterritorykey)
group by dimsalesterritory.salesterritorycountry
order by dimsalesterritory.salesterritorycountry;

-- Retrieve all the products in descending order of their Internet sales amount of year 2007 
select dimproduct.englishproductname, dimdate.calendaryear, sum(salesamount)
from factinternetsales
inner join dimproduct using (productkey)
inner join dimdate on factinternetsales.duedatekey = dimdate.datekey
where (dimdate.calendaryear =2007)
group by dimproduct.englishproductname,dimdate.calendaryear
order by sum(salesamount)desc;

-- Generate a report with Internet Sales sub total, grand total per year and month.
select dimdate.calendaryear,dimdate.monthnumberofyear, sum(salesamount)
from factinternetsales
inner join dimdate on factinternetsales.duedatekey = dimdate.datekey
group by dimdate.calendaryear, cube(dimdate.monthnumberofyear)
order by dimdate.calendaryear,dimdate.monthnumberofyear;
