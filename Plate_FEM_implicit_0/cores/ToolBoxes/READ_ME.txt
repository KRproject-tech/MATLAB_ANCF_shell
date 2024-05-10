[Step 1] Install the ToolBoxes

The following ToolBoxes in “./cores/ToolBoxes/”  are required,

For numerical analysis:

“Meshing a plate using four noded elements” by KSSV:
https://jp.mathworks.com/matlabcentral/fileexchange/33731-meshing-a-plate-using-four-noded-elements

“Sparse sub access” by Bruno Luong:
https://jp.mathworks.com/matlabcentral/fileexchange/23488-sparse-sub-access

“Vectorized Multi-Dimensional Matrix Multiplication” by Darin Koblick:
https://jp.mathworks.com/matlabcentral/fileexchange/47092-vectorized-multi-dimensional-matrix-multiplication?s_tid=prof_contriblnk

For plotting results:

“mmwrite” by Micah Richert:
https://jp.mathworks.com/matlabcentral/fileexchange/15881-mmwrite



[Step 1.2] Add path to installed ToolBoxes

Modify "add_pathes.m" to add path to abovementined installed ToolBoxes as follows,

addpath ./ToolBoxes/XX;

where XX is the name of folder of the installed ToolBox.