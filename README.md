The NConvex package
=========================

version 15/01/2019.

Introduction
------------
The [NConvex](https://kamalsaleh.github.io/NConvex) package is a GAP package. Its aim is to carry out polyhedral constructions and computations, namely computing properties and attributes of
cones, polyhedrons, polytopes and fans. Its has been written
to provide the needed tools for the package "ToricVarieties". All written as
part of the homalg-project.


Installation
-----------
The package can easily be obtained by cloning the repository 
https://github.com/homalg-project/NConvex.git
in the pkg directory of the Gap installation or your local directory for Gap packages.

Required packages
-----------------

* The Gap package "CddInterface" is required to convert between H-rep and V-rep of polyhedrons. It can be obtained at:
  https://github.com/homalg-project/CddInterface.git
  
* The Gap/homalg-project package "Modules". You can install the package by cloning the "homalg_project" repository from
https://github.com/homalg-project/homalg_project.git

* You will also need "AutoDoc" package to be able to create the documentation and to perform tests. A fresh version can be installed from
https://github.com/gap-packages/AutoDoc.git

* Finallay You will need **one** of the following two packages. In case both are available then "NConvex" will use "4ti2Interface".

  * The Gap/homalg package "4ti2Interface". It is already included in the
  homalg-project https://github.com/homalg-project/homalg_project

  * The Gap package "NormalizInterface". You can install it from 
  https://github.com/gap-packages/NormalizInterface.git





Remarks
-------
* To create the documentation go in your terminal to where you installed the package and 
 perform the command
   ```sh
   .../NConvex$ gap makedoc.g
   ```
* To run tests:
   ```sh
   .../NConvex$ gap maketest.g
   ```
   or simply
   ```sh
   .../NConvex$ make
   ```
* For the installation of Gap see https://www.gap-system.org/

* You can create the documentation with diagrams if your latex installation has the required packages. To try it by un-commenting the
required code by:
   
   ```sh
   .../NConvex$ sed -i 's/#?//g' makedoc.g
   ../examples$ sed -i 's/#&/#!/g' *.g
   .../NConvex$ gap makedoc.g
   ```



Of course you are welcome to e-mail me if there are any questions, remarks, suggestions ;)
  
  Kamal Saleh e-mail: saleh@mathematik.uni-siegen.de \
  Sebastian Gutsche e-mail:
  gutsche@mathematik.uni-siegen.de
  
