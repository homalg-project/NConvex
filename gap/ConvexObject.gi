






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
