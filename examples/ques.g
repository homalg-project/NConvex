problem 1

# in Convex

Q:= PolyhedronByInequalities( [ [ 1, -2, 2 ], [ -1, 2, 2 ], [ 1, 2, -2 ] ];
VerticesOfMainPolytope( Q );
# [ [ 1, 1 ] ]

#in NConvex
Q:= PolyhedronByInequalities( [ [ 1, -2, 2 ], [ -1, 2, 2 ], [ 1, 2, -2 ] ];
VerticesOfMainPolytope( Q );
# [ [ 1/2, 0 ], [ 0, 1/2 ] ]