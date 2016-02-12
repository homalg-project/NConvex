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
## Properties
##
####################################

##
InstallMethod( IsEmpty,
               "for polytopes",
               [ IsPolytope ],
               
  function( polytope )
    
    if IsBound( polytope!.input_points ) and Length( polytope!.input_points ) > 0 then
        
        return false;
        
    elif IsBound( polytope!.input_points ) and Length( polytope!.input_points ) = 0 then
    
        return true;
    
    else 
    
       return Cdd_IsEmpty( ExternalCddPolytope( polytope ) );
       
    fi;
    
end );

##
InstallMethod( IsNotEmpty,
                " for external polytopes.",
                [ IsPolytope ],
                
   function( polytope )
     
     return not IsEmpty( polytope );
     
end );

##
InstallMethod( IsNormalPolytope,
               " for external polytopes.",
               [ IsPolytope ],
               
  function( polytope )
  local cone, rays_of_the_cone, vertices, H;
    
  vertices:= Vertices( polytope );
  
  rays_of_the_cone:= List( vertices, i-> Concatenation( [ 1 ], i ) );
    
  cone := Cone( rays_of_the_cone );
  
  H:= HilbertBasis( cone );
  
  return ForAll( H, i-> i[1] = 1 );
  
end );

##
InstallMethod( IsVeryAmple,
               [ IsPolytope ],
   function( polyt )
   local V;
   
   if HasIsNormalPolytope( polyt) and IsNormalPolytope( polyt )= true then 
   
         return true;
         
   fi;
   
   V:= Vertices( polyt );
   
   return ForAll( V, function( u )
                     local  current_cone, current_polytope, current_Hilbertbasis, current_vertices, lattice_points;
   
                     current_vertices:= List( V, i-> i-u );

                     current_polytope:= Polytope( current_vertices );
       
                     current_cone := Cone( current_vertices );
       
                     lattice_points := LatticePoints( current_polytope );
       
                     current_Hilbertbasis:= HilbertBasis( current_cone );
       
                     Display( IsSubsetSet( lattice_points, current_Hilbertbasis ) );
       
       
                     return IsSubsetSet( lattice_points, current_Hilbertbasis );
       
                     end );

end );
             
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
   local old_pointlist, new_pointlist, ineqs, i,j;
   
   if IsBound( polyt!.input_points ) and IsBound( polyt!.input_ineqs ) then
        
        Error( "points and inequalities at the same time are not supported\n" );
        
   fi;
    
   if IsBound( polyt!.input_points ) then 
   
       old_pointlist := polyt!.input_points;
       
       new_pointlist:= [ ];
       
       for i in old_pointlist do 
           
           j:= ShallowCopy( i );
           
           Add( j, 1, 1 );
           
           Add( new_pointlist, j );
           
       od;
           
       return Cdd_PolyhedronByGenerators( new_pointlist );
       
   elif  IsBound( polyt!.input_ineqs ) then
    
      ineqs := ShallowCopy( polyt!.input_ineqs );
      
      return Cdd_PolyhedronByInequalities( ineqs );
      
   else 
   
       Error( "something went wrong\n" );
       
   fi;
   
end );


