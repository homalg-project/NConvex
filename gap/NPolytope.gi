#############################################################################
##
##  Polytope.gi         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Cones for ConvexForHomalg.
##
#############################################################################

####################################
##
## Reps
##
####################################

DeclareRepresentation( "IsExternalPolytopeRep",
                       IsPolytope and IsExternalConvexObjectRep,
                       [ ]
                      );

DeclareRepresentation( "IsConvexPolytopeRep",
                       IsExternalPolytopeRep,
                       [ ]
                      );

DeclareRepresentation( "IsInternalPolytopeRep",
                       IsPolytope and IsInternalConvexObjectRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfPolytopes",
        NewFamily( "TheFamilyOfPolytopes" , IsPolytope ) );

BindGlobal( "TheTypeExternalPolytope",
        NewType( TheFamilyOfPolytopes,
                 IsPolytope and IsExternalPolytopeRep ) );

BindGlobal( "TheTypeConvexPolytope",
        NewType( TheFamilyOfPolytopes,
                 IsConvexPolytopeRep ) );

BindGlobal( "TheTypeInternalPolytope",
        NewType( TheFamilyOfPolytopes,
                 IsInternalPolytopeRep ) );
                 
####################################
##
## Attribute
##
####################################

##
InstallMethod( ExternalCddPolytope, 
               "for polytopes", 
               [ IsPolytope ],
               
   function( polyt )
   local pointlist, ineqs, i;
   
   if IsBound( polyt!.input_points ) and IsBound( polyt!.input_ineqs ) then
        
        Error( "points and inequalities at the same time are not supported\n" );
        
   fi;
    
   if IsBound( polyt!.input_points ) then 
   
       pointlist := ShallowCopy( polyt!.input_points );
       
       for i in pointlist do 
        
           Add( i, 1, 1 );
           
       od;
           
       return Cdd_PolyhedronByGenerators( pointlist );
       
   elif  IsBound( polyt!.input_ineqs ) then
    
      ineqs := ShallowCopy( polyt!.input_ineqs );
      
      return Cdd_PolyhedronByInequalities( ineqs );
      
   else 
   
       Error( "something went wrong\n" );
       
   fi;
   
end );

##
InstallMethod( LatticePoints,
               "for polytopes (fallback)",
               [ IsPolytope ],
               
  function( polytope )
    local vertices, max, ineqs, points, min_vec, lenght, max_vec, i, j, k;
    
    if not HasDefiningInequalities( polytope ) and IsBound( polytope!.input_ineqs ) then
        
        ineqs := polytope!.input_ineqs;
        
    else
        
        ineqs := DefiningInequalities( polytope );
        
    fi;
    
    if HasVertices( polytope ) then
        
        vertices := Vertices( polytope );
        
        min_vec := List( TransposedMat( vertices ), k -> Minimum( k ) );
        
        max_vec := List( TransposedMat( vertices ), k -> Maximum( k ) );
        
    else
        
        max := Maximum( List( ineqs, i -> AbsoluteValue( i[ 1 ] ) ) );
        
        min_vec := List( [ 1 .. Length( ineqs[ 1 ] ) - 1 ], i -> - max );
        
        max_vec := List( [ 1 .. Length( ineqs[ 1 ] ) - 1 ], i -> max );
        
    fi;
    
    ## GAP has changed the behavior on list. Shit!
    i := ShallowCopy( min_vec );
    
    lenght := Length( min_vec );
    
    points := [ ];
    
    while i[ lenght ] <= max_vec[ lenght ] do
        
        if ForAll( ineqs, j -> Sum( [ 1 .. lenght ], k -> j[ k + 1 ] * i[ k ] ) >= - j[ 1 ] ) then
            
            Add( points, ShallowCopy( i ) );
            
        fi;
        
        k := 1;
        
        while k <= lenght and i[ k ] = max_vec[ k ] do
            
            k := k + 1;
            
        od;
        
        if k > lenght then
            
            break;
            
        fi;
        
        i[ k ] := i[ k ] + 1;
        
        for j in [ 1 .. k - 1 ] do
            
            i[ j ] := min_vec[ j ];
            
        od;
        
    od;
    
    return points;
    
end );


##
InstallMethod( RelativeInteriorLatticePoints,
               "for polytopes",
               [ IsPolytope ],
               
  function( polytope )
    local lattice_points, ineqs, inner_points, i, j;
    
    lattice_points := LatticePoints( polytope );
    
    ineqs := FacetInequalities( polytope );
    
    inner_points := [ ];
    
    for i in lattice_points do
        
        if ForAll( ineqs, j -> Sum( [ 1 .. Length( i ) ], k -> j[ k + 1 ] * i[ k ] ) > - j[ 1 ] ) then
            
            Add( inner_points, i );
            
        fi;
        
    od;
    
    return inner_points;
    
end );


