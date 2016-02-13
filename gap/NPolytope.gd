##############################################################################
##
##  Polytope.gd         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Cones for ConvexForHomalg.
##
#############################################################################


DeclareCategory( "IsPolytope",
                 IsConvexObject );

####################################
##
## Properties
##
####################################


DeclareProperty( "IsEmpty",
                 IsPolytope );


DeclareProperty( "IsNotEmpty",
                 IsPolytope );


DeclareProperty( "IsLatticePolytope",
                 IsPolytope );

DeclareProperty( "IsVeryAmple",
                 IsPolytope );


DeclareProperty( "IsNormalPolytope",
                 IsPolytope );


DeclareProperty( "IsSimplicial",
                 IsPolytope );


DeclareProperty( "IsSimplexPolytope",
                 IsPolytope );

DeclareProperty( "IsSimplePolytope",
                 IsPolytope );
                 
                 
DeclareProperty( "IsBounded",
                 IsPolytope );
                 
####################################
##
## Constructors
##
####################################

DeclareOperation( "Polytope",
                  [ IsList ] );
                  
DeclareOperation( "PolytopeByInequalities",
                  [ IsList ] );
                  
####################################
##
## Attributes
##
####################################

DeclareAttribute( "ExternalCddPolytope",
                    IsPolytope );
                    
DeclareAttribute( "LatticePoints",
                    IsPolytope );
DeclareAttribute( "RelativeInteriorLatticePoints",
                    IsPolytope );

DeclareAttribute( "LatticePointsGenerators",
                    IsPolytope );
  
DeclareAttribute( "VerticesOfPolytope",
                    IsPolytope );
                    
DeclareAttribute( "FacetInequalities",
                    IsPolytope );
                    
DeclareAttribute( "EqualitiesOfPolytope",
                    IsPolytope );

DeclareAttribute( "DefiningInequalities",
                    IsPolytope );
                    
DeclareAttribute( "VerticesInFacets",
                    IsPolytope );
                    
DeclareAttribute( "NormalFan",
                    IsPolytope );

DeclareAttribute( "AffineCone",
                    IsPolytope );

DeclareAttribute( "BabyPolytope",
                    IsPolytope );
                   
DeclareAttribute( "PolarPolytope",
                    IsPolytope );
                    
                    
    
                    
  
####################################
##
##  Operations
##
####################################


DeclareOperation( "Vertices",
                  [ IsPolytope ] );
                  
DeclareOperation( "HasVertices",
                  [ IsPolytope ] );

################################
##
## Methods
##
################################

DeclareOperation( "\*",
                  [ IsPolytope, IsPolytope ] );

DeclareOperation( "\*",
                  [ IsInt, IsPolytope ] );

DeclareOperation( "\*",
                  [ IsPolytope, IsInt ] );

DeclareOperation( "\+",
                  [ IsPolytope, IsPolytope ] );
                  
DeclareOperation( "IntersectionOfPolytopes",
                  [ IsPolytope, IsPolytope ] );
                  
DeclareOperation( "Points", 
                  [ IsList, IsList] );

DeclareOperation( "FourierProjection", 
                  [ IsPolytope, IsInt ] );
