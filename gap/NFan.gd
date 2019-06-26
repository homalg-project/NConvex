#############################################################################
##
##  NFan.gd         NConvex package                 Sebastian Gutsche
##                                                  Kamal Saleh
##
##  Copyright 2019 Mathematics Faculty, Siegen University, Germany
##
##  Fans for NConvex package.
##
#############################################################################

#! @Chapter Fans
#! @Section Constructors
#! 

##
DeclareCategory( "IsFan",
                 IsConvexObject );

#! @Arguments F
#! @Returns a fan object
#! @Description
#! If the input <A>F</A> is fan then return <A>F</A>.
DeclareOperation( "Fan",
                 [ IsFan ] );

#! @Arguments C
#! @Returns a fan object
#! @Description
#! The input is a list of list $C$. the output is the fan defined by the cones 
#! $\{\mathrm{Cone}_i(C_i )\}_{C_i\in C}$.
DeclareOperation( "Fan",
                 [ IsList ] );

#! @Arguments R, C
#! @Returns a fan object
#! @Description
#! The input is two lists, $R$ that indicates the rays and $C$
#! that indicates the cones. The output is the fan defined by the cones
#! $\{\mathrm{Cone}_i(\{ R_j, j\in C_i\} )\}_{C_i\in C}$.
DeclareOperation( "Fan",
                 [ IsList, IsList ] );
#! @InsertChunk fan1
#! @InsertChunk fan2


DeclareOperation( "FanWithFixedRays",
                 [ IsList, IsList ] );

DeclareOperation( "DeriveFansFromTriangulation",
                 [ IsList, IsBool ] );

#! @Arguments R
#! @Returns a list of fans
#! @Description
#! The input is a list of ray generators $R$. Provided that the package
#! TopcomInterface is available, this function computes the list of all
#! fine and regular triangulations of these ray generators. It then returns
#! the list of the associated fans of these triangulations.
DeclareOperation( "FansFromTriangulation",
                 [ IsList ] );

#! @Arguments R
#! @Returns a fan
#! @Description
#! The input is a list of ray generators $R$. Provided that the package
#! TopcomInterface is available, this function computes a
#! fine and regular triangulation of these ray generators and returns
#! the associated fan.
DeclareOperation( "FanFromTriangulation",
                 [ IsList ] );

#! @InsertChunk fan3

##################################
##
##  Attributes
##
##################################
                 
DeclareAttribute( "RayGenerators",
                    IsFan );
                    
DeclareAttribute( "GivenRayGenerators",
                    IsFan );                    
                    
DeclareAttribute( "RaysInMaximalCones",
                  IsFan );

DeclareAttribute( "RaysInAllCones", 
                  IsFan );

DeclareAttribute( "AllCones",
                  IsFan );

DeclareAttribute( "RaysInTheGivenMaximalCones",
                  IsFan );

DeclareAttribute( "GivenMaximalCones",
                  IsFan );

DeclareAttribute( "MaximalCones",
                  IsFan );

DeclareAttribute( "FVector",
                  IsFan );
                  
DeclareAttribute( "Rays",
                  IsFan );

DeclareAttribute( "PrimitiveCollections",
                  IsFan );

#################################
##
##  Properties
##
#################################

DeclareProperty( "IsWellDefinedFan",
                  IsFan );

DeclareProperty( "IsComplete",
                   IsFan );

DeclareProperty( "IsPointed",
                 IsFan );

DeclareProperty( "IsSmooth",
                 IsFan );

DeclareProperty( "IsSimplicial",
                 IsFan );

# The name IsNormal is taken in gap.
DeclareProperty( "IsNormalFan",
                 IsFan );

# Synonyme to is normal fan
DeclareProperty( "IsRegularFan",
                 IsFan );

DeclareProperty( "IsFanoFan",
                 IsFan );

#################################
##
##    Operations on fans
##
#################################

#! @Chapter Fans
#! @Section Operations on fans
#! 

DeclareOperation( "\*",
                 [ IsFan, IsFan ] );

DeclareOperation( "ToricStarFan",
                  [ IsFan, IsFan ] );

DeclareOperation( "CanonicalizeFan",
                  [ IsFan ] );
                  
DeclareOperation( "MaximalCones",
                  [ IsFan, IsInt ] );

#! @InsertChunk fan4

#################################
##
## some extra operations
##
################################

DeclareOperation( "FirstLessTheSecond",
                   [ IsList, IsList] );
                   

DeclareOperation( "OneMaximalConeInList",
                   [ IsList] );
                   
DeclareOperation( "ListOfMaximalConesInList",
                   [ IsList] );
