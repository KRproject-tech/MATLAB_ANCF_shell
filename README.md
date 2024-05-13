
![図1](https://github.com/KRproject-tech/MATLAB_ANCF_shell/assets/114337358/e5dbcfc7-b599-4b77-b23e-5d20768e6cac)


# MATLAB_ANCF_shell
Nonlinear plate dynamics analysis based on FEM shell element with Absolute Nodal Coordinate Formulation (ANCF) [^1]. 

**Communication**

<a style="text-decoration: none" href="https://twitter.com/hogelungfish_" target="_blank">
    <img src="https://img.shields.io/badge/twitter-%40hogelungfish_-1da1f2.svg" alt="Twitter">
</a>
<p>

**Language**
<p>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/matlab/matlab-original.svg" width="60"/>
<p>


## Directory    
<pre>
├─Plate_FEM_explicit_3_SURFplot
│  ├─cores
│  │  ├─functions
│  │  ├─solver
│  │  └─ToolBoxes
│  └─save
│      └─fig
└─Plate_FEM_implicit_0
    ├─cores
    │  ├─functions
    │  ├─solver
    │  └─ToolBoxes
    └─save
        └─fig
</pre>

* __Plate_FEM_implicit_0__ : Implicit solver (Faster and more robust under the thin thickness condition)

* __Plate_FEM_explicit_3_SURFplot__ : Explicit solver (Light computing cost)


## Preparation before analysis
__[Step 1] Install the ToolBoxes__

The following ToolBoxes in “./XXXX/cores/ToolBoxes/” are required,


__For numerical analysis:__

*	__“Meshing a plate using four noded elements”__ by KSSV:

https://jp.mathworks.com/matlabcentral/fileexchange/33731-meshing-a-plate-using-four-noded-elements

*	__“Sparse sub access”__ by Bruno Luong:

https://jp.mathworks.com/matlabcentral/fileexchange/23488-sparse-sub-access

*   __“Vectorized Multi-Dimensional Matrix Multiplication”__ by Darin Koblick:

https://jp.mathworks.com/matlabcentral/fileexchange/47092-vectorized-multi-dimensional-matrix-multiplication?s_tid=prof_contriblnk

__For plotting results:__

*	__“mmwrite”__ by Micah Richert:
  
https://jp.mathworks.com/matlabcentral/fileexchange/15881-mmwrite

*	__“mpgwrite”__ by  David Foti:
   
https://jp.mathworks.com/matlabcentral/fileexchange/309-mpgwrite?s_tid=srchtitle




__[Step 1.2] Add path to installed ToolBoxes__

Modify "add_pathes.m" to add path to abovementined installed ToolBoxes as follows,
````
addpath ./cores/ToolBoxes/XX;
````
where `XX` is the name of folder of the installed ToolBox.

__[Step 2] Start GUI form__

Open the “GUI.fig” from MATLAB.

![タイトルなし](https://user-images.githubusercontent.com/114337358/192756887-25b36670-8faa-423f-b535-63a536ced8c8.png)

__[Step 2.1] Pre-setting__

Push the "Parameters" button and edit parameters.

__[Step 3] Start analysis__

Push the “exe” button and wait until the finish of the analysis.

__[Step 4] Plot results__

Push the “plot” button.
    
__[Step 5] View plotted results__

Results (figures and movie) plotted by [Step 4] are in "./save" directory.


## Parameters

Analytical condisions are in "./save/param_setting.m"

````
End_Time = 1.0;             %% Analytical time [s]
d_t = 1e-4;                 %% step time [s]
core_num = 6;               %% The number of CPUs for computing [-]
movie_format = 'mpeg';      %% movie format [-]
% movie_format = 'avi';
speed_check = 0;            %% 

%% Plate
rho_m = 1000;           	%% density [kg/m^3]
Eelastic = 1e+3;        	%% Young's modulus [Pa]
nu = 0.3;                   %% Poiison ratio [-]

Length = 100e-3;          	%% Length [m]
Width = 100e-3;             %% Width [m]
thick = 10e-3;           	%% Thickness [m]
Nx = 8;                   	%% The number of x-directional elements [-]
Ny = 8;                   	%% The number of y-directional elements [-]
N_gauss = 5;                %% Gauss-Legendre [-]

g = 9.81;                   %% gravity acc. [m/s^2]
F_in = -rho_m*g*[ 0 0 1].';	%% gravity [N/m^3]
````

and boundary conditions for nodes on plate;

````
%% Boundary conditions
node_r_0 = [ 1];          	%% Node number for fixed node [-]
node_dxr_0 = [ ];        	%% Node number for fixed x-directional gradient [-]
node_dyr_0 = [ ];       	%% Node number for fixed y-directional gradient [-]
````


## Gallery

* Young's modulus: $1.0 \times 10^5 \ \rm{Pa}$
* density: $7810 \ \rm{kg/m^3}$
* Poisson ratio: $0.3$
* Length, width: $0.3 \ \rm{m}$
* Thickness: $0.01 \ \rm{m}$


![untitled](https://github.com/KRproject-tech/MATLAB_ANCF_shell/assets/114337358/079c1aec-ef70-4440-af5c-2affb104febc)

Deformed shape of the pendulum by this code ($8^2$ elements).

![untitled2](https://github.com/KRproject-tech/MATLAB_ANCF_shell/assets/114337358/ab0a9812-acdd-4bea-ac7a-89cbdee85bd7)

Deformed shape of the pendulum by this code ($12^2$ elements).


![reduced_model](https://github.com/KRproject-tech/MATLAB_ANCF_shell/assets/114337358/8f979d19-6967-448a-b42d-4a88274c69cc)

Deformed shape of the pendulum by the preceding report (Model I, $8^2$ elements, interpolated) [^2].


## Stargazers over time
[![Stargazers over time](https://starchart.cc/KRproject-tech/MATLAB_ANCF_shell.svg?variant=adaptive)](https://starchart.cc/KRproject-tech/MATLAB_ANCF_shell)



### References  

[^1]: A. Shabana, Computational Continuum Mechanics, Chap. 6 (Cambridge University Press, 2008), pp. 231–285.
[^2]: K. Dufva and A. Shabana, Analysis of thin plate structures using the absolute nodal coordinate formulation, Proc. IMechE Vol. 219 Part K: J. Multi-body Dynamics, 2005.




