#
# NConvex: new version of the Package Convex
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "NConvex" );
dirs := DirectoriesPackageLibrary( "NConvex", "tst" );
TestDirectory( dirs, rec( exitGAP := true, testOptions:= rec(compareFunction:="uptowhitespace" ) ) );
FORCE_QUIT_GAP(1);
