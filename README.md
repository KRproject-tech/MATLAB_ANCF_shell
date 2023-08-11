# MATLAB_ANCF_shell
Nonlinear shell dynamics analysis based on FEM shell element with Absolute Nodal Coordinate. Formulation (ANCF). 

**Communication**

<a style="text-decoration: none" href="https://twitter.com/hogelungfish_" target="_blank">
    <img src="https://img.shields.io/badge/twitter-%40hogelungfish_-1da1f2.svg" alt="Twitter">
</a>
<p>

**Language**
<p>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/matlab/matlab-original.svg" width="60"/>
<p>


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
