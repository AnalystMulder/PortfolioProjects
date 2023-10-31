/*

Cleaning Data in SQL Queries

*/

Select*
From PortfolioProject.dbo.NashvilleHousing

-- Standardize Date Format

Select SaleDateConverted, Convert(Date,SaleDate)
From PortfolioProject.dbo.NashvilleHousing

Update NashvilleHousing
Set SaleDate = convert(Date,SaleDate)

Alter Table NashvilleHousing
add SaleDateConverted Date;

Update NashvilleHousing
Set SaleDateConverted = convert(Date,SaleDate)




-- Populate Property Address data. 
--This excercise allows you to update NULL fields under Property Addresss with addresses that have the same ParcelID as another address. 
--It also allows you to keep the Unique ID from changing. The goal is to update the property address for orders that have a null value.

Select *
From PortfolioProject.dbo.NashvilleHousing
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID] <> b.[UniqueID]
Where a.PropertyAddress is null

Update a
Set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID] <> b.[UniqueID]
Where a.PropertyAddress is null



-- Breaking out Address into Individual Columns (Address, City, State)

Select PropertyAddress
FROM PortfolioProject.dbo.NashvilleHousing

Select
SUBSTRING(PropertyAddress,1,CHARINDEX(',', PropertyAddress)-1) as Address
, SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1, Len(PropertyAddress)) as Address
FROM PortfolioProject.dbo.NashvilleHousing

Alter Table NashvilleHousing
add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
Set PropertySplitAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',', PropertyAddress)-1) 

Alter Table NashvilleHousing
add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
Set PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1, Len(PropertyAddress)) 



Select OwnerAddress	
From PortfolioProject.dbo.NashvilleHousing 

Select
Parsename(Replace(OwnerAddress, ',', '.'), 3)
,Parsename(Replace(OwnerAddress, ',', '.'), 2)
,Parsename(Replace(OwnerAddress, ',', '.'), 1)
From PortfolioProject.dbo.NashvilleHousing 

Alter Table PortfolioProject.dbo.NashvilleHousing
add OwnerSplitAddress Nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousing
Set OwnerSplitAddress  = Parsename(Replace(OwnerAddress, ',', '.'), 3) 

Alter Table PortfolioProject.dbo.NashvilleHousing
add OwnerSplitCity Nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousing
Set OwnerSplitCity = Parsename(Replace(OwnerAddress, ',', '.'), 2)

Alter Table PortfolioProject.dbo.NashvilleHousing
add OwnerSplitState Nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousing
Set OwnerSplitState = Parsename(Replace(OwnerAddress, ',', '.'), 1)



-- Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject.dbo.NashvilleHousing 
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
, CASE when SoldAsVacant = 'Y' Then 'Yes'
	when SoldAsVacant = 'N' Then 'No'
	else SoldAsVacant
	END
From PortfolioProject.dbo.NashvilleHousing

Update NashvilleHousing
Set SoldAsVacant = CASE when SoldAsVacant = 'Y' Then 'Yes'
	when SoldAsVacant = 'N' Then 'No'
	else SoldAsVacant
	END


-- Remove Duplicates

With RowNumCTE AS(
Select * ,
Row_number () Over (
Partition by ParcelID,
			PropertyAddress,
			SalePrice,
			SaleDate,
			LegalReference
			Order By
			UniqueID
			) row_num
From PortfolioProject.dbo.NashvilleHousing
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress



-- Remove Unused Columns

Select*
From PortfolioProject.dbo.NashvilleHousing

Alter Table PortfolioProject.dbo.NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress

Alter Table PortfolioProject.dbo.NashvilleHousing
Drop Column SaleDate

