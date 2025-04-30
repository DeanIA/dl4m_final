library(readr)
library(sf)
library(janitor)
library(classInt)
library(tidyverse)
library(BAMMtools)

# set wd
setwd('~/Google Drive/My Drive/dl4m_final_project/')


# import and clean census population estimates
c <- read_csv('data/raw/census/ACSDT5Y2023.B01003-Data.csv',
              skip = 2)

c <- c %>%
  rename(geo_id = 1,
         tract_name = 2,
         pop_est = 3) %>% 
  select(1:3)

# import the census tract shape files
tracts_sf <- st_read('data/raw/census/tl_2023_36_tract/tl_2023_36_tract.shp') %>%
  rename(geo_id = GEOIDFQ)


# join pop estimates onto shapefile
df <- tracts_sf %>%
  left_join(c, by = 'geo_id')

# compute area & pop density
df <- df %>%
  # switch to albers equal‑area for accurate areas (epsg:5070)
  st_transform(crs = 5070) %>%
  mutate(
    area_m2     = st_area(geometry),
    area_sq_mi  = as.numeric(area_m2) / 2.589988e6,  # 1mi^2 = 2589988m^2
    pop_density = pop_est / area_sq_mi
  )

# extract centroids and just leave columns we want
result <- df %>%
  st_transform(crs = 4326) %>%
  st_centroid() %>%
  mutate(
    lon = st_coordinates(geometry)[,1],
    lat = st_coordinates(geometry)[,2]
  ) %>%
  st_drop_geometry() %>%
  select(geo_id, NAME, lon, lat, pop_density) %>% 
  mutate(pop_dens_log = log(pop_density + 1))

# cluster analysis on log of population density

set.seed(100)

temp <- getJenksBreaks(result_no_na$pop_dens_log, 4, subset = NULL)

cutoffs <- exp(temp)

# create classes based on pop_density
result <- result %>%
  mutate(
    density_label = case_when(
      pop_density < cutoffs[2] ~ 1,
      pop_density < cutoffs[3] ~ 2,
      pop_density < cutoffs[4] ~ 3,
      TRUE ~ NA
    )
  )

table(result$density_label)

write.csv(result, 'data/parsed/tract_data.csv')
