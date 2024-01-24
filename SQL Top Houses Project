Select *
From HouseListings

--Find How to Remove both # and ## from address Field

Select Address, Replace(Address, '##', '#') As Address,
Replace(Address,'#','')) as UpdatedAddress
from HouseListings

ALTER TABLE HouseListings
ADD UpdatedAddress Nvarchar(255);

Update HouseListings
Set UpdatedAddress = Replace(Address, '##', '#')

Update HouseListings
Set UpdatedAddress = Replace(Address,'#','')

--Amend all addresses to Uppercase to Match. Some where in Lower Case on the second word

Select UPPER(UpdatedAddress)
from HouseListings

Update HouseListings
Set UpdatedAddress = UPPER(UpdatedAddress)

Select UpdatedAddress, replace(UpdatedAddress, ' -', '-')
From HouseListings

Update HouseListings
Set UpdatedAddress = Replace(UpdatedAddress, ' -', '-')


--Top 10 Average Family Income Areas
Select Top 10 City, Province, avg(Median_Family_Income) as AverageCityIncome,
Rank() Over (Order by avg(Median_Family_Income) desc) As AverageIncomeRanking
from HouseListings
Group by City, Province


--Top Price Per City
Select Province, UpdatedAddress, max(Price) as MaxPrice,
Rank() Over (Partition by Province Order by max(Price) desc) as HighestPrice
from HouseListings
Group by Province, UpdatedAddress


--Average Price Per City while including the sample size of cities to avoid one area being higher ranked with less houses
Select City, Count(City) as CityCount, avg(Price) as AveragePrice,
Rank() Over (Order by avg(Price) desc) as AveragePriceRank
from HouseListings
Group by City


--Select only hyphenated address
Select UpdatedAddress
From HouseListings
Where UpdatedAddress Like '%-%'


--Select only non-hypenated address
Select UpdatedAddress
from HouseListings
Where not UpdatedAddress like '%-%'


--Is Number of Beds and Baths in Home correlated higher prices?
Select UpdatedAddress, City, Price, Number_Beds, Number_Baths
From HouseListings
Where Number_Beds >= 5  and Number_Baths >= 5
Order by Number_Baths desc, Number_Beds Desc, Price desc


--What are the most expensive areas to live in Toronto?
Select City, UpdatedAddress, Price
From HouseListings
Where City = 'Toronto'
Order by Price desc


--Top Price for each Province

With CTE_TopProvinces as 
(Select Province, City, UpdatedAddress, Price,
Rank() Over (Partition by Province Order by Price desc) as PriceRank,
ROW_NUMBER() Over (partition by Province order by price desc) as RowNumber
From HouseListings
)
Select Province, City, UpdatedAddress, Price, ROW_NUMBER() over (Partition by Province order by Price desc) as RowNumber
From CTE_TopProvinces
Where RowNumber = 1

---Avg Price and Avg Population within Cities
Select City, Avg(Population) as AveragePop, (Round(Avg(Price), 0)) as AveragePricePerCity, Count(City) As CountCity
from HouseListings
Group by City
Order by AveragePricePerCity Desc, CountCity Desc


ALTER TABLE HouseProject.dbo.Houselistings
DROP COLUMN Address

--- Updated 3 Addresses that had the incorrect province

-- Find Addresses that have incorrect Province Address

Select distinct(city),UpdatedAddress, Province
From HouseListings
where Province = 'Newfoundland and Labrador'

Select Province, UpdatedAddress
From HouseListings
where updatedaddress = 'LOT 1 APPLE ORCHARD WAY' 

Update HouseProject.dbo.HouseListings
Set Province = 'British Columbia'
Where UpdatedAddress = '61 COHO BLVD' 

Update HouseProject.dbo.HouseListings
Set Province = 'British Columbia'
Where UpdatedAddress = 'LOT 1 APPLE ORCHARD WAY'

Update HouseProject.dbo.HouseListings
Set Province = 'British Columbia'
Where UpdatedAddress = 'LOT A LINDSEY RD'

Select distinct(city), Province
from HouseListings
where province = 'Saskatchewan'

----- Changing Regina's Province for cells to Manitoba, Winnipeg

Select Province, City, UpdatedAddress
From HouseListings
where Province = 'Ontario' and City = 'Regina'

Update HouseProject.dbo.HouseListings
Set Province = 'Saskatchewan'
Where Province = 'Ontario' and City = 'Regina' 

----- Changing Saskatoon's Province for cells to Saskatchewan where they are currently Ontario
Select Province, City, UpdatedAddress
From HouseListings
where Province = 'Ontario' and City = 'Saskatoon'

Update HouseProject.dbo.HouseListings
Set Province = 'Saskatchewan'
Where Province = 'Ontario' and City = 'Saskatoon'

----- Changing Nanaimo's Province for cells to British Columbia where they are currently Ontario
Select Province, City, UpdatedAddress
From HouseListings
where Province = 'Ontario' and City = 'Nanaimo'

Update HouseProject.dbo.HouseListings
Set Province = 'British Columbia'
Where Province = 'Ontario' and City = 'Nanaimo'

----- Changing Winnipeg's Province for cells to Manitoba where they are currently Ontario
Select Province, City, UpdatedAddress
From HouseListings
where Province = 'Ontario' and City = 'Winnipeg'

Update HouseProject.dbo.HouseListings
Set Province = 'Manitoba'
Where Province = 'Ontario' and City = 'Winnipeg'


