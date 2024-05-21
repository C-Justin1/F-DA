SELECT * FROM tutorial.nashvillehousing;

select saledate, convert (saledate, date) 
from nashvillehousing;

update Nashvillehousing
set saledate= convert(saledate,date);

update NashvilleHousing
set
	PropertyAddress= nullif(PropertyAddress, ''),
    OwnerName= nullif(OwnerName, ''),
    Acreage= Nullif(Acreage, ''),
    TaxDistrict= Nullif(TaxDistrict, ''),
    LandValue= Nullif(LandValue, ''),
    BuildingValue= nullif(BuildingValue, ''),
    TotalValue= Nullif(TotalValue, ''),
    YearBuilt= Nullif(YearBuilt, ''),
    Bedrooms= Nullif(Bedrooms, ''),
    Fullbath= Nullif(Fullbath, ''),
    Halfbath= Nullif(Halfbath, '')
    
where
    PropertyAddress= "" or
    OwnerName= "" or
    Acreage= "" or
    TaxDistrict= "" or
    LandValue= "" or
    BuildingValue= "" or
    TotalValue= "" or
    YearBuilt= "" or
    Bedrooms= "" or
    Fullbath= "" or
    Halfbath= "";
    
    
    
**Populate Propertyaddress

Select * 
from NashvilleHousing
where Propertyaddress= "";

select 
	a.parcelId, 
    a.propertyAddress as PropertyaddressA, 
    b.parcelid, 
    b.propertyAddress as propertyAddressB, 
    coalesce (nullif(a.propertyaddress,''), b.propertyaddress) 
    as updatedAddress  
    from nashvillehousing A   
    join NashvilleHousing B 
    on A.ParcelID = B.ParcelID  
    And A.UniqueID <> B.uniqueID   
    where A.propertyAddress= "" or a.propertyaddress is null;


update Nashvillehousing A
 join NashvilleHousing B 
    on A.ParcelID = B.ParcelID  
    And A.UniqueID <> B.uniqueID 
set A.PropertyAddress=  coalesce (nullif(a.propertyaddress,''), b.propertyaddress)
    where A.propertyAddress= "" or a.propertyaddress is null;
    
    
    select distinct (soldasVacant), count(soldasvacant)
    from Nashvillehousing
    group by soldasvacant
    order by 2

** Remove duplicates (find correct syntax)

with Row_numcte as(
select*,
Row_number() over(
partition by ParcelID,
			 PropertyAddress,
             SalePrice,
             Saledate,
             LegalReference
             Order by UniqueID) 
As row_num
from NashvilleHousing
)
select *
from Row_numcte
where row_num > 1
order by PropertyAddress




















