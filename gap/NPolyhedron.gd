#############################################################################
##
##  Polyhedron.gd         Convex package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Polyhedrons for Convex.
##
#############################################################################

DeclareCategory( "IsPolyhedron",
                 IsConvexObject );
                 

                 
                 
#####################################
##
## Constructors
##
#####################################

DeclareOperation( "PolyhedronByInequalities",
                  [ IsList ] );
