#############################################################################
##
##  Fan.gd         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Fans for ConvexForHomalg.
##
#############################################################################


##
DeclareCategory( "IsFan",
                 IsConvexObject );

DeclareOperation( "Fan",
                 [ IsFan ] );

DeclareOperation( "Fan",
                 [ IsList ] );

DeclareOperation( "Fan",
                 [ IsList, IsList ] );
                 
DeclareOperation( "FanWithFixedRays",
                 [ IsList, IsList ] );
                 
                 
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
     