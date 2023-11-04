SELECT * FROM `international brewery`.international_breweries;
-- Within the space of the last three years, what was the profit worth of the breweries,
	-- inclusive of the anglophone and the francophone territories? --
select sum(profit) as total_pofit 
	from international_breweries;
alter table international_breweries add language varchar(20);
update international_breweries
set language = case
					when countries = 'nigeria'  then 'anglophone'
                    when COUNTRIES = 'ghana'	then 'anglophone'
                    when COUNTRIES = 'benin' 	then 'francophone'
                    when countries = 'senegal'  then 'francophone'
                    when countries = 'togo'		then 'francophone'
                    end;
alter table international_breweries add DRINK_TYPE char(30);
update international_breweries
set DRINK_TYPE = case
					when brands = 'trophy' 		then 'beer'
					when BRANDS = 'budweiser'	then 'beer'
                    when BRANDS = 'castle lite' then 'beer'
                    when BRANDS = 'eagle lager' then 'beer'
                    when brands = 'hero'		then 'beer'
                    when brands = 'beta malt'	then 'malt'
                    when brands = 'grand malt'	then 'malt'
                    end;

-- Compare the total profit between these two territories in order for the territory
	-- manager, Mr. Stone made a strategic decision that will aid profit maximization in 2020.
select language, sum(profit) as total_profit 
	from international_breweries
		group by language
			order by total_profit;
                        
-- Country that generated the highest profit in 2019--
SELECT countries, sum(PROFIT) as profit_made 
	FROM international_breweries 
		group by countries
			order by profit_made desc
				limit 1;

-- Help him find the year with the highest profit.--
select YEARS,sum(profit)  as total_profit_2017 
	from international_breweries
		group by YEARS
         order by total_profit_2017;

-- . Which month in the three years was the least profit generated?--
select MONTHS, sum(profit) as profit_made_per_month
	from international_breweries
		group by months
         order by profit_made_per_month
			limit 1;
			
-- What was the minimum profit in the month of December 2018? --
select min(profit) as minimum_profit_december_2019
	from international_breweries 
		where years= 2019 and months= 'december';

-- Which particular brand generated the highest profit in Senegal?--
select brands, sum(profit)as profit_by_brands
	from international_breweries
		where countries = 'senegal'
			group by brands;
            
-- Within the last two years, the brand manager wants to know the top three brands consumed in the--
		-- francophone countries--
select brands, sum(quantity) as unit_sold 
	from international_breweries
		where language = 'francophone'
			group by brands
				order by unit_sold desc
					limit 3;
                    
--  Find out the top two choice of consumer brands in Ghana--
select brands, sum(quantity) as unit_sold 
	from international_breweries
		where countries= 'ghana'
			group by brands
				order by unit_sold desc
					limit 2;
                    
-- Find out the details of beers consumed in the past three years in the most oil rich country in West Africa.
select  brands,  sum(quantity) as unit_sold, sum(profit) as total_profit, sum(plant_cost) as total_plant_cost, sum(cost) as total_cost
	from international_breweries
		where countries= 'nigeria'
			group by brands
				order by unit_sold desc
					limit 1;

--  Favorites malt brand in Anglophone region between 2018 and 2019 --
select brands, sum(quantity) as total_unit_sold
	from international_breweries
		where language= 'anglophone' and brands regexp 'malt'
			group by brands;

-- Which brands sold the highest in 2019 in Nigeria?--
select brands, sum(quantity) as total_unit_sold
	from international_breweries
		where countries = 'Nigeria'
			group by brands
				order by total_unit_sold desc;

-- Favorites brand in South South region in Nigeria--
select brands, sum(quantity) as total_unit_sold
	from international_breweries
		where countries = 'Nigeria' and region = 'southsouth'
			group by brands
				order by total_unit_sold desc;

-- Bear consumption in Nigeria--
select brands, sum(quantity) as total_unit_sold
	from international_breweries
		where countries = 'Nigeria' and (brands <> 'beta malt' and brands <> 'grand malt') 
			group by brands;

-- Level of consumption of Budweiser in the regions in Nigerian --
select brands, region, sum(quantity) as total_comsumption
	from international_breweries
		where brands= 'budweiser' and countries = 'Nigeria'
			group by region
				order by total_comsumption;

-- Level of consumption of Budweiser in the regions in Nigeria in 2019 --
select brands, region, sum(quantity) as total_comsumption
	from international_breweries
		where brands= 'budweiser' and countries = 'Nigeria' and years = 2019
			group by region
				order by total_comsumption;
                
                
			## GEO-LOCATION ANALYSIS
-- Country with the highest consumption of beer--
select countries, sum(quantity) as unit_sold_per_country
	from international_breweries
		where DRINK_TYPE = 'beer'
			group by countries
             order by unit_sold_per_country
				limit 1;

-- Highest sales personnel of Budweiser in Senegal--
select sales_rep, sum(quantity) as unit_sold_per_sales_rep
	from international_breweries
		where countries = 'senegal'
			group by SALES_REP
				order by unit_sold_per_sales_rep
					limit 1;

-- Country with the highest profit of the fourth quarter in 2019--
select countries , sum(quantity) as unit_sold
	from international_breweries
		where years = 2019 and (months = 'september' or months = 'october' or MONTHS = ' november' or MONTHS = 'december')
			group by COUNTRIES
				order by unit_sold desc
                 limit 1;