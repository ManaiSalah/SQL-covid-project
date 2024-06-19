SELECT*
FROM [Portfolio project]..CovidDeaths
Where continent is not null
ORDER BY 3,4


SELECT*
FROM [Portfolio project]..CovidVaccinations
ORDER BY 3,4

--SELECT Data that we are going to be using 

SELECT location,date,total_cases,new_cases,total_deaths,population
FROM [Portfolio project]..CovidDeaths
ORDER BY 1,2

--Total cases VS total Deaths

--Likelihood of dying if you get covid in your country
SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
FROM [Portfolio project]..CovidDeaths
Where location Like '%states%'
ORDER BY 1,2


--Total cases vs population 
--percentage of population got covid
SELECT location,date,total_cases,population,(total_cases/population)*100 as Percentpopulationinfected
FROM [Portfolio project]..CovidDeaths
Where location Like '%states%'
ORDER BY 1,2



--Highest infection rate by country compared to population
SELECT location,population,Max(total_cases) as Highest_infection_count,MAX((total_cases/population))*100 as Percent_population_infected
FROM [Portfolio project]..CovidDeaths
GROUP by location,population
ORDER BY Percent_population_infected DESC



--Countries with highest death count per population

SELECT location,MAX(cast(total_deaths as int)) as TotalDeathcount
FROM [Portfolio project]..CovidDeaths
Where continent is not null
GROUP by location
ORDER BY TotalDeathcount DESC



--Continent with the highest death count

SELECT continent,MAX(cast(total_deaths as int)) as TotalDeathcount
FROM [Portfolio project]..CovidDeaths
Where continent is not null
GROUP by continent
ORDER BY TotalDeathcount DESC


--Global numbers 

SELECT date,SUM(new_cases) as total_cases,SUM(cast(new_deaths as int)) as total_deaths ,SUM(cast(new_deaths as int))/SUM(new_cases)
FROM [Portfolio project]..CovidDeaths
Where continent is not null
GROUP BY date
ORDER BY 1,2


--Joins 
--looking at total population vs vaccinations

SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(cast(vac.new_vaccinations as int)) 
over (partition by dea.location order by dea.location,dea.date) as Rollingpeaoplevaccinated
from [Portfolio project]..CovidDeaths dea
Join [Portfolio project]..CovidVaccinations vac
	on dea.location=vac.location
	and dea.date=vac.date
	where dea.continent is not null
	order by 1,2,3
