## this can be better written.
InstallMethod( LatticePoints,
               "for polytopes (fallback)",
               [ IsPolytope ],
               
  function( polytope )
  local f,g,l,t, maxi, mini,V,w,d,r;
   
  f:= function( L )              
 local u,i;
 u:= L[1];
 for i in [ 2..Length( L ) ] do
 u:= Cartesian(u, L[ i ] );
 u:= List( u, k-> Flat( k ) );
 od;
 return u;                      
 end;
 
 g:= function( Min, Max )
 return f( List( [ 1..Length( Max) ], i->[ Min[i] .. Max[i] ] ) );
 end;
 
 V:= Vertices( polytope );
 
 maxi := List( TransposedMat( V ), u-> Maximum( u ) );
 mini := List( TransposedMat( V ), u-> Minimum( u ) );
 
 l:= g( mini, maxi);
 d:= DefiningInequalities( polytope );
 
 w:= [ ];
 
 for t in l do
 
 Add(t, 1, 1 );
 
 r:= Flat( List(d, h->h*TransposedMat( [ t ] ) ) ); 
 
 if ForAll(r, h-> h>=0 ) then 
 
 Remove(t,1);
 Add( w, t );
 
 fi;
 
 od;
 
 
 return w;
   
    
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


####################################
##
## Methods
##
####################################

##
InstallMethod( \*,
               "for polytopes",
               [ IsPolytope, IsPolytope ],
               
  function( polytope1, polytope2 )
    local vertices1, vertices2, new_vertices, i, j;
    
    vertices1 := Vertices( polytope1 );
    
    vertices2 := Vertices( polytope2 );
    
    new_vertices := [ ];
    
    for i in vertices1 do
        
        for j in vertices2 do
            
            Add( new_vertices, Concatenation( i, j ) );
            
        od;
        
    od;
    
    return Polytope( new_vertices );
    
end );

InstallMethod( \*,
               [ IsInt, IsPolytope ],
               
  function( n, polyt )
  local V, polyt2;
  
  V:= n*Vertices( polyt );
  
  polyt2:= Polytope( V );
  
  SetVerticesOfPolytope( polyt2, V);
  
  return polyt2;

end );


InstallMethod( \*,
               [ IsPolytope, IsInt ],
               
  function( polyt, n )
  
  return n*polyt;

end );

##
InstallMethod( \+,
               "for polytopes",
               [ IsPolytope, IsPolytope ],
               
  function( polytope1, polytope2 )
    local vertices1, vertices2, new_polytope;
    
    ##Maybe same grid, but this might be complicated
    if not Rank( ContainingGrid( polytope1 ) ) = Rank( ContainingGrid( polytope2 ) ) then
        
        Error( "polytopes are not of the same dimension" );
        
    fi;
    
    vertices1 := Vertices( polytope1 );
    
    vertices2 := Vertices( polytope2 );
    
    new_polytope := Concatenation( List( vertices1, i -> List( vertices2, j -> i + j ) ) );
    
    new_polytope := Polytope( new_polytope );
    
    SetContainingGrid( new_polytope, ContainingGrid( polytope1 ) );
    
    return new_polytope;
    
end );



##
InstallMethod( IntersectionOfPolytopes,
               "for homalg cones",
               [ IsPolytope, IsPolytope ],
               
  function( polyt1, polyt2 )
    local polyt, ext_polytope;
    
    if not Rank( ContainingGrid( polyt1 ) ) = Rank( ContainingGrid( polyt2 ) ) then
        
        Error( "polytopes are not of the same dimension" );
        
    fi;
    
    ext_polytope:= Cdd_Intersection( ExternalCddPolytope( polyt1), ExternalCddPolytope( polyt2) ); 
    
    polyt := Polytope( Cdd_GeneratingVertices( ext_polytope) );
    
    SetExternalCddPolytope( polyt, ext_polytope );
    
    SetContainingGrid( polyt, ContainingGrid( polyt1 ) );
    
    SetAmbientSpaceDimension( polyt, AmbientSpaceDimension( polyt1 ) );
    
    return polyt;
    
end );

##
InstallMethod( FourierProjection,
               [ IsPolytope, IsInt ],
  function( polytope , n )
  local vertices, new_vertices, i, j;
  
  vertices := Vertices( polytope );
  
  new_vertices := [ ];
  
  for i in vertices do
  
     j:= ShallowCopy( i );
     Remove(j, n );
     Add( new_vertices, j );
     
  od;
  
  return  Polytope( new_vertices );
  
end );

####################################
##
## Display Methods
##
####################################

##
InstallMethod( ViewObj,
               "for homalg polytopes",
               [ IsPolytope ],
               
  function( polytope )
    local str;
    
    Print( "<A" );
    
    if HasIsNotEmpty( polytope ) then
        
        if IsNotEmpty( polytope ) then
            
            Print( " not empty" );
            
        fi;
    
    fi;
    
    if HasIsNormalPolytope( polytope ) then
        
        if IsNormalPolytope( polytope ) then
            
            Print( " normal" );
            
        fi;
    
    fi;
    
    if HasIsSimplicial( polytope ) then
        
        if IsSimplicial( polytope ) then
            
            Print( " simplicial" );
            
        fi;
    
    fi;
    
    if HasIsSimplePolytope( polytope ) then
        
        if IsSimplePolytope( polytope ) then
            
            Print( " simple" );
            
        fi;
    
    fi;
    
    if HasIsVeryAmple( polytope ) then
        
        if IsVeryAmple( polytope ) then
            
            Print( " very ample" );
            
        fi;
    
    fi;
    
    Print( " " );
    
    if HasIsLatticePolytope( polytope) then
        
        if IsLatticePolytope( polytope ) then
            
            Print( "lattice" );
            
        fi;
        
    fi;
    
    Print( "polytope in |R^" );
    
    Print( String( AmbientSpaceDimension( polytope ) ) );
    
    if HasVertices( polytope ) then
        
        Print( " with ", String( Length( Vertices( polytope ) ) )," vertices" );
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for homalg polytopes",
               [ IsPolytope ],
               
  function( polytope )
    local str;
    
    Print( "A" );
    
    if HasIsNotEmpty( polytope ) then
        
        if IsNotEmpty( polytope ) then
            
            Print( " not empty" );
            
        fi;
    
    fi;
    
    if HasIsNormalPolytope( polytope ) then
        
        if IsNormalPolytope( polytope ) then
            
            Print( " normal" );
            
        fi;
    
    fi;
    
    if HasIsSimplicial( polytope ) then
        
        if IsSimplicial( polytope ) then
            
            Print( " simplicial" );
            
        fi;
    
    fi;
    
    if HasIsSimplePolytope( polytope ) then
        
        if IsSimplePolytope( polytope ) then
            
            Print( " simple" );
            
        fi;
    
    fi;
    
    if HasIsVeryAmple( polytope ) then
        
        if IsVeryAmple( polytope ) then
            
            Print( " very ample" );
            
        fi;
    
    fi;
    
    Print( " " );
    
    if HasIsLatticePolytope( polytope) then
        
        if IsLatticePolytope( polytope ) then
            
            Print( "lattice" );
            
        fi;
        
    fi;
    
    Print( "polytope in |R^" );
    
    Print( String( AmbientSpaceDimension( polytope ) ) );
    
    if HasVertices( polytope ) then
        
        Print( " with ", String( Length( Vertices( polytope ) ) )," vertices" );
        
    fi;
    
    Print( ".\n" );
    
end );