##
InstallMethod( VerticesOfPolytope,
               "for polytopes",
               [ IsPolytope ],
               
  function( polyt )
    
    return Cdd_GeneratingVertices( ExternalCddPolytope( polyt ) );
    
end );

##
InstallMethod( Vertices,
               "for compatibility",
               [ IsPolytope ],
               
  VerticesOfPolytope
  
);

##
InstallMethod( HasVertices,
               "for compatibility",
               [ IsPolytope ],
               
  HasVerticesOfPolytope
  
);

##
InstallMethod( FacetInequalities,
               " for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polyt )
    
    return Cdd_Inequalities( ExternalCddPolytope( polyt ) );
    
end );

##
InstallMethod( EqualitiesOfPolytope,
               "for external polytopes",
               [ IsPolytope ],
               
  function( polyt )
    
    return Cdd_Equalities( ExternalCddPolytope( polyt ) );
    
end );

##
InstallMethod( DefiningInequalities,
               "for polytope",
               [ IsPolytope ],
               
  function( polyt )
    
    return Concatenation( FacetInequalities( polyt ), EqualitiesOfPolytope( polyt ), - EqualitiesOfPolytope( polyt ) );
    
end );

##
InstallMethod( VerticesInFacets,
               "for polytopes",
               [ IsPolytope ],
               
  function( polytope )
    local ineqs, vertices, dim, incidence_matrix, i, j;
    
    ineqs := FacetInequalities( polytope );
    
    vertices := Vertices( polytope );
    
    if Length( vertices ) = 0 then
        
        return ListWithIdenticalEntries( Length( ineqs ), [ ] );
        
    fi;
    
    dim := Length( vertices[ 1 ] );
    
    incidence_matrix := List( [ 1 .. Length( ineqs ) ], i -> ListWithIdenticalEntries( Length( vertices ), 0 ) );
    
    for i in [ 1 .. Length( incidence_matrix ) ] do
        
        for j in [ 1 .. Length( vertices ) ] do
            
            if Sum( [ 1 .. dim ], k -> ineqs[ i ][ k + 1 ] * vertices[ j ][ k ] ) = - ineqs[ i ][ 1 ] then
                
                incidence_matrix[ i ][ j ] := 1;
                
            fi;
            
        od;
        
    od;
    
    return incidence_matrix;
    
end );

InstallMethod( NormalFan,
               " for external polytopes",
               [ IsPolytope ],
               
  function( polytope )
    local ineqs, vertsinfacs, fan, i, aktcone, j;
    
    ineqs := FacetInequalities( polytope );
    
    ineqs := List( ineqs, i -> i{ [ 2 .. Length( i ) ] } );
    
    vertsinfacs := VerticesInFacets( polytope );
    
    vertsinfacs := TransposedMat( vertsinfacs );
    
    fan := [ ];
    
    for i in vertsinfacs do
        
        aktcone := [ ];
        
        for j in [ 1 .. Length( i ) ] do
            
            if i[ j ] = 1 then
                
                Add( aktcone,  j  );
                
            fi;
            
        od;
        
        Add( fan, aktcone );
        
    od;
    
    fan := Fan( ineqs, fan );
    
    SetIsRegularFan( fan, true );
    
    SetIsComplete( fan, true );
    
    return fan;
    
end );

##
InstallMethod( AffineCone,
               " for homalg polytopes",
               [ IsPolytope ],
               
  function( polytope )
    local cone, newcone, i, j;
    
    cone := Vertices( polytope );
    
    newcone := [ ];
    
    for i in cone do
        
        j := ShallowCopy( i );
        
        Add( j, 1 );
        
        Add( newcone, j );
        
    od;
    
    return Cone( newcone );
    
end );

## this is very bad implimentation!
## Ask!
InstallMethod( LatticePointsGenerators,
               "for polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polyt )
    
    return [ LatticePoints( polyt ), [ ], [ ] ];
    
end );


####################################
##
## Constructors
##
####################################

##
InstallMethod( Polytope,
               "creates an polytope.",
               [ IsList ],
               
  function( pointlist )
    local polyt, extpoly;
    
    polyt := rec( input_points := pointlist );
    
     ObjectifyWithAttributes( 
        polyt, TheTypeConvexPolytope,
        IsBounded, true
     );
     
     if not pointlist = [ ] then
        
        SetAmbientSpaceDimension( polyt, Length( pointlist[ 1 ] ) );
        
     fi;
     
     return polyt;
     
end );


##
InstallMethod( PolytopeByInequalities,
               "creates a polytope.",
               [ IsList ],
               
  function( pointlist )
    local extpoly, polyt;
    
    polyt := rec( input_ineqs := pointlist );
    
    ObjectifyWithAttributes( 
        polyt, TheTypeConvexPolytope
    );
    
    if not pointlist = [ ] then
        
        SetAmbientSpaceDimension( polyt, Length( pointlist[ 1 ] ) -1 );
        
    fi;
     
     return polyt;
     
end );