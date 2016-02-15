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

##
InstallMethod( ContainingGrid,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
    if HasTailCone( polyhedron ) then
        
        return ContainingGrid( TailCone( polyhedron ) );
        
    elif HasMainPolytope( polyhedron ) then
        
        return ContainingGrid( MainPolytope( polyhedron ) );
        
    fi;
    
end );

##
InstallMethod( ExternalCddPolyhedron,
               "for polyhedrons",
               [ IsPolyhedron and HasMainPolytope and HasTailCone ],
               
  function( polyhedron )
    local verts, rays;
    
    verts := Vertices( MainPolytope( polyhedron ) );
    
    verts := List( verts, i -> Concatenation( [ 1 ], i ) );
    
    rays := RayGenerators( TailCone( polyhedron ) );
    
    rays := List( rays, i -> Concatenation( [ 0 ], i ) );
    
    polyhedron := Concatenation( rays, verts );
    
    polyhedron := Cdd_PolyhedronByGenerators( polyhedron );
    
    return polyhedron;
    
end );

##
InstallMethod( ExternalCddPolyhedron,
               "for polyhedrons",
               [ IsPolyhedron and HasHomogeneousPointsOfPolyhedron ],
               
  function( polyhedron )
    
    return Cdd_PolyhedronByGenerators( HomogeneousPointsOfPolyhedron( polyhedron ) );
    
end );

##
InstallMethod( ExternalCddPolyhedron,
               "for polyhedrons with inequalities",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
    if IsBound( polyhedron!.inequalities ) then
        
        if IsEmpty( polyhedron!.inequalities ) then
            
            polyhedron!.inequalities := [ [ 0 ] ];
            
        fi;
        
        return Cdd_PolyhedronByInequalities( polyhedron!.inequalities );
        
    fi;
    
    TryNextMethod();
    
end );

InstallMethod( MainPolytope, 
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
    if IsBound( polyhedron!.inequalities ) then 
    
        return Polytope( Cdd_GeneratingVertices( ExternalCddPolyhedron( polyhedron ) ) );

    else
      
        Error( "Something went wrong" );
        
    fi;
    
end );

##
InstallMethod( VerticesOfMainPolytope,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
    return Vertices( MainPolytope( polyhedron ) );
    
end );



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

##
InstallMethod( Polyhedron,
               "for a polytope and a cone",
               [ IsPolytope, IsCone ],
               
  function( polytope, cone )
    local polyhedron;
    
    if not Rank( ContainingGrid( polytope ) )= Rank( ContainingGrid( cone ) ) then
        
        Error( "Two objects are not comparable" );
        
    fi;
    
    polyhedron := rec();
    
    ObjectifyWithAttributes( polyhedron, TheTypeConvexPolyhedron,
                                          MainPolytope, polytope,
                                          TailCone, cone,
                                          ContainingGrid, ContainingGrid( polytope ),
                                          AmbientSpaceDimension, AmbientSpaceDimension( polytope )
                                        );
    
    return polyhedron;
    
end );

##
InstallMethod( Polyhedron,
               "for a polytope and a list",
               [ IsPolytope, IsList ],
               
  function( polytope, cone )
    local polyhedron;
    
    if Length( cone ) > 0 and Length( cone[ 1 ] ) <> AmbientSpaceDimension( polytope ) then
        
        Error( "the two objects are not comparable" );
        
    fi;
    
    polyhedron := rec( );
    
    ObjectifyWithAttributes( polyhedron, TheTypeConvexPolyhedron,
                                          MainPolytope, polytope,
                                          RayGeneratorsOfTailCone, cone,
                                          ContainingGrid, ContainingGrid( polytope ),
                                          AmbientSpaceDimension, AmbientSpaceDimension( polytope )
                                        );
    
    return polyhedron;
    
end );


##
InstallMethod( Polyhedron,
               "for a polytope and a cone",
               [ IsList, IsCone ],
               
  function( polytope, cone )
    local polyhedron;
    
    if Length( polytope ) > 0 and Length( polytope[ 1 ] ) <> AmbientSpaceDimension( cone ) then
        
        Error( "the two objects are not comparable" );
        
    fi;
    
    polytope := Polytope( polytope );
    
    SetContainingGrid( polytope, ContainingGrid( cone ) );
    
    polyhedron := rec( );
    
    ObjectifyWithAttributes( polyhedron, TheTypeConvexPolyhedron,
                                          MainPolytope, polytope,
                                          TailCone, cone,
                                          ContainingGrid, ContainingGrid( cone ),
                                          AmbientSpaceDimension, AmbientSpaceDimension( cone )
                                        );
    
    return polyhedron;
    
end );

##
InstallMethod( Polyhedron,
               "for a polytope and a cone",
               [ IsList, IsList ],
               
  function( polytope, cone )
    local polyhedron;
    
    if Length( polytope ) > 0 and Length( cone ) > 0 and Length( cone[ 1 ] ) <> Length( polytope[ 1 ] ) then
        
        Error( "two objects are not comparable\n" );
        
    fi;
    
    if Length( polytope ) = 0 then
        
        Error( "no empty polytope" );
        
    fi;
    
    if Length( cone ) = 0 then
        
        cone := [ List( [ 1 .. Length( polytope[ 1 ] ) ], i -> 0 ) ];
        
    fi;
    
    polyhedron := rec();
    
    ObjectifyWithAttributes( polyhedron, TheTypeConvexPolyhedron,
                                          MainPolytope, Polytope( polytope ),
                                          TailCone, Cone( cone ),
                                          AmbientSpaceDimension, Length( polytope[ 1 ] ) 
                                        );
    
    SetContainingGrid( TailCone( polyhedron ), ContainingGrid( MainPolytope( polyhedron ) ) );
    
    SetContainingGrid( polyhedron, ContainingGrid( MainPolytope( polyhedron ) ) );
    
    return polyhedron;
    
end );


##############################
##
## View & Display
##
##############################

##
InstallMethod( ViewObj,
               "for homalg polytopes",
               [ IsPolyhedron ],
               
  function( polytope )
    local str;
    
    Print( "<A" );
    
    if HasIsNotEmpty( polytope ) then
        
        if IsNotEmpty( polytope ) then
            
            Print( " not empty" );
            
        fi;
    
    fi;
    
    Print( " polyhedron in |R^" );
    
    Print( String( AmbientSpaceDimension( polytope ) ) );
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for homalg polytopes",
               [ IsPolyhedron ],
               
  function( polytope )
    local str;
    
    Print( "A" );
    
    if HasIsNotEmpty( polytope ) then
        
        if IsNotEmpty( polytope ) then
            
            Print( " not empty" );
            
        fi;
    
    fi;
    
    Print( " polyhedron in |R^" );
    
    Print( String( AmbientSpaceDimension( polytope ) ) );
    
    Print( ".\n" );
    
end );
