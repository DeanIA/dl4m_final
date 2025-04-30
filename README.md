# Satellite Project

We are using methods learned from Deep Learning for Media (MPATE-GE 2039) to investigate how to classify satellite imagery.

## Data

### EuroSAT

### Mapbox API

Using the Mapbox API, we generate two datasets of ~5400 images each, one for each census tract in the state of New York. They are set to two different "zoom" levels at the centroid of each census tract. The functions we used to call the API are contained in [generate_images.ipynb]([url](https://github.com/DeanIA/dl4m_final/blob/main/generate_images.ipynb)).

There datasets are quite large but can be accessed on a Shared Google Drive here: [Mapbox Datasets]([url](https://drive.google.com/drive/folders/14b-4faQ0EOhJEAhjNNlAyK46_-BIunRg?usp=sharing)). You may need to request access to open.

### US Census Data

The US Census publishes data at the Census Tract level for all census tracts in the US. We utilized the informatino for the state of New York, uploaded here as tract_data.csv. The data was further manipulated using scripts written in R to calculate centroids and identify appropriate population density clusters for the different census tracts, contained in [census_tract_labels.R]([url](https://github.com/DeanIA/dl4m_final/blob/main/census_tract_labels.R))

## Modeling

### RBG vs Spectral Modeling

### Population Density Prediction

Using the Mapbox dataset created from generate_images.ipynb, we built a CNN that was used to predict the urbanicty (rural, suburban, or urban) of the images across New York. The CNN resulted in validation accuracy of .92. This modeling is contained in [mapbox_rgb_model.ipynb]([url](https://github.com/DeanIA/dl4m_final/blob/main/mapbox_rgb_model.ipynb)).

## Credits

### Contact Info

-  Christopher Praley: cpraley@nyu.edu

### Document Sumamry

| **Document Name**      | **Owner** | **Description**                                                                                                                                                                                                                               |
|------------------------|-----------|------------------------------------------------------|
| generate_images.ipynb  | Chris     | Notebook utilizing both census tract information from the US Census Bureau to identify centroids for each census tract in the stae of NY. Using those centroids, a function to query the Mapbox API for one satellite image per census tract. |
| mapbox_rgb_model.ipynb | Chris     | Notebook generating a CNN to classify satellite images using the RGB images generated from the Mapbox API.  |
| map_widget.ipynb       | Chris     | Notebook containing an interactive widget that outputs satellite image and population density prediction based on address.|
| census_tract_labels.R  | Chris     | R script that identifies centroids from US Census shapefile and creates clusters based on population density.  |
