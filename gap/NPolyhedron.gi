#############################################################################
##
##  Polyhedron.gi         Convex package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Polyhedrons for Convex.
##
#############################################################################

DeclareRepresentation( "IsConvexPolyhedronRep",
                       IsPolyhedron and IsExternalConvexObjectRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfPolyhedrons",
        NewFamily( "TheFamilyOfPolyhedrons" , IsPolyhedron ) );

BindGlobal( "TheTypeConvexPolyhedron",
        NewType( TheFamilyOfPolyhedrons,
                 IsPolyhedron and IsConvexPolyhedronRep ) );
                 
                 
#####################################
##
## Structural Elements
##
#####################################


#####################################
##
## Constructors
##
#####################################

##
InstallMethod( PolyhedronByInequalities,
               "for list of inequalities",
               [ IsList ],
               
  function( inequalities )
    local polyhedron;
    
    polyhedron := rec();
    
    ObjectifyWithAttributes( polyhedron, TheTypeConvexPolyhedron );
    
    polyhedron!.inequalities := inequalities;
    
    if not IsEmpty( inequalities ) then
        
        SetAmbientSpaceDimension( polyhedron, Length( inequalities[ 1 ] ) - 1 );
        
    else
        
        SetAmbientSpaceDimension( polyhedron, 0 );
    fi;
    
    return polyhedron;
    
end );



