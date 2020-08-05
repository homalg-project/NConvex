#
# NConvex: new version of the Package Convex
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "NConvex" );
dirs := DirectoriesPackageLibrary( "NConvex", "tst" );

# Until the issue https://github.com/homalg-project/NConvex/issues/5 has been solved
ex := [];
if CompareVersionNumbers( GAPInfo.Version, "4.10.0" ) and IsPackageLoaded( "majoranaalgebras" ) then
  ex := [ "nconvex02.tst" ];
fi;

TestDirectory( dirs, rec( exitGAP := true, testOptions:= rec(compareFunction:="uptowhitespace" ), exclude := ex ) );
FORCE_QUIT_GAP(1);
