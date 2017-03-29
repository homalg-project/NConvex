#############################################################################
##
##  Fan.gd         NConvex package                 Sebastian Gutsche
##                                                 Kamal Saleh
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
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
#! @InsertChunk fan1

#! @Arguments R, C
#! @Returns a fan object
#! @Description
#! The input is two lists, $R$ that indicates the rays and $C$
#! that indicates the cones. The output is the fan defined by the cones
#! $\{\mathrm{Cone}_i(\{ R_j, j\in C_i\} )\}_{C_i\in C}$.
DeclareOperation( "Fan",
                 [ IsList, IsList ] );
#! @InsertChunk fan2

DeclareOperation( "FanWithFixedRays",
                 [ IsList, IsList ] );

#! @EndSection

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
                  
DeclareAttribute( "RaysInTheGivenMaximalCones",
                  IsFan );
                  
DeclareAttribute( "GivenMaximalCones",
                  IsFan );
                  
DeclareAttribute( "MaximalCones",
                  IsFan );
                  
DeclareAttribute( "AllCones",
                  IsFan );
                  
DeclareAttribute( "FVector",
                  IsFan );
                  
DeclareAttribute( "Rays",
                  IsFan );

#################################
##
##  Properties
##
#################################

DeclareProperty( "IsItReallyFan",
                  IsFan );
                  
DeclareProperty( "IsComplete",
                   IsFan );
                   
DeclareProperty( "IsPointed",
                 IsFan );
                 
DeclareProperty( "IsSmooth",
                 IsFan );

DeclareProperty( "IsSimplicial",
                 IsFan );

DeclareProperty( "IsRegularFan",
                 IsFan );
                 
#################################
##
##    Operations on fans
##
#################################

DeclareOperation( "\*",
                 [ IsFan, IsFan ] );

DeclareOperation( "ToricStarFan",
                  [ IsFan, IsFan ] );

DeclareOperation( "CanonicalizeFan",
                  [ IsFan ] );
                  
DeclareOperation( "MaximalCones",
                  [ IsFan, IsInt ] );
                  
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
     