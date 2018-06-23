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
Subtitle := "new version of the Package Convex",
Version := "2017.01.02",
Date := "02/01/2017", # dd/mm/yyyy format

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := false,
    FirstNames := "Kamal",
    LastName := "Saleh",
    WWWHome := "To Do",
    Email := "To Do",
    PostalAddress := "Templergraben ",
    Place := "Aachen",
    Institution := "lehrstuhl B Algebra",
  ),
  
  rec(
    IsAuthor := true,
    IsMaintainer := false,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "To Do",
    Email := "To Do",
    PostalAddress := "Templergraben ",
    Place := "Aachen",
    Institution := "lehrstuhl B Algebra",
  )
],

PackageWWWHome := "http://TODO/",

ArchiveURL     := Concatenation( ~.PackageWWWHome, "NConvex-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

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

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "NConvex",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "new version of the Package Convex",
),

Dependencies := rec(
  GAP := ">= 4.6",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                           [ "Modules", ">=0.5" ],
                           [ "NormalizInterface", ">=0.3"],
                           [ "CddInterface", ">= 2018.06.15" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));


