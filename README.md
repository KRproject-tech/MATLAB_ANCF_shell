
![図1](https://github.com/KRproject-tech/MATLAB_ANCF_shell/assets/114337358/e5dbcfc7-b599-4b77-b23e-5d20768e6cac)


# MATLAB_ANCF_shell
Nonlinear shell dynamics analysis based on FEM shell element with Absolute Nodal Coordinate Formulation (ANCF) [^1]. 

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
└─Plate_FEM_explicit_3_SURFplot
    ├─cores
    │  ├─functions
    │  ├─solver
    │  └─ToolBoxes
    │      ├─mntimes
    │      └─Plate_Mesh
    └─save
        └─fig
</pre>


## Preparation before analysis
__[Step 1] Install the ToolBoxes__

The following ToolBoxes in “./cores/ToolBoxes/” are required,

__For plotting results:__

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

### References  

[^1]: A. Shabana, Computational Continuum Mechanics, Chap. 6 (Cambridge University Press, 2008), pp. 231–285.
[^2]: K. Dufva and A. Shabana, Analysis of thin plate structures using the absolute nodal coordinate formulation, Proc. IMechE Vol. 219 Part K: J. Multi-body Dynamics, 2005.




