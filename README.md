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

The following ToolBoxes in “./XXXX/ToolBoxes/” ("XXXX" is "double_sheets" and "single_sheet") are required,

__For plotting results:__

*	__“mpgwrite”__ by  David Foti:  
https://jp.mathworks.com/matlabcentral/fileexchange/309-mpgwrite?s_tid=srchtitle



__[Step 1.2] Add path to installed ToolBoxes__

Modify "add_pathes.m" to add path to abovementined installed ToolBoxes as follows,
````
addpath ./cores/ToolBoxes/XX;
````
where `XX` is the name of folder of the installed ToolBox.
