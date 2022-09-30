LoadPackage( "NConvex" );

#! @Chunk example3
#! @Example

P := Polyhedron( [ [ 1, 1 ], [ 4, 7 ] ], [ [ 1, -1 ], [ 1, 1 ] ] );
#! <A polyhedron in |R^2>
VerticesOfMainRatPolytope( P );
#! [ [ 1, 1 ], [ 4, 7 ] ]
VerticesOfMainPolytope( P );
#! [ [ 1, 1 ], [ 4, 7 ] ]
P := Polyhedron( [ [ 1/2, 1/2 ] ], [ [ 1, 1 ] ] );
#! <A polyhedron in |R^2>
VerticesOfMainRatPolytope( P );
#! [ [ 1/2, 1/2 ] ]
VerticesOfMainPolytope( P );
#! [ [ 1, 1 ] ]
LatticePointsGenerators( P );
#! [ [ [ 1, 1 ] ], [ [ 1, 1 ] ], [  ] ]
Dimension( P );
#! 1
Q := Polyhedron( [ [ 5, 0 ], [ 0, 6 ] ], [ [ 1, 2 ] , [ -1, -2 ] ] );
#! <A polyhedron in |R^2>
VerticesOfMainRatPolytope( Q );
#! [ [ 0, 6 ], [ 5, 0 ] ]
V := VerticesOfMainPolytope( Q );
#! [ [ 0, 6 ], [ 5, 0 ] ]

L := LatticePointsGenerators( Q );
#! [ [ [ 0, -10 ], [ 0, -9 ], [ 0, -8 ], [ 0, -7 ], [ 0, -6 ],
#! [ 0, -5 ], [ 0, -4 ], [ 0, -3 ], [ 0, -2 ], [ 0, -1 ],
#! [ 0, 0 ], [ 0, 1 ], [ 0, 2 ], [ 0, 3 ], [ 0, 4 ],
#! [ 0, 5 ], [ 0, 6 ] ], [  ], [ [ 1, 2 ] ] ]
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
#! @EndExample
#! @BeginLatexOnly
#! Let us now find out if the equation $-2+3x+4y-7z=0$ has integer solutions.
#! @EndLatexOnly
#! @Example
P := PolyhedronByInequalities( [ [ -2, 3, 4, -7 ], -[ -2, 3, 4, -7 ] ] );
#! <A polyhedron in |R^3 >
L := LatticePointsGenerators( P );
#! [ [ [ -4, 0, -2 ] ], [  ], [ [ 0, 7, 4 ], [ 1, 1, 1 ] ] ]
#! @EndExample
#! @BeginLatexOnly
#! So the solutions set is $\{ [ -4, 0, -2 ]+ t_1*[ 1, 1, 1 ] + t_2*[ 0, 7, 4 ]; t_1,t_2\in\mathbb{Z}\}$.
#! \newline
#! We know that $4x + 6y = 3$ does not have any solutions because $gcd(4,6)=2$ does not divide $3$.
#! @EndLatexOnly
#! @Example
Q := PolyhedronByInequalities( [ [-3, 4, 6 ], [ 3, -4, -6 ] ] );
#! <A polyhedron in |R^2 >
LatticePointsGenerators( Q );
#! [ [  ], [  ], [ [ 3, -2 ] ] ]
#! @EndExample
#! @BeginLatexOnly
#! Let us solve the folowing linear system
#! $$2x + 3y = 1\;\mathrm{mod}\;2$$
#! $$7x + \phantom{3}y = 3\;\mathrm{mod}\;5.$$
#! which is equivalent to the sytem
#! $$-1 + 2x + 3y           + 2u = 0$$
#! $$-3 + 7x + \phantom{3}y + 5v = 0$$
#! @EndLatexOnly
#! @Example
P := PolyhedronByInequalities( [ [ -1, 2, 3, 2, 0 ], [ -3, 7, 1, 0, 5 ],
      [ 1, -2, -3, -2, 0 ], [ 3, -7, -1, 0, -5 ] ] );
#! <A polyhedron in |R^4 >
L := LatticePointsGenerators( P );
#! [ [ [ -19, 1, 18, 27 ] ], [  ], [ [ 0, 10, -15, -2 ], [ 1, -2, 2, -1 ] ] ]
#! @EndExample
#! @BeginLatexOnly
#! I.e., the solutions set is 
#! $$\{[-19, 1] + t_1*[1, -2] + t_2*[ 0, 10]; t_1,t_2\in\mathbb{Z}\}$$
#! @EndLatexOnly
#! @EndChunk
