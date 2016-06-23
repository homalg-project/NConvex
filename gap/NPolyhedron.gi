#############################################################################
##
##  Polyhedron.gi         NConvex package         Sebastian Gutsche
##                                                Kamal Saleh
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Polyhedrons for NConvex.
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
        
    elif HasMainRatPolytope( polyhedron ) then
        
        return ContainingGrid( MainRatPolytope( polyhedron ) );
        
    fi;
    
end );

##
InstallMethod( ExternalCddPolyhedron,
               "for polyhedrons",
               [ IsPolyhedron and HasMainRatPolytope and HasTailCone ],
               
  function( polyhedron )
    local verts, rays;
    
    verts := Vertices( MainRatPolytope( polyhedron ) );
    
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
InstallMethod( DefiningInequalities, 
               " for polyhedrons",
               [ IsPolyhedron ], 
               
   function( polyhedron )
   local ineq, eq, ex, d;
   
   ex:= ExternalCddPolyhedron( polyhedron );
   
   ineq := Cdd_Inequalities( ex );
   eq   := Cdd_Equalities( ex );
   
   d:= Concatenation( ineq, eq, -eq );
   
   return d;
 
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

InstallMethod( ExternalNmzPolyhedron, 
               [ IsPolyhedron ], 
               
function( poly )
local ineq, new_ineq;

if IsBound( poly!.inequalities ) then 

     ineq:= poly!.inequalities;
     
fi;

ineq:= DefiningInequalities( poly );

new_ineq := List( ineq, function( i )
                        local j;
                        
                        j:= ShallowCopy( i );
                        Add( j, j[ 1 ] );
                        Remove(j ,1 );
                        
                        return j;
                        
                        end );
return NmzCone( [ "inhom_inequalities", new_ineq ] );

end );
                        
                        

InstallMethod( Dimension, 
               [ IsPolyhedron ], 
   function( polyhedron )
   
   return Cdd_Dimension( ExternalCddPolyhedron( polyhedron ) );
   
end );

InstallMethod( MainRatPolytope, 
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
    return Polytope( VerticesOfMainRatPolytope( polyhedron ) );
    
end );

##
InstallMethod( MainPolytope,
              [ IsPolyhedron ],
  
  function( polyhedron )
  
  return Polytope( LatticePointsGenerators( polyhedron )[ 1 ] );
  
end );

##
InstallMethod( VerticesOfMainPolytope,
              [ IsPolyhedron ], 
              
  function( polyhedron )
  
  return Vertices( MainPolytope( polyhedron ) );
  
end );

##
InstallMethod( VerticesOfMainRatPolytope,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    local v;
    
    if IsBound( polyhedron!.inequalities ) then 
    
        v:= Cdd_GeneratingVertices( ExternalCddPolyhedron( polyhedron ) );

        if Length( v ) > 0 then 
        
               return v;
               
        else 
        
               return [ ListWithIdenticalEntries(AmbientSpaceDimension( polyhedron ), 0 ) ];
               
        fi;
        
        
    else 
    
        return Vertices( MainRatPolytope( polyhedron ) );
        
    fi;
    
end );

InstallMethod( TailCone,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
  if RayGeneratorsOfTailCone( polyhedron ) <> [ ] then 
  
         return Cone( RayGeneratorsOfTailCone( polyhedron ) );
         
  else 
  
  
         return Cone( [ ListWithIdenticalEntries( AmbientSpaceDimension( polyhedron ), 0 ) ] );
   
  fi;
  
end );

##
InstallMethod( RayGeneratorsOfTailCone,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
     if IsBound( polyhedron!.inequalities ) then 
    
        return Cdd_GeneratingRays( ExternalCddPolyhedron( polyhedron ) );

     else
       
        return RayGenerators( TailCone( polyhedron ) );
        
     fi;
    
end );

##
InstallMethod( HomogeneousPointsOfPolyhedron,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    local verts, rays;
    
    verts := Vertices( MainRatPolytope( polyhedron ) );
    
    verts := List( verts, i -> Concatenation( [ 1 ], i ) );
    
    rays := RayGenerators( TailCone( polyhedron ) );
    
    rays := List( rays, i -> Concatenation( [ 0 ], i ) );
    
    polyhedron := Concatenation( rays, verts );
    
    return polyhedron;
    
end );


InstallMethod( LatticePointsGenerators, 
                 [ IsPolyhedron ], 
                 
   function( p )
   local external_poly,nmz_points_in_main_polytope, points_in_main_polytope, 
                       nmz_hilbert_basis, hilbert_basis, nmz_lineality, lineality;
   
   external_poly:= ExternalNmzPolyhedron( p );
   
   nmz_points_in_main_polytope:= NmzModuleGenerators( external_poly ); 
   
   points_in_main_polytope:= 
                  
                  List( nmz_points_in_main_polytope , function( i ) 
                                                  local j;
                                                              
                                                  j:= ShallowCopy( i );
                                                              
                                                  Remove( j, Length( i ) );
                                                              
                                                  return j;
                                                              
                                                  end );
                                                  
   nmz_hilbert_basis:= NmzHilbertBasis( external_poly );
   
   hilbert_basis := 
                  
                  List( nmz_hilbert_basis , function( i ) 
                                            local j;
                                                              
                                            j:= ShallowCopy( i );
                                                              
                                            Remove( j, Length( i ) );
                                                              
                                            return j;
                                                              
                                            end );
   
   nmz_lineality := NmzMaximalSubspace( external_poly );
   
   lineality:= List( nmz_lineality, function( i ) 
                                    local j;
                                                              
                                    j:= ShallowCopy( i );
                                                              
                                    Remove( j, Length( i ) );
                                                              
                                    return j;
                                                              
                                    end );
   
    
    return [ points_in_main_polytope, hilbert_basis, lineality ];
    
    end );
    
    
# InstallMethod( LatticePointsGenerators,
#                [ IsPolyhedron ], 
#                
#   function( p )
#   local nmz_p, T,R,l,M,V, int_point_in_p,i,h,g, all_points, rays_not_in_lineality, combi,n,d,N,H,B, current_list,
#   new_lineality_base, proj1, proj2, new_proj2, min_proj, new_N, new_B,
#   points1,points2, proj12, proj123,pos, new_lineality, proj1234, rays_pro, rays_pro_mod, H2,lat,l_c,new_pos;
#     
#   nmz_p:= ExternalNmzPolyhedron( p ); 
#   
#   T:= TailCone( p );
#   
#   if IsPointed( T ) then 
#   
#          g:= NmzModuleGenerators( nmz_p );
#          
#          for i in g do
#          
#            Remove(i, AmbientSpaceDimension( p ) +1 );
#            
#          od;
#          
#          h:= NmzHilbertBasis( nmz_p );
#    
#          for i in h do
#           
#            Remove( i, AmbientSpaceDimension( p ) +1 );
#            
#          od;
#          
#          return [ g, h, [ ] ];
#          
#   fi;
#   
#   R:= RayGeneratorsOfTailCone( p ); 
#   
#   l:= BasisOfLinealitySpace( p );
#   
#   V:= VerticesOfMainRatPolytope( p );
#   
#   if Dimension( p )= Length( l ) then 
#   
#        if IsBound( NmzModuleGenerators(ExternalNmzPolyhedron( Polyhedron( V, l ) ) )[ 1 ] ) then 
#        
#                 int_point_in_p:= NmzModuleGenerators(ExternalNmzPolyhedron( Polyhedron( V, l ) ) )[ 1 ];
#                 
#        else 
#        
#                 Print( "The given polyhedron does not contain integer points\n" );
#                 
#                 return [ [ ], [ ], [ ] ];
#                 
#        fi;
#        
#        Remove( int_point_in_p, AmbientSpaceDimension( p ) +1 );
#   
#        return [ [ int_point_in_p ], [ ], 
#                     ShallowCopy( LLLReducedBasis( HilbertBasis( Cone( l ) ), "linearcomb" )!.basis ) ];
#           
#   fi;
#   
#   n:= AmbientSpaceDimension( p );
#   
#   d:= Length( l );
#   
#   M:= ShallowCopy( l );
#   
#   N:= [ ];
#   
#   for i in [ 1..n-d ] do
#   
#      current_list:= BaseOrthogonalSpaceMat( Concatenation( M, N ) );
#      
#      Add( N, current_list[ 1 ] );
# 
#   od;
#   
#   new_lineality_base:= [ ];
#   
#   for i in [ 1..d ] do
#   
#     current_list:= BaseOrthogonalSpaceMat( Concatenation( N, new_lineality_base ) );
#     
#     Add( new_lineality_base, LcmOfDenominatorRatInList( current_list[ 1 ] )*current_list[ 1 ] );
#     
#   od;
#   
#   B:= Concatenation( new_lineality_base, N );
# 
#   combi:= testttt2( new_lineality_base );
#   
#   rays_not_in_lineality:= [ ];
#   
#   for i in R do 
#   
#      if not -i in R then Add( rays_not_in_lineality, i ); fi;
#      
#   od;
# 
#   H:=  List( combi, c->NmzModuleGenerators(ExternalNmzPolyhedron( Polyhedron( V, Concatenation(c, rays_not_in_lineality) ) ) ) );
# 
#   all_points:= [ ];
#   
#   for i in H do 
#   
#       Append( all_points, i );
#       
#   od;
#   
#   for i in all_points do
#   
#       Remove( i, n+1 );
#      
#   od;
#   
#   proj1:= List( all_points, a-> a*B^-1 );
#   
#   
#   proj2:= List( [ d+1..n], i-> List(proj1, p-> AbsInt( p[i] ) ) );
#   
#   new_proj2:= List( proj2, p-> List(Set(p)) );
#   
#   
#   min_proj:= List( new_proj2, function( p )
#                               local t,l;
#                               
#                               if IsZero( p ) then return 1;fi;
#                               
#                               l:=LcmOfDenominatorRatInList( p );
#   
#                               t:= Iterated(l*p, Gcd );
#                               
#                               return t/l;
#                               
#                               end );
#   
#   new_N:= List( [ 1..Length(N) ], i-> min_proj[i]*N[i] );
#   
#   
#   new_B:= Concatenation( new_lineality_base, new_N );
#   
#   proj12:= List( all_points, a-> a*new_B^-1 );
#   
#   
#   proj123:= List( proj12, function( p )
#                           local i,q; 
#                         
#                           q:= ShallowCopy( p );
#     
#                           for i in [1..n] do
#                        
#                           if i<=d then q[i]:= 0; fi;
#                        
#                           od;
#                        
#                           return q;
#                        
#                           end );
#                           
#  proj1234:= [ ];
#  
#  for h in Set( proj123 ) do
#  
#   if not IsZero( h ) then Add( proj1234, h ); fi;
#   
#  od;
#  
#  rays_pro:= List( rays_not_in_lineality, r -> r* new_B^-1 );
#  
#  rays_pro_mod := List( rays_pro, function( p )
#                             local i,q; 
#                         
#                             q:= ShallowCopy( p );
#     
#                             for i in [1..n] do
#                        
#                             if i<=d then q[i]:= 0; fi;
#                        
#                             od;
#                        
#                             return q;
#                        
#                             end );
# 
#    H:= NmzModuleGenerators( ExternalNmzPolyhedron( Polyhedron( proj1234, rays_pro_mod ) ) );
# 
#      H2:= List( H, function( h )
#                 local q;
#                 
#                 q:= ShallowCopy( h );
#                 
#                 Remove(q, n+1 );
#                 
#                 return q; 
#                 
#                 end );
#   points2:= [ ];
#   
#   for h in H2 do
#   
#   pos:= Positions(proj123, h );
#   
#   l_c:= List( pos, p-> all_points[ p ] );
#   
#   if Length( pos )=0 then
#   
#         Error( "Something went wrong! This shouldn't happen, please tell me about this!" );
#         
#   else
#   
#         new_pos:= Positions( List(List( l_c, l-> List(l, u-> AbsInt( u ) ) ), Sum ), Minimum( List(List( l_c, l-> List(l, u-> AbsInt( u ) ) ), Sum ) ) );
# 
#   
#         Add( points2, l_c[ new_pos[1] ] );
#         
#   fi;
#   
#   od;
#   
#   lat:= LatticePointsGenerators( T );
#   
#   return [ points2, lat[2] , lat[3] ];
#   
# end );


InstallMethod( BasisOfLinealitySpace,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
    return LinealitySpaceGenerators( TailCone( polyhedron ) );
    
end );

InstallGlobalFunction( Draw,
function()

Exec( "firefox https://www.desmos.com/calculator &" );

end );

#####################################
##
##  Properties
##
#####################################

##
InstallMethod( IsBounded,
               " for external polytopes.",
               [ IsPolyhedron ],
               
  function( polyhedron )

  return Length( Cdd_GeneratingRays( ExternalCddPolyhedron( polyhedron ) ) ) = 0;
  
end );

##
InstallMethod( IsNotEmpty,
               " for external polytopes.",
               [ IsPolyhedron ],
               
  function( polyhedron )

  return not Cdd_IsEmpty( ExternalCddPolyhedron( polyhedron ) );
  
end );

InstallMethod( IsPointed,
               [ IsPolyhedron ], 
      
  function( polyhedron )
  
  return IsPointed( TailCone( polyhedron ) );
  
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
                                          MainRatPolytope, polytope,
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
    
    if Length( cone ) = 0 then
        
        cone := [ List( [ 1 .. AmbientSpaceDimension( polytope ) ], i -> 0 ) ];
        
    fi;
    
    ObjectifyWithAttributes( polyhedron, TheTypeConvexPolyhedron,
                                          MainRatPolytope, polytope,
                                          TailCone, Cone( cone ),
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
                                          MainRatPolytope, polytope,
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
        
        Error( "The polytope of a polyhedron should at least contain one point!" );
        
    fi;
    
    if Length( cone ) = 0 then
        
        cone := [ List( [ 1 .. Length( polytope[ 1 ] ) ], i -> 0 ) ];
        
    fi;
    
    polyhedron := rec();
    
    ObjectifyWithAttributes( polyhedron, TheTypeConvexPolyhedron,
                                          MainRatPolytope, Polytope( polytope ),
                                          TailCone, Cone( cone ),
                                          AmbientSpaceDimension, Length( polytope[ 1 ] ) 
                                        );
    
    SetContainingGrid( TailCone( polyhedron ), ContainingGrid( MainRatPolytope( polyhedron ) ) );
    
    SetContainingGrid( polyhedron, ContainingGrid( MainRatPolytope( polyhedron ) ) );
    
    return polyhedron;
    
end );


 
##############################
##
## View & Display
##
##############################

##
InstallMethod( ViewObj,
               "for homalg polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    local str;
    
    Print( "<A" );
    
    if HasIsNotEmpty( polyhedron ) then
        
        if IsNotEmpty( polyhedron ) then
            
            Print( " not empty" );
            
        fi;
    
    fi;
    
    Print( " polyhedron in |R^" );
    
    Print( String( AmbientSpaceDimension( polyhedron ) ) );
    
    if HasDimension( polyhedron ) then
        
        Print( " of dimension ", String( Dimension( polyhedron ) ) );
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for homalg polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    local str;
    
    Print( "A" );
    
    if HasIsNotEmpty( polyhedron ) then
        
        if IsNotEmpty( polyhedron ) then
            
            Print( " not empty" );
            
        fi;
    
    fi;
    
    Print( " polyhedron in |R^" );
    
    Print( String( AmbientSpaceDimension( polyhedron ) ) );
    
    if HasDimension( polyhedron ) then
        
        Print( " of dimension ", String( Dimension( polyhedron ) ) );
        
    fi;
    
    Print( ".\n" );
    
end );
