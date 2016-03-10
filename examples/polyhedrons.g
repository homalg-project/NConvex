LoadPackage( "NC" );


##############################################################
##
##  Polyhedron  Conv( [1,1], [4,7] ) + nonneq( [1,-1], [1,1] )
##
##############################################################

P:= Polyhedron( [ [ 1, 1 ], [ 4, 7 ] ], [ [ 1, -1 ], [ 1, 1 ] ] );
#! <A polyhedron in |R^2>
VerticesOfMainRatPolytope( P );
#! [ [ 1, 1 ], [ 4, 7 ] ]
VerticesOfMainPolytope( P );
#! [ [ 1, 1 ], [ 4, 7 ] ]

##############################################################
##
##  Polyhedron  Conv( [1/2,1/2] ) + nonneq( [1,1] )
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
 
