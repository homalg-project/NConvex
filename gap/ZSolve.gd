

# to solve the system

#  3x+5y=8
#  4x-2y>=2
#   3x+y>=3
# --> SolveEqualitiesAndInequalitiesOverIntergers( [ [3,5] ], [ 8 ], [ [4,-2], [3,1] ], [2,3] );
#
# to get only solution where y is positive then add a 5'th argument for signs: 0 stands for free, 1 stands for positive
# --> SolveEqualitiesAndInequalitiesOverIntergers( [ [3,5] ], [ 8 ], [ [4,-2], [3,1] ], [2,3], [0,1] );

DeclareGlobalFunction( "SolveEqualitiesAndInequalitiesOverIntergers" );

