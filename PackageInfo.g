#
# NConvex: new version of the Package Convex
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "NConvex",
Subtitle := "A Gap package to perform polyhedral computations",
Version := "2019.12.04",
Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Kamal",
    LastName := "Saleh",
    WWWHome := "https://github.com/kamalsaleh",
    Email := "kamal.saleh@uni-siegen.de",
    PostalAddress := Concatenation(
               "Department Mathematik\n",
               "Universität Siegen\n",
               "Walter-Flex-Straße 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
  
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "https://sebasguts.github.io/",
    Email := "gutsche@mathematik.uni-siegen.de",
    PostalAddress := Concatenation(
               "Department Mathematik\n",
               "Universität Siegen\n",
               "Walter-Flex-Straße 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  )
],

PackageWWWHome := "https://homalg-project.github.io/NConvex",

SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/NConvex" ),

IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
ArchiveURL     := Concatenation( ~.SourceRepository.URL, "/archive/", ~.Version ),
README_URL     := Concatenation( ~.SourceRepository.URL, "/releases/latest/download/README.md" ),
PackageInfoURL := Concatenation( ~.SourceRepository.URL, "/releases/latest/download/PackageInfo.g" ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML :=
  "The <span class='pkgname'>NConvex</span> package is a GAP package. \
  Its aim is to carry out polyhedral constructions and computations,\
  namely computing properties and attributes of cones, polyhedrons, polytopes and fans.",

PackageDoc := rec(
  BookName  := "NConvex",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A Gap package to perform polyhedral computations",
),

Dependencies := rec(
  GAP := ">= 4.9",
  NeededOtherPackages := [ [ "AutoDoc", ">= 2018.02.14" ],
                           [ "Modules", ">= 0.5" ], 
                           [ "CddInterface", ">= 2019.12.04" ],
                           [ "NormalizInterface", ">= 1.1.0"  ]
                         ],
  SuggestedOtherPackages := [ [ "4ti2Interface", ">= 2018.07.06" ],
                              [ "TopcomInterface", ">=2019.06.15" ] ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
  
  return true;

end,

TestFile := "tst/testall.g",

Keywords := [ "Cone", "Fan", "Polytope", "Polyhedron", "ToricVarieties", "homalg" ],

));


