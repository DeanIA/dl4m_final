# Satellite Project

We are using methods learned from Deep Learning for Media (MPATE-GE 2039) to investigate how to generate and classify satellite imagery.

We had several research questions, including:

- What data sets exist for satellite imagery and how do they compare?
- How do different models perform on satellite imagery?
- Is RGB or Multispectral Band imagery better for deep learning?
- Can population be predicted from satellite imagery?

## Data

### EuroSAT

[The EuroSAT dataset](https://github.com/phelber/EuroSAT) provides two sets of 27,000 satellite images, one with 13 multispectral bands and another with RGB. This imagery has ten labels for land cover classification including 'AnnualCrop', 'Forest', and 'Highway'.

### Mapbox API

Using the Mapbox API, we generate two datasets of ~5400 images each, one for each census tract in the state of New York. They are set to two different "zoom" levels at the centroid of each census tract. The functions we used to call the API are contained in [generate_images.ipynb](https://github.com/DeanIA/dl4m_final/blob/main/generate_images.ipynb).

There datasets are quite large but can be accessed on a Shared Google Drive here. You may need to request access to open. Link: [Mapbox Datasets](https://drive.google.com/drive/folders/14b-4faQ0EOhJEAhjNNlAyK46_-BIunRg).

### US Census Data

The US Census publishes data at the Census Tract level for all census tracts in the US. We utilized the informatino for the state of New York, uploaded here as tract_data.csv. The data was further manipulated using scripts written in R to calculate centroids and identify appropriate population density clusters for the different census tracts, contained in [census_tract_labels.R](https://github.com/DeanIA/dl4m_final/blob/main/census_tract_labels.R).

## Modeling

### Synthetic Data Generation with EuroSAT

Using the EuroSAT database we trained a VAE to generate synthetic satellite imagery. Perhaps due to the model's relative simplicity and/or the varied nature of the imagery, the data the model generated was too blurry to be used for further research.

### RBG vs Spectral Modeling

Using VGG-16 and BigEarthNet pretrained models to test land classification accuracy on the EuroSAT database's RGB and Multispectral imagery. The result suggests a model trained on Multispectral imagery performs better for land classification tasks.  

### Population Density Prediction

Using the Mapbox dataset created from generate_images.ipynb, we built a CNN that was used to predict the urbanicty (rural, suburban, or urban) of the images across New York. The CNN resulted in validation accuracy of .92. This modeling is contained in [mapbox_rgb_model.ipynb](https://github.com/DeanIA/dl4m_final/blob/main/mapbox_rgb_model.ipynb).

## Credits

Nathan researched satellite imagery datasets, trained the EuroSAT VAE model, helped design the final presentation, and took meeting notes.

### Contact Info

-  Christopher Praley: cpraley@nyu.edu
-  Dean Issacharoff: dai7591@nyu.edu
-  Inigo Fuster de la Fuente: ifd210@nyu.edu
-  Nathan Townes-Anderson: nt2420@nyu.edu

### Document Summary

| **Document Name**      | **Owner** | **Description**                                                                                                                                                                                                                               |
|------------------------|-----------|------------------------------------------------------|
| generate_images.ipynb  | Chris     | Notebook utilizing both census tract information from the US Census Bureau to identify centroids for each census tract in the stae of NY. Using those centroids, a function to query the Mapbox API for one satellite image per census tract. |
| mapbox_rgb_model.ipynb | Chris     | Notebook generating a CNN to classify satellite images using the RGB images generated from the Mapbox API.  |
| map_widget.ipynb       | Chris     | Notebook containing an interactive widget that outputs satellite image and population density prediction based on address.|
| census_tract_labels.R  | Chris     | R script that identifies centroids from US Census shapefile and creates clusters based on population density.  |
| EuroSAT_VAE_Synthetic_Data_Generation_Share.ipynb | Nathan | Notebook loading the EuroSAT dataset and training a VAE to generate synthetic data. |
| env.yml                | Dean      | Dependencies for models |
| rgb_model.ipynb        | Dean      | Notebook for finetuning a VGG16 model for classification of the RGB EuroSAT dataset. |
| sent2_model.ipynb      | Dean      | Notebook for a BigEarthNet trained classifer applied to the Multiband EuroSAT dataset. |
