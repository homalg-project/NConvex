#############################################################################
##
##  Polytope.gi         NConvex package package         Sebastian Gutsche
##                                                      Kamal Saleh
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Polytopes for NConvex package.
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
                " for polytopes.",
                [ IsPolytope ],
                
   function( polytope )
     
     return not IsEmpty( polytope );
     
end );

InstallMethod( IsLatticePolytope,
               "for polytopes",
               [ IsPolytope ],
               
  function( polytope )
  local V;
  V:= Set( Flat( Vertices( polytope ) ) );
  
  return ForAll( V , IsInt );

end );

##
InstallMethod( IsNormalPolytope,
               " for external polytopes.",
               [ IsPolytope ],
               
  function( polytope )
  local cone, rays_of_the_cone, vertices, H,b;
  
  # Theorem 2.2.12, Cox
  b:= BabyPolytope( polytope );
  
  if IsFullDimensional( b[2] ) and 
      
      Dimension( b[2] )>=2     and 
   
      b[1] >= AmbientSpaceDimension( polytope ) -1 then  return true; 
      
  fi;
  
  # Proposition 2.2.18, Cox
  if HasIsVeryAmple( polytope ) and not IsVeryAmple( polytope ) then 
  
          return false;
          
  fi;
  
  
  
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
   local V, b;
   
   # Corollary 2.2.19, Cox
   b:= BabyPolytope( polyt );
   
   if IsFullDimensional( b[2] ) and Dimension( b[2] )=2 then return true; fi;
  
   if IsFullDimensional( b[2] ) and 
      
      Dimension( b[2] )>=2     and 
   
      b[1] >= AmbientSpaceDimension( polyt ) -1 then  return true; 
      
   fi;
      
   # Proposition 2.2.18, Cox
   if HasIsNormalPolytope( polyt) and IsNormalPolytope( polyt )= true then 
   
         return true;
         
   fi;
  
  
  # \begin{theorem}
  # Let $P$ be a polytope. The following statements are equivalent:
  # \begin{itemize}
  # \item[1.] $P$ is very ample.
  # \item[2.] For each vertex $m$ of $P$ the affine monoid $C_{P,m} \cap M$ of the cone $C_{P,m}:= \mathbb{R}_{\geq 0}(P-m)= \{r(x-m) \in M| r> 0, x\in P \}$ is generated by $(P-m)\cap M$.
  # \end{itemize}
  # \end{theorem}

   V:= Vertices( polyt );
   
   return ForAll( V, function( u )
                     local  current_cone, current_polytope, current_Hilbertbasis, current_vertices, lattice_points;
   
                     current_vertices:= List( V, i-> i-u );

                     current_polytope:= Polytope( current_vertices );
       
                     current_cone := Cone( current_vertices );
       
                     lattice_points := LatticePoints( current_polytope );
       
                     current_Hilbertbasis:= HilbertBasis( current_cone );
       
                     return IsSubsetSet( lattice_points, current_Hilbertbasis );
       
                     end );

end );

##
InstallMethod( IsSimplePolytope,
               "for polytopes",
               [ IsPolytope ],
               
 function( polyt )
 local d,v,l;
 
 d:= FacetInequalities( polyt );
 
 v:= Vertices( polyt );
 
 l:= List(v, i-> Concatenation( [ 1 ], i ) );
 
 return ForAll( l, function( i )
                   local w;
            
                   w:= Flat(d* TransposedMat( [ i ] ) );
            
                   return Length( Positions( w, 0 ) )= Dimension( polyt );
            
                   end );
            
end );

##
InstallMethod( IsSimplexPolytope,
               [ IsPolytope ],
               
  function( polyt )
   
  return Length( Vertices( polyt ) )=Dimension( polyt ) +1;
   
end );

##
InstallMethod( InteriorPoint,
                [ IsConvexObject and IsPolytope ],
    function( poly )
    return Cdd_InteriorPoint( ExternalCddPolytope( poly ) );
end );

##
InstallMethod( IsSimplicial,
               [ IsPolytope ],
               
  function( polyt )
  local eq, ineqs, dim;
  
  dim:= Dimension( polyt );
  
  eq:= EqualitiesOfPolytope( polyt );
  
  ineqs:= FacetInequalities( polyt );
  
  return ForAll( ineqs,  function( i )
                         local p,l;
  
                         l:= Concatenation( ineqs, eq, [ -i ] );
                  
                         p:= PolytopeByInequalities( l );
                  
                         return Length( Vertices( p ) )= dim;
                  
                         end );
                  
end );
  
##
InstallMethod( IsBounded,
               " for external polytopes.",
               [ IsPolytope ],
               
  function( polytope )

  return Length( Cdd_GeneratingRays( ExternalCddPolytope( polytope ) ) ) = 0;
  
end );

##
InstallMethod( IsFullDimensional,
               [ IsPolytope ], 
               
function( polyt )

return Dimension( polyt ) = AmbientSpaceDimension( polyt );

end );
####################################
##
## Attributes
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

##
InstallMethod( Dimension, 
               "for polytopes",
               [ IsPolytope ],
function( polytope )

return Cdd_Dimension( ExternalCddPolytope( polytope ) );
end );


##
InstallMethod( LatticePointsGenerators,
               "for polytopes",
               [ IsPolytope ],
               
  function( polytope )
    
    return LatticePointsGenerators( Polyhedron( polytope, [ ] ) );
    
end );

