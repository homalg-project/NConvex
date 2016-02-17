LoadPackage( "NC" );


##############################################################
##
##  Polyhedron  Conv( [1,1], [4,7] ) + nonneq( [1,-1], [1,1] )
##
##############################################################

P:= Polyhedron( [ [ 1, 1 ], [ 4, 7 ] ], [ [ 1, -1 ], [ 1, 1 ] ] );
# <A polyhedron in |R^2>
M:= MainPolytope( P );
# <A polytope in |R^2>
Vertices( M );
# [ [ 1, 1 ], [ 4, 7 ] ]
T:= TailCone( P );
# <A cone in |R^2>
RayGenerators( T );
# [ [ 1, -1 ], [ 1, 1 ] ]
d:= DefiningInequalities( P );
# [ [ -2, 1, 1 ], [ 1, 0, 0 ], [ 3, 1, -1 ], [ -1, 2, -1 ] ]
Q:= PolyhedronByInequalities( d );
# <A polyhedron in |R^2>
VerticesOfMainPolytope( Q );
# [ [ 1, 1 ], [ 4, 7 ] ]
RayGeneratorsOfTailCone( Q ); 
# [ [ 1, -1 ], [ 1, 1 ] ]
 