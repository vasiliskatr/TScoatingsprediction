
![alt text](https://avatars2.githubusercontent.com/u/26812832?s=400&u=f4f2ba2f5babea6f0dd0885817a10cb6306d2ea6&v=4 "")


# Prediction of Thermally Sprayed Coating Properties on Complex Geometries 
***


This is a personal side-project to my PhD [thesis](http://epubs.surrey.ac.uk/847080/1/revised%20Thesis%20V4%20KATRANIDIS%20VASILEIOS.pdf) which started back in 2016, as an attempt to utilize and generalize my experimetal results ([paper1](https://www.sciencedirect.com/science/article/pii/S0257897217300166), [paper2](https://www.sciencedirect.com/science/article/pii/S0257897217309131)) and create valuable predictions on spraying (internally or externally) arbitrarily complex geometries.


The code herein is directly associated with the [publication](https://link.springer.com/article/10.1007/s11666-018-0739-6) where a detailed discussion of the methodology is presented.

At a high level, the prediction is achieved by two steps:
* Geometric analysis of the input computer-aided-design geometry and calculating the spray kinematic parameters (spray angle, spray distance and gun traverse speed) that would describe the impigement of energetic particles ont its surface, when such geometry would be rotated around its axis, in front or around a spray gun (external and internal spray respectively).
* Correlation of the resulting kinematic conditions profile (unique to each geometry) with key experimental measurements.


![alt text](https://media.springernature.com/lw785/springer-static/image/art%3A10.1007%2Fs11666-018-0739-6/MediaObjects/11666_2018_739_Fig1_HTML.png "High level functionality of the application")




The results of the developed tool have been validated experimentally using HVOF-sprayed WC-17Co coatings. Specifically, coating thickness, microhardness, WC vol.% and specific sliding wear rate are examined and their values are predicted for the case of the external spray of a rotor-like model.
 

## Brief Background in Thermal Spray Coatings
***

The Thermal spray coatings is a multi-bilion dollar global market with steady growth projections. Thermal spray methods are suitable for producing coatings from a wide range of materials, on a wide range of substrates. Coatings that offer:
* wear resistance
* corrosion resistance
* creation of free standing structures
* rebuilding of damaged parts
* biocompatibility

The concept behind thermal spray as a process is the progressive build-up of a coating via the cumulative impingement of highly energetic particles that deform upon impact on a substrate. Such coatings support many misson-critical applications in a variety of idnustrial sectors:
* Automobile
* Ship building
* Chemical, including off-shore exploration
* Energy production
* Iron and steel production
* Medical
* Mining
* Nuclear
* Packaging 


## The Challenge - Motivation
***
Thermal spray methods are line-of-sight processes which means that, when the spray gun traverses over a complex geometry or equivalently when a complex geometry is rotated in front or around the spray gun, there are fluctuations in:
1. **the spray angle**
2. **the stand-off distance (SoD) between the nozzle and the substrate**
3. **the gun traverse speed**

These variations are a function of the relative motion of the spray gun and the sprayed component, as such they are referred to as spray kinematic parameters. Changes in the spray kinematic parameters during the spray process can have a strong effect in the characteristics of the resulting coating because they dictate the state of the particle at the moment of impingement. The spray angle governs the velocity components of the impinging particles, spray distance is directly related with the overall velocity, thermal history and temperature of the particle at the moment of impingement (which in turn dictates its plasticity), 
and gun traverse speed affects the heat and mass transfer on the coated surface. For that reason, it is generally accepted in industry that any fluctuation in the spray kinematic parameters should be avoided and they should be maintained at the optimum values throughout the spray process.

Following this notion, thermal sprayed coatings were conventionally applied on large, planar or axisymmetric components either by linear translation of the gun over the surface or by rotation of the part in front of the gun. Nevertheless, **there is a demand to coat increasingly complex parts (externally and/or internally) and expand the scope of the thermal spray applications**. Notable examples of such applications are:

* Coatings on [medical implants](https://www.ncbi.nlm.nih.gov/pubmed/26810376)
* Aerospace coatings on [turbine blades, airfoils, seals](https://www.springer.com/la/book/9780387283197)
* Steel production and off-shore applicationssuch as [billet molds and oil drilling rotors](https://www.researchgate.net/publication/223936718_Novel_composite_coating_technology_in_primary_and_conversion_industry_applications)

The need to extend thermal spray appications to more complex geometries has become even more urgent, considering the push from industry to replace the toxic [hard chromium plating](https://en.wikipedia.org/wiki/Chrome_plating) applications, which are conventionally used to coat complex geometries.

**The purpose of the modeling approach that is discussed herein is to accelerate the feasibility studies and decision-making with regard to novel applications of thermal spray coatings via reliable predictions of the coating preoperties, as a result of the geometrical complexity of the processed part**.

## Prerequisites/Dependencies
***

* MATLAB R2016 and [after](https://uk.mathworks.com/downloads/)
* [**stlTools** library](https://uk.mathworks.com/matlabcentral/fileexchange/51200-stltools)
* [**geom2d** library](https://uk.mathworks.com/matlabcentral/fileexchange/7844-geom2d)
* [**geom3d**library](https://uk.mathworks.com/matlabcentral/fileexchange/24484-geom3d?s_tid=FX_rc1_behav)



## Getting Started
***
Downlading all the files in the repository and running the **main.m** will run the program on the **modelt.STL** (included in the repo), which is an example of a complex geometry that can be sprayed externally.

## Running the calculator
***
The following User-Inputs are required to run the program:
* stl. file to be anlysed ("*modelt.stl*" in **main.m**).
* Name of the analized geometry ("*name*" in **main.m**).
* The diameter of the spray footprint in mm ("*footpr*" in **main.m**).
* The overlap factor between succeding spray passes in % percenatge ("*overl*" in **main.m**).
* The rotational speed of the examined geometry in rpm ("*rpm*" in **main.m**).
* *OPTIONAL/GEOMETRY PRE-PROCESSING* The rotation axis that will be used for the roattion of the .stl geometry, in case there is such need before the analysis, (0,1,0) in the case of *modelt.stl** ("*rotaxis*" in **main.m**).
* *OPTIONAL/GEOMETRY PRE-PROCESSING* The rotation in radians that will be used for the roattion of the .stl geometry, in case there is such need before the analysis, "0" in the case of *modelt.stl** ("*rotrad*" in **main.m**).
* *OPTIONAL/GEOMETRY PRE-PROCESSING* The scale factors for each dimension, in case the .stl geomtry needs to be scaled before the analysis, (6,6,6) in the case of *modelt.stl** ("*scalef*" in **main.m**).
* The index of the sprayed pass whos kinematic results and coating proerties predictions will be presented in detailed graphs ("*spraypassexamined*" in **main.m**). This is asked to the used directly via the matlab prompt (line 49 in **main.m**).
* The values of the experimental results for the coating properties of interest which were obtained at [specified kinematic condtitions](https://link.springer.com/article/10.1007/s11666-018-0739-6) so that the prediction space can be constructed.
At the moment, all the User Imput (except "*spraypassexamined*") are inserted manually in the code. **A UI that accepts the above input objects and parameters will be built in future versions.**


The **First** part of the code in **main.m** (until line 45) imports the geomtry.stl file along with some user-defined paramaters and pre-process the geometry (scale and rotation), if needed, so that the calculation of the spray kinematic parameters can begin.

The **Second** part of the code in **main.m** (lines 46 to 85):
1. Slices the geometry into horizontal sections (3D polygons) that serve as "sprayed passes" as the geometry is rotated hypothetically.
2. Discrtizes the sprayed passes into a fixed number of nodes, which yields and ordered mesh that describes the analysed geometry.
3. Checks if the part can be sprayed (no shadowing and discontinuities) and whether external or internal spray is intended (and possible). **If shadowing or discontinuities exist as a result of the complexity of the geometry, the part is renderrd not-sprayable and the code is aborted.**
4. Calculates the spray kinematic paramaters (spray angle, spray distance and gun traverse speed) for all the nodes, of all sprayed passes.
5. Plots the kinematic parametres for a user-selected sprayed pass.

The **Third** part of the code in **main.m** (lines 86 to 100)
1. Imports the experimental results for the examined coating properties.
2. Interpolates and normalizes the experiemtnal results, constructing a prediction space for each coating property.
3. Maps the calculated spray kinematic parameters of each node to the respective conditions in the prediction space. **If the calculated spray kineamtic parameters exceed the range of the prediction space at any instance (spray angle, spray distance or gun traverse speed), there is not adequate experimental data to make any predictions and the code is aborted.**
4. Plots the predicted values for the examined coating proprties for a user-selected sprayed pass.
5. Plots the predictions for the examined coating properties, for all the nodes in all the sprayed passes on the geometry mesh, offering a intuitive visualization of the probelatic areas.


## Contributing
*** 
* A UI would be usefull.
* A version  of the code in Python is under construction.
* Any feedback or comments are welcomed : )


## Author
***
* **Vasileios Katranidis** - [Linkedin](https://www.linkedin.com/in/vasiliskatranidis/)


## License
***
See the [LICENSE.md](https://github.com/vasiliskatr/TScoatingsprediction/blob/master/LICENCE.md) file for details