##
InstallMethod( LatticePoints, 
               [ IsPolytope ], 
               
  function( polytope )
    local vertices, C, H;

    vertices := List( Vertices( polytope ), V -> Concatenation(V,[1]) );
    C := Cone( vertices );
    H := HilbertBasis( C );
    H := Filtered( H, h -> h[ AmbientSpaceDimension( C ) ] = 1 );
    H := List( H, h -> ShallowCopy( h ) );
    Perform( H, Remove );
    return H;
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

## this can be better written.
# InstallMethod( LatticePoints,
#                "for polytopes (fallback)",
#                [ IsPolytope ],
#                
#   function( polytope )
#   local f,g,l,t, maxi, mini,V,w,d,r;
#    
#   f:= function( L )              
#  local u,i;
#  u:= L[1];
#  for i in [ 2..Length( L ) ] do
#  u:= Cartesian(u, L[ i ] );
#  u:= List( u, k-> Flat( k ) );
#  od;
#  return u;                      
#  end;
#  
#  g:= function( Min, Max )
#  return f( List( [ 1..Length( Max) ], i->[ Min[i] .. Max[i] ] ) );
#  end;
#  
#  V:= Vertices( polytope );
#  
#  maxi := List( List( TransposedMat( V ), u-> Maximum( u ) ), t->Int( t ) );
#  mini := List( List( TransposedMat( V ), u-> Minimum( u ) ), t->Int( t ) );
#  
#  l:= g( mini, maxi);
#  d:= DefiningInequalities( polytope );
#  
#  w:= [ ];
#  
#  for t in l do
#  
#  Add(t, 1, 1 );
#  
#  r:= Flat( List(d, h->h*TransposedMat( [ t ] ) ) ); 
#  
#  if ForAll(r, h-> h>=0 ) then 
#  
#  Remove(t,1);
#  Add( w, t );
#  
#  fi;
#  
#  od;
#  
#  
#  return w;
#    
#     
# end );


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

## 
InstallMethod( BabyPolytope,
               [ IsPolytope ],
               
 function( polyt )
 local l,n, new_vertices; 
 
 l:= Set( Flat( Vertices( polyt ) ) );
 n:= Iterated(l, Gcd );
 new_vertices:= (1/n)*Vertices( polyt );
 
 return [n, Polytope( new_vertices ) ];
 
end );

##
InstallMethod( PolarPolytope,
               [ IsPolytope ],
               
  function( polyt )
  local d,l;
  
  # Page 65, Cox
  if not IsFullDimensional( polyt ) then 
  
      Error( "Polar polytope is defined only for full dimensional polytopes!" );
      
  fi;
  
  d:= DefiningInequalities( polyt );
  
  if not ForAll( d, i-> i[ 1 ] > 0 ) then 
  
       Error( "The origin 0 should be an interior point in the polytope!" );
       
  fi;
  
  l:= List(d, function( u )
          local v;
          
          v:= ShallowCopy( u );
          
          Remove(v, u[1] );
          
          v:= v/u[1];
          
          return v;
          
          end );

  return Polytope( l );
  
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
    
    if not IsBounded( polyt ) then 
    
        Error( "The given inequalities define unbounded polyhedron." );
        
    fi;

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

##
InstallMethod( GaleTransform,
    [ IsHomalgMatrix ],
    function( mat )
      local K, L, P, A, B;

      K := HomalgRing( mat );

      if not IsField( K ) then
        
        Error( "The matrix should be defined over a homalg field" );

      fi;

      L := EntriesOfHomalgMatrixAsListList( mat );

      P := Polytope( L );

      if not IsFullDimensional( P ) then

        Error( "The rows of the given matrix should define a full-dimensional polytope!" );

      fi;

      L := List( L, l -> Concatenation( [ One( K ) ], l ) );

      L := HomalgMatrix( L, K );

      B := BasisOfRows( SyzygiesOfRows( L ) );
      
      A := EntriesOfHomalgMatrixAsListList( B );

      A := List( A, a -> Lcm( List( a, e -> DenominatorRat( e ) ) ) * a );

      A := HomalgMatrix( A, NrRows( B ), NrCols( B ), K );

      if NrRows( A ) <> NrRows( L ) - NrCols( L ) then
        
        Error( "This should not happen!" );

      fi;

      return Involution( A );

end );

##
InstallMethod( RandomInteriorPoint,
              [ IsPolytope ],
    function( polytope )
      local vertices, L;

      vertices := Vertices( polytope );

      L := List( vertices, v -> Random( [ 1 .. 1000 ] ) );
    
      L := L/Sum( L );

      return L*vertices;

end );

##
InstallMethod( IsInteriorPoint,
             [ IsList, IsPolytope ],
    function( P, polytope )
      local ineq, P1;
      
      ineq := DefiningInequalities( polytope );
      
      ineq := Filtered( ineq, i -> not ( i in ineq and -i in ineq ) );

      P1 := Concatenation( [ 1 ], P );

      return ForAll( ineq, i -> i*P1 > 0 );

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
        
        Print( " with ", String( Length( Vertices( polytope ) ) )," vertices:",Vertices( polytope ) );
        
    fi;
    
    Print( ".\n" );
    
end );