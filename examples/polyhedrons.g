LoadPackage( "NC" );


################################################################
##
##  Polyhedron  Conv( [ 1, 1 ], [ 4, 7 ] ) + nonneq( [ 1, -1 ], [ 1, 1 ] )
##
################################################################

P:= Polyhedron( [ [ 1, 1 ], [ 4, 7 ] ], [ [ 1, -1 ], [ 1, 1 ] ] );
#! <A polyhedron in |R^2>
VerticesOfMainRatPolytope( P );
#! [ [ 1, 1 ], [ 4, 7 ] ]
VerticesOfMainPolytope( P );
#! [ [ 1, 1 ], [ 4, 7 ] ]

##############################################################
##
##  Polyhedron  Conv( [ 1/2, 1/2 ] ) + nonneq( [ 1, 1 ] )
##
##############################################################

P:= Polyhedron( [ [ 1/2, 1/2 ] ], [ [ 1, 1 ] ] );                     
#! <A polyhedron in |R^2>
VerticesOfMainRatPolytope( P );
#! [ [ 1/2, 1/2 ] ]
VerticesOfMainPolytope( P );
#! [ [ 1, 1 ] ]
LatticePointsGenerators( P );
#! [ [ [ 1, 1 ] ], [ [ 1, 1 ] ], [  ] ]
Dimension( P );
#! 1

###########################################################################
##
##  Polyhedron  Conv( [ 5, 0 ], [ 0, 6 ] ) + nonneq( [ 1, 2 ], [ -1, -2 ] )
##
###########################################################################

Q:= Polyhedron( [ [ 5, 0 ], [ 0, 6 ] ], [ [ 1, 2 ] , [ -1, -2 ] ] );
#! <A polyhedron in |R^2>
VerticesOfMainRatPolytope( Q );
#! [ [ 5, 0 ], [ 0, 6 ] ]
VerticesOfMainPolytope( Q );
#! [ [ 5, 0 ], [ 4, -1 ], [ 0, 3 ], [ 0, 6 ] ]
LatticePointsGenerators( Q );
#! [ [ [ 5, 0 ], [ 4, -1 ], [ 4, 0 ], [ 4, 1 ], [ 3, 0 ], [ 3, 1 ], [ 3, 2 ], [ 2, 1 ], [ 2, 2 ], [ 2, 3 ], [ 1, 2 ], [ 1, 3 ], [ 1, 4 ], 
#!       [ 0, 3 ], [ 0, 4 ], [ 0, 5 ], [ 0, 6 ] ], [  ], [ [ 1, 2 ] ] ]
LatticePoints( MainPolytope( Q ) );
#! [ [ 0, 3 ], [ 0, 4 ], [ 0, 5 ], [ 0, 6 ], [ 1, 2 ], [ 1, 3 ], [ 1, 4 ], [ 2, 1 ], [ 2, 2 ], [ 2, 3 ], [ 3, 0 ], [ 3, 1 ], [ 3, 2 ], 
#!   [ 4, -1 ], [ 4, 0 ], [ 4, 1 ], [ 5, 0 ] ]
Dimension( Q );
#! 2
RayGeneratorsOfTailCone( Q );
#! [ [ 1, 2 ], [ -1, -2 ] ]
BasisOfLinealitySpace( Q );   
#! [ [ 1, 2 ] ]
DefiningInequalities( Q );
#! [ [ 10, -2, 1 ], [ 6, 2, -1 ] ]
Q;
#! <A polyhedron in |R^2>

############################################################################
##
## Find if the equation have integer solutions 3x + 4y - 7z = 2
##
############################################################################

P:= PolyhedronByInequalities( [ [ -2, 3, 4, -7 ], -[ -2, 3, 4, -7 ] ] );
#! <A polyhedron in |R^3 >
LatticePointsGenerators( P );
#! [ [ [ -2, 2, 0 ] ], [  ], [ [ 1, 1, 1 ], [ -4, 3, 0 ] ] ]

## So the solutions set is { [ -2, 2, 0 ]+  t_1*[ 1, 1, 1 ] + t_2*[ -4, 3, 0 ] }
## with t_i integer for all i's.

##########################################################################################
##
## We know that 4x + 6y = 3 does not have any solutions since gcd(4,6)=2 does not divide 3
##
##########################################################################################

Q:= PolyhedronByInequalities( [ [-3, 4, 6 ], [ 3, -4, -6 ] ] );
#! <A polyhedron in |R^2 >
LatticePointsGenerators( Q );
#! The given polyhedron does not contain integer points
#! [ [  ], [  ], [  ] ]

##############################################################################
##   Example of solving system of linear congruences
##
##   2x + 3y = 3 mod 2
##   7x +  y = 3 mod 5
##
##############################################################################

# 2x + 3y + 2z + 0t = 3
# 7x +  y + 0z + 5t = 3                           
P:= PolyhedronByInequalities( [ [ -3, 2, 3, 2, 0 ], [ -3, 7, 1, 0, 5 ], -[ -3, 2, 3, 2, 0 ], -[ -3, 7, 1, 0, 5 ] ] );
#! <A polyhedron in |R^4 >
LatticePointsGenerators( P );
#! [ [ [ -6, 5, 0, 8 ] ], [  ], [ [ -1, 2, -2, 1 ], [ -5, 0, 5, 7 ] ] ]

