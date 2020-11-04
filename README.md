<!-- BEGIN HEADER -->
# NConvex&ensp;<sup><sup>[![View code][code-img]][code-url]</sup></sup>

### A Gap package to perform polyhedral computations

| Documentation | Latest Release | Build Status | Code Coverage |
| ------------- | -------------- | ------------ | ------------- |
| [![HTML stable documentation][html-img]][html-url] [![PDF stable documentation][pdf-img]][pdf-url] | [![version][version-img]][version-url] [![date][date-img]][date-url] | [![Build Status][tests-img]][tests-url] | [![Code Coverage][codecov-img]][codecov-url] |

<!-- END HEADER -->
[![Build Status](https://travis-ci.com/homalg-project/NConvex.svg?branch=master)](https://travis-ci.com/homalg-project/NConvex)
[![Code Coverage](https://codecov.io/github/homalg-project/NConvex/coverage.svg?branch=master&token=)](https://codecov.io/gh/homalg-project/NConvex)

Introduction
------------
The [NConvex](https://homalg-project.github.io/NConvex) package is a GAP package. Its aim is to carry out polyhedral constructions and computations, namely computing properties and attributes of
cones, polyhedrons, polytopes and fans. Its has been written
to provide the needed tools for the package "ToricVarieties". All written as
part of the homalg-project. A list of available operations can be found in the 
[manual.pdf](https://homalg-project.github.io/NConvex/manual.pdf)


Installation
-----------
The package can easily be obtained by cloning the repository 
  
  https://github.com/homalg-project/NConvex.git

in the pkg directory of the Gap installation or your local directory for Gap packages.

Required packages
-----------------

-   The Gap package "CddInterface" is required to convert between H-rep and V-rep of polyhedrons. It can be obtained at:
  
      https://github.com/homalg-project/CddInterface.git
  
-   The Gap/homalg-project package "Modules". You can install the package by cloning the "homalg_project" repository from
    
      https://github.com/homalg-project/homalg_project.git

-   You will also need "AutoDoc" package to be able to create the documentation and to perform tests. 
    A fresh version can be installed from
    
      https://github.com/gap-packages/AutoDoc.git

-   The Gap package "NormalizInterface". You can install it from
    
      https://github.com/gap-packages/NormalizInterface.git

-   In case "NormalizInterface" is not available, then you can use the Gap/homalg package
    "4ti2Interface". It is already included in the homalg-project 
  
      https://github.com/homalg-project/homalg_project
  
    Make sure to change accordingly the dependencies entry in PackageInfo.g.

Remarks
-------
-   To create the documentation go in your terminal to where you installed the package and 
 perform the command
   ```sh
   .../NConvex$ gap makedoc.g
   ```
-   To run tests:
   ```sh
   .../NConvex$ gap tst/testall.g
   ```
-   For the installation of Gap see https://www.gap-system.org/

-   You can create the documentation with diagrams if your latex installation has the required packages. To try it by un-commenting the required code by:
   
   ```sh
   .../NConvex$ sed -i 's/#?//g' makedoc.g
   ../examples$ sed -i 's/#&/#!/g' *.g
   .../NConvex$ gap makedoc.g
   ```

Of course you are welcome to e-mail me if there are any questions, remarks, suggestions ;)
  
  Kamal Saleh e-mail: saleh@mathematik.uni-siegen.de
  
License
-------

NConvex is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your opinion) any later version.

<!-- BEGIN FOOTER -->
---

### Dependencies

To obtain current versions of all dependencies, `git clone` (or `git pull` to update) the following repositories:

|    | Repository | git URL |
|--- | ---------- | ------- |
| 1. | [**homalg_project**](https://github.com/homalg-project/homalg_project#readme) | https://github.com/homalg-project/homalg_project.git |
| 2. | [**CddInterface**](https://github.com/homalg-project/CddInterface#readme) | https://github.com/homalg-project/CddInterface.git |

[html-img]: https://img.shields.io/badge/🔗%20HTML-stable-blue.svg
[html-url]: https://homalg-project.github.io/NConvex/doc/chap0_mj.html

[pdf-img]: https://img.shields.io/badge/🔗%20PDF-stable-blue.svg
[pdf-url]: https://homalg-project.github.io/NConvex/download_pdf.html

[version-img]: https://img.shields.io/endpoint?url=https://homalg-project.github.io/NConvex/badge_version.json&label=🔗%20version&color=yellow
[version-url]: https://homalg-project.github.io/NConvex/view_release.html

[date-img]: https://img.shields.io/endpoint?url=https://homalg-project.github.io/NConvex/badge_date.json&label=🔗%20released%20on&color=yellow
[date-url]: https://homalg-project.github.io/NConvex/view_release.html

[tests-img]: https://github.com/homalg-project/NConvex/workflows/Tests/badge.svg?branch=master
[tests-url]: https://github.com/homalg-project/NConvex/actions?query=workflow%3ATests+branch%3Amaster

[codecov-img]: https://codecov.io/gh/homalg-project/NConvex/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/homalg-project/NConvex

[code-img]: https://img.shields.io/badge/-View%20code-blue?logo=github
[code-url]: https://github.com/homalg-project/NConvex#top
<!-- END FOOTER -->
