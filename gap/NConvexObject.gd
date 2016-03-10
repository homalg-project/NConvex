#############################################################################
##
##  ConvexObject.gd              NConvex package       Sebastian Gutsche
##                                                     Kamal Saleh
##
##  Copyright 2011-2012 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Main Object to be viewed, is almost everything that has a number ;).
##
#############################################################################

DeclareCategory( "IsConvexObject", 
                 IsObject );


DeclareRepresentation( "IsExternalConvexObjectRep",
                      IsConvexObject and IsAttributeStoringRep,
                      [ ]
                     );

DeclareRepresentation( "IsInternalConvexObjectRep",
                      IsConvexObject and IsAttributeStoringRep,
                      [ ]
                     );


##############################
##
## Attributes
##
##############################

##
DeclareAttribute( "AmbientSpaceDimension",
                  IsConvexObject );
                  
                  
DeclareAttribute( "ContainingGrid",
                  IsConvexObject );

DeclareAttribute( "Dimension",
                  IsConvexObject );
                  
DeclareProperty( "IsFullDimensional",
                 IsConvexObject );