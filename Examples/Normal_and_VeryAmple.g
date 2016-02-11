LoadPackage( "NC" );


#######################################################
##
## Example of a not very ample( and thus not normal ) polytope.
##
#######################################################
P:= Polytope( [ [ 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ], [ 1, 1, 2 ] ] );
# <A polytope in |R^3>
IsNormalPolytope( P );
# false
IsVeryAmple( P );
# false

#######################################################
##
## Example of a normal( and thus very ample ) polytope.
##
#######################################################
Q:= Polytope( [ [ 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ], [ 1, 1, 1 ] ] );
# <A polytope in |R^3>
IsNormalPolytope( Q );
# true
IsVeryAmple( Q );
# true
Q;
# <A normal very ample polytope in |R^3>

#######################################################
##
## Examples of a very ample but not normal polytope.
##
#######################################################

## Example from "Normality and Minkowski sum of Lattice Polytopes, Shoetsu Ogata"
T:= Polytope( [ [ 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ], [ 1, 1, 4 ] ] ); 
# <A polytope in |R^3>
I:= Polytope( [ [ 0, 0, 0 ], [ 0, 0, 1 ] ] );
# <A polytope in |R^3>
J:= T + I; 
# <A polytope in |R^3>
IsVeryAmple( J );
# true
IsNormalPolytope( J );
# false
J;
# <A very ample polytope in |R^3>


## Example 2.2.20 Cox, Toric Varieties
A:= [ [1,1,1,0,0,0], [1,1,0,1,0,0], [1,0,1,0,1,0], [ 1,0,0,1,0,1], [ 1,0,0,0,1,1], [ 0,1,1,0,0,1], [0,1,0,1,1,0], [0,1,0,0,1,1], [0,0,1,1,1,0], [0,0,1,1,0,1] ];
# [ [ 1, 1, 1, 0, 0, 0 ], [ 1, 1, 0, 1, 0, 0 ], [ 1, 0, 1, 0, 1, 0 ], [ 1, 0, 0, 1, 0, 1 ], [ 1, 0, 0, 0, 1, 1 ], [ 0, 1, 1, 0, 0, 1 ], 
#   [ 0, 1, 0, 1, 1, 0 ], [ 0, 1, 0, 0, 1, 1 ], [ 0, 0, 1, 1, 1, 0 ], [ 0, 0, 1, 1, 0, 1 ] ]
H:= Polytope( A );
# <A polytope in |R^6>
IsVeryAmple( H );   
# true
IsNormalPolytope( H );
# false
H;
# <A very ample polytope in |R^6>
