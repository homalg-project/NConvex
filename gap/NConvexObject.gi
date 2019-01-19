#############################################################################
##
##  NConvexObject.gi         NConvex package        Sebastian Gutsche
##                                                  Kamal Saleh
##
##  Copyright 2019 Mathematics Faculty, Siegen University, Germany
##
##  Fans for NConvex package.
##
#############################################################################


################################
##
## Attributes
##
################################

##
InstallMethod( ContainingGrid,
               " for convex objects",
               [ IsConvexObject ],
               
  function( convobj )
    
    return AmbientSpaceDimension( convobj ) * HOMALG_MATRICES.ZZ;
    
end );