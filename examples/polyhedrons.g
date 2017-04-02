LoadPackage( "NC" );

#! @Chunk example3
#! @Example

P:= Polyhedron( [ [ 1, 1 ], [ 4, 7 ] ], [ [ 1, -1 ], [ 1, 1 ] ] );
#! <A polyhedron in |R^2>
VerticesOfMainRatPolytope( P );
#! [ [ 1, 1 ], [ 4, 7 ] ]
VerticesOfMainPolytope( P );
#! [ [ 1, 1 ], [ 4, 7 ] ]
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
Q:= Polyhedron( [ [ 5, 0 ], [ 0, 6 ] ], [ [ 1, 2 ] , [ -1, -2 ] ] );
#! <A polyhedron in |R^2>
VerticesOfMainRatPolytope( Q );
#! [ [ 0, 6 ], [ 5, 0 ] ]
#e
VerticesOfMainPolytope( Q );
#! [ [ 0, -10 ], [ 0, 6 ] ]
#e
LatticePointsGenerators( Q );
#! [ [ [ 0, -10 ], [ 0, -9 ], [ 0, -8 ], [ 0, -7 ], [ 0, -6 ], 
#!       [ 0, -5 ], [ 0, -4 ], [ 0, -3 ], [ 0, -2 ], [ 0, -1 ], 
#!      [ 0, 0 ], [ 0, 1 ], [ 0, 2 ], [ 0, 3 ], [ 0, 4 ], [ 0, 5 ], 
#!      [ 0, 6 ] ], [  ], [ [ 1, 2 ] ] ]
#e
LatticePoints( MainPolytope( Q ) );
#! [ [ 0, -10 ], [ 0, -9 ], [ 0, -8 ], [ 0, -7 ], [ 0, -6 ], [ 0, -5 ], 
#!  [ 0, -4 ], [ 0, -3 ], [ 0, -2 ], [ 0, -1 ], [ 0, 0 ], [ 0, 1 ], 
#!  [ 0, 2 ], [ 0, 3 ], [ 0, 4 ], [ 0, 5 ], [ 0, 6 ] ]
Dimension( Q );
#! 2
RayGeneratorsOfTailCone( Q );
#! [ [ -1, -2 ], [ 1, 2 ] ]
BasisOfLinealitySpace( Q );
#! [ [ 1, 2 ] ]
DefiningInequalities( Q );
#! [ [ 6, 2, -1 ], [ 10, -2, 1 ] ]
Q;
#! <A polyhedron in |R^2 of dimension 2>
P:= PolyhedronByInequalities( [ [ -2, 3, 4, -7 ], -[ -2, 3, 4, -7 ] ] );
#! <A polyhedron in |R^3 >
#e
LatticePointsGenerators( P );
#! [ [ [ -4, 0, -2 ] ], [  ], [ [ 1, 1, 1 ], [ 0, 7, 4 ] ] ]
Q:= PolyhedronByInequalities( [ [-3, 4, 6 ], [ 3, -4, -6 ] ] );
#! <A polyhedron in |R^2 >
LatticePointsGenerators( Q );
#! [ [  ], [  ], [ [ 3, -2 ] ] ]
P:= PolyhedronByInequalities( [ [ -3, 2, 3, 2, 0 ], [ -3, 7, 1, 0, 5 ], 
-[ -3, 2, 3, 2, 0 ], -[ -3, 7, 1, 0, 5 ] ] );
#! <A polyhedron in |R^4 >
#e
LatticePointsGenerators( P );
#! [ [ [ -291, 15, 270, 405 ] ], [  ], [ [ 1, -2, 2, -1 ], [ 0, 10, -15, -2 ] ] ]
#! @EndExample
#! @EndChunk
