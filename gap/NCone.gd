#############################################################################
##
##  Cone.gd         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Cones for ConvexForHomalg.
##
#############################################################################


DeclareCategory( "IsCone",
                 IsFan );
                 
                 
##############################
##
##  Constructors
##
##############################

DeclareOperation( "ConeByInequalities",
                  [ IsList ] );
                  
DeclareOperation( "ConeByEqualitiesAndInequalities",
                  [ IsList, IsList ] );
                  
DeclareOperation( "ConeByGenerators",
                  [ IsList ] );
                  
DeclareOperation( "Cone",
                  [ IsList ] );
                  
DeclareOperation( "Cone",
                  [ IsCddPolyhedron ] );
                  
##############################
##
##  Properties
##
##############################

DeclareProperty( "IsRegularCone", IsCone );

DeclareProperty( "IsEmptyCone", IsCone );

DeclareProperty( "HasConvexSupport", IsCone );

DeclareProperty( "IsRay", IsCone );

DeclareAttribute( "IsContainedInFan",
                  IsCone );
##############################
##
##  Attributes 
##
##############################

# DeclareAttribute( "RayGenerators", 
#                    IsCone );

DeclareAttribute( "DefiningInequalities", 
                   IsCone );

DeclareAttribute( "FactorConeEmbedding",
                   IsCone );
                  
DeclareAttribute( "EqualitiesOfCone", 
                   IsCone );
                   
DeclareAttribute( "DualCone",
                  IsCone );

DeclareAttribute( "RaysInFacets",
                  IsCone );
                  
DeclareAttribute( "RaysInFaces",
                  IsCone );
                  
DeclareAttribute( "Facets",
                  IsCone );
                  
DeclareAttribute( "Faces",
                  IsCone );
                    
# DeclareAttribute( "FVector",
#                   IsCone );

                  
DeclareAttribute( "RelativeInteriorRayGenerator", 
                   IsCone );

DeclareAttribute( "HilbertBasis", IsCone );

DeclareAttribute( "HilbertBasisOfDualCone",
                  IsCone );
                  
DeclareAttribute( "LinearSubspaceGenerators", IsCone );

DeclareAttribute( "LinealitySpaceGenerators", IsCone );

# AmbientSpace is somewhere declared !!
# DeclareAttribute( "AmbientSpaceDimension", IsCone );

##############################
##
##  Methods
##
##############################
DeclareOperation( "IntersectionOfCones",
                  [ IsCone, IsCone ] );
                  
DeclareOperation( "Intersect2",
                  [ IsCone, IsCone ] );
                  
DeclareOperation( "Contains",
                  [ IsCone, IsCone ] );

DeclareOperation( "RayGeneratorContainedInCone",
                  [ IsList, IsCone ] );

DeclareOperation( "RayGeneratorContainedInRelativeInterior",
                  [ IsList, IsCone ] );
                  
DeclareOperation( "IntersectionOfConelist",
                  [ IsList ] );

DeclareOperation( "ExternalCddCone", [ IsCone ] );

DeclareOperation( "ExternalNmzCone", [ IsCone ] );

# DeclareOperation( "\*",
#                    [ IsCone, IsCone ] );
                   
DeclareOperation( "\*",
                  [ IsHomalgMatrix, IsCone ] );

DeclareOperation( "NonReducedInequalities",
                  [ IsCone ] );
