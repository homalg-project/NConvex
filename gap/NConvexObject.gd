#############################################################################
##
##  NConvexObject.gd         NConvex package        Sebastian Gutsche
##                                                  Kamal Saleh
##
##  Copyright 2019 Mathematics Faculty, Siegen University, Germany
##
##  Fans for NConvex package.
##
#############################################################################


# This field will be used whenever a rationals field is needed in the package.
DeclareGlobalVariable( "HOMALG_RATIONALS" );
InstallValue( HOMALG_RATIONALS, HomalgFieldOfRationals(  ) );

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

#! @Chapter Convex objects
#! @Section Attributes

##
#! @Arguments obj 
#! @Returns integer
#! @Description  
#! Returns the dimension of the ambient space, i.e., the space that contains the convex object.
DeclareAttribute( "AmbientSpaceDimension",
                  IsConvexObject );
                  
                  
DeclareAttribute( "ContainingGrid",
                  IsConvexObject );

#! @Arguments obj 
#! @Returns integer
#! @Description  
#! Returns the dimension of the covex object.
DeclareAttribute( "Dimension",
                  IsConvexObject );

#! @Arguments obj 
#! @Returns boolian
#! @Description  
#! Returns whether the convex object is full dimensional or not.
DeclareProperty( "IsFullDimensional",
                 IsConvexObject );

#! @Arguments obj
#! @Returns a point in the object
#! @Description  
#! Returns an interior point of the covex object.
DeclareAttribute( "InteriorPoint", IsConvexObject );
