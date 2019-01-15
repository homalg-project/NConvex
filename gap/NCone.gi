#############################################################################
##
##  Cone.gi                NConvex package          Sebastian Gutsche
##                                                  Kamal Saleh
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Cones for NConvex package.
##
#############################################################################


####################################
##
## Reps
##
####################################

DeclareRepresentation( "IsExternalConeRep",
                       IsCone and IsExternalFanRep,
                       [ ] );

DeclareRepresentation( "IsConvexConeRep",
                       IsExternalConeRep,
                       [ ] );

DeclareRepresentation( "IsInternalConeRep",
                       IsCone and IsInternalFanRep,
                       [ ] );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfCones",
        NewFamily( "TheFamilyOfCones" , IsCone ) );

BindGlobal( "TheTypeExternalCone",
        NewType( TheFamilyOfCones,
                 IsCone and IsExternalConeRep ) );

BindGlobal( "TheTypeConvexCone",
        NewType( TheFamilyOfCones,
                 IsConvexConeRep ) );

BindGlobal( "TheTypeInternalCone",
        NewType( TheFamilyOfCones,
                 IsInternalConeRep ) );


#####################################
##
## Property Computation
##
#####################################

##
InstallMethod( IsPointed,
                "for homalg cones.",
                [ IsCone ],
                
   function( cone )
     
     return Cdd_IsPointed( ExternalCddCone ( cone ) );
     
end );

##
InstallMethod( InteriorPoint,
                [ IsConvexObject and IsCone ],
    function( cone )
    local point, denominators;
    point := Cdd_InteriorPoint( ExternalCddCone( cone ) );
    denominators := List( point, DenominatorRat );
    if DuplicateFreeList( denominators ) = [ 1 ] then
        return point;
    else
        return Lcm( denominators )*point;
    fi;
end );

##
InstallMethod( IsComplete,
               " for cones",
               [ IsCone ],
               
  function( cone )
  local rays; 
  
   if IsPointed( cone ) or not IsFullDimensional( cone ) then
        
        return false;
        
   fi;
    
  rays:= RayGenerators( cone );
  
  return IsFullDimensional( cone ) and ForAll( rays, i-> -i in rays );
  
end );

##  Let N= Z^{1 \times n}. Then N is free Z-modue. Let r_1,...,r_k \in N be the generating rays of the 
##  cone. Let A= [ r_1,..., r_k ]^T \in Z^{ k \times n }. Let M= N/ Z^{1 \times k}A. Now let B the smith
## normal form of A. Then B \in Z^{ k \times n } and there exists l<=k, l<=n with B_{i,i} \neq 0 and B_{i-1,i}| B_{i-1,i} for 
## all 1<i<= l and B_{i,i}=0 for i>l. We have now M= Z/Zb_{1,1} \oplus ... \oplus Z/Zb_{l,l} \oplus Z^{1 \times max{n,k}-l }. 
## If all B_{i,i}=1 for i<=l, then M= Z^{1 \times max{n,k}-l }. i.e. M is free. Thus there is H \subset N with N= H \oplus Z^{1 \times k}A. 
## ( Corollary 7.55, Advanced modern algebra, J.rotman ).
##
InstallMethod( IsSmooth,
               "for cones",
               [ IsCone ],
               
  function( cone )
    local rays, smith;
    
    rays := RayGenerators( cone );
    
    if RankMat( rays ) <> Length( rays ) then
        
        return false;
        
    fi;
    
    smith := SmithNormalFormIntegerMat(rays);
    
    smith := List( Flat( smith ), i -> AbsInt( i ) );
    
    if Maximum( smith ) <> 1 then
        
        return false;
        
    fi;
    
    return true;
    
end );

##
InstallMethod( IsRegularCone,
               "for cones.",
               [ IsCone ],
  function( cone )
    
    return IsSmooth( cone );
    
end );


##
InstallMethod( IsSimplicial,
               " for cones",
               [ IsCone ],
  function( cone )
  local rays;
  
  rays:= RayGenerators( cone );
  
  return Length( rays )= RankMat( rays );
  
end );

##
InstallMethod( IsEmptyCone,
               "for cones",
               [ IsCone ],
  function( cone )
  
  return Cdd_IsEmpty( ExternalCddCone( cone ) );
  
end );

##
InstallMethod( IsFullDimensional,
               "for cones",
               [ IsCone ], 
  function( cone )
  
  return RankMat( RayGenerators( cone ) ) = AmbientSpaceDimension( cone );
  
end );
  
##
InstallTrueMethod( HasConvexSupport, IsCone );

##
InstallMethod( IsRay,
               "for cones.",
               [ IsCone ],
               
  function( cone )
    
    return Dimension( cone ) = 1;
    
end );

#####################################
##
## Attribute Computation
##
#####################################

InstallMethod( RayGenerators,
               [ IsCone ],
               
  function( cone )
#   local nmz_cone, l, r;
  
   return Cdd_GeneratingRays( ExternalCddCone( cone ) );
  
#   nmz_cone := ExternalNmzCone( cone );
  
#   r := NmzGenerators( nmz_cone );
  
#   l := NmzMaximalSubspace( nmz_cone );
  
#   return Concatenation( r, l, -l );

  end );

##
InstallMethod( DualCone,
               "for external cones",
               [ IsCone ],
               
  function( cone )
    local dual;
    
    if RayGenerators( cone ) = [ ] then
	dual := ConeByInequalities( [ List( [ 1 .. AmbientSpaceDimension( cone ) ], i -> 0 ) ] );
    else
        dual := ConeByInequalities( RayGenerators( cone ) );
    fi;

    SetDualCone( dual, cone );
    
    SetContainingGrid( dual, ContainingGrid( cone ) );
    
    return dual;
    
end );

##
InstallMethod( DefiningInequalities,
               [ IsCone ],
               
  function( cone )
  local inequalities, new_inequalities, equalities, i, u; 
  
  inequalities:= ShallowCopy( Cdd_Inequalities( ExternalCddCone( cone ) ) );
  
  equalities:= ShallowCopy( Cdd_Equalities( ExternalCddCone( cone ) ) );
  
  for i in equalities do 
  
       Append( inequalities, [ i,-i ] );
       
  od;
    
new_inequalities:= [ ];
    
  for i in inequalities do 
  
       u:= ShallowCopy( i );
       
       Remove( u , 1 );
       
       Add(new_inequalities, u );
       
  od;
  
  return new_inequalities; 
    
end );


##
InstallMethod( FactorConeEmbedding,
               "for cones",
               [ IsCone ],
               
  function( cone )
    
    return TheIdentityMorphism( ContainingGrid( cone ) );
    
end );

##
InstallMethod( EqualitiesOfCone,
               "for external Cone",
               [ IsCone ],
               
  function( cone )
  local equalities, new_equalities, u, i;
  
    equalities:= Cdd_Equalities( ExternalCddCone( cone ) );
    
    new_equalities:= [ ];
    
  for i in equalities do 
  
       u:= ShallowCopy( i );
       
       Remove( u , 1 );
       
       Add(new_equalities, u );
       
  od;
  
  return new_equalities;

end );

##
InstallMethod( RelativeInteriorRayGenerator,
               "for a cone",
               [ IsCone ],
               
  function( cone )
    local rays, rand_mat;
    
    rays := RayGenerators( cone );
    
    rand_mat := RandomMat( Length( rays ), 1 );
    
    rand_mat := Concatenation( rand_mat );
    
    rand_mat := List( rand_mat, i -> AbsInt( i ) + 1 );
    
    return Sum( [ 1 .. Length( rays ) ], i -> rays[ i ] * rand_mat[ i ] );
    
end );

##
InstallMethod( HilbertBasisOfDualCone,
               "for cone",
               [ IsCone ],
               
  function( cone )
    
        return HilbertBasis( DualCone( cone ) );
        
end );

## This method is commented since it returns a wrong answer for not-pinted cones
## C := Cone( [ e1 ] );
##
# InstallMethod( HilbertBasisOfDualCone,
#                "for cone",
#                [ IsCone ],
               
#   function( cone )
#     local ray_generators, d, i, dim, V, D, max, v, I, b, DpD, d1, d2, Dgens,
#     zero_element, entry;
    
#     ray_generators := RayGenerators( cone );
    
#     dim := AmbientSpaceDimension( cone );
    
#     max := Maximum( List( Concatenation( ray_generators ), AbsInt ) );
    
#     D := [ ]; 
    
#     ## This needs to be done smarter
#     I:= Cartesian( List( [ 1 .. dim ], i -> [ -max .. max ] ) );
    
#     for v in I do
        
#         if ForAll( ray_generators, i -> i * v >= 0 ) then
            
#             Add( D, v );
            
#         fi;
        
#     od;
    
#     DpD := [ ];
    
#     for d1 in D do
        
#         if d1 * d1 <> 0 then
            
#             for d2 in D do
                
#                 if d2 * d2 <> 0 then
                    
#                     Add( DpD, d1 + d2 );
                    
#                 fi;
                
#             od;
            
#         fi;
        
#     od;
    
#     Dgens :=  [ ];
    
#     for d in D do
        
#         if not d in DpD then
            
#             Add( Dgens, d );
            
#         fi;
        
#     od;
    
#     if not Dgens = [ ] then
        
#         zero_element := ListWithIdenticalEntries( Length( Dgens[ 1 ] ), 0 );
        
#         i := Position( Dgens, zero_element );
        
#         if i <> fail then
            
#             Remove( Dgens, i );
            
#         fi;
        
#     fi;
    
#     entry := ToDoListEntry( [ [ cone, "DualCone" ] ], [ DualCone, cone ], "HilbertBasis", Dgens );
    
#     AddToToDoList( entry );
    
#     return Dgens;
    
# end);

##
InstallMethod( AmbientSpaceDimension,
               "for cones",
               [ IsCone ],
               
  function( cone )
    
    if Length( RayGenerators( cone ) ) > 0 then
    
       return Length( RayGenerators( cone )[ 1 ] );
    
    else 
    
       return 1;
       
    fi;
    
end );

##
InstallMethod( Dimension,
               "for cones",
               [ IsCone and HasRayGenerators ],
               
  function( cone )
    
    if Length( RayGenerators( cone ) ) > 0 then
     
       return RankMat( RayGenerators( cone ) );
      
    else 
    
       return 0;
       
    fi;
   
    TryNextMethod();
    
end );

##
InstallMethod( Dimension, 
               "for cones",
               [ IsCone ],
  function( cone )
 
  return Cdd_Dimension( ExternalCddCone( cone ) );
  
end );

##
InstallMethod( HilbertBasis,
               "for cones",
               [ IsCone ],
               
  function( cone )
    
    if not IsPointed( cone ) then
        
        Error( "Hilbert basis for not-pointed cones is not yet implemented, you can use the command 'LatticePointsGenerators' " );
        
    fi;
    
    return NmzHilbertBasis( ExternalNmzCone( cone ) );
    
end );

InstallMethod( RaysInFacets,
               " for cones",
               [ IsCone ],
               
  function( cone )
  local external_cone, list_of_facets, generating_rays, list, current_cone, current_list, current_ray_generators, i;  
  
    external_cone := Cdd_H_Rep ( ExternalCddCone ( cone ) );
    
    list_of_facets:= Cdd_Facets( external_cone );
    
    generating_rays:= RayGenerators( cone );
    
    list:= [ ];
    
    for i in list_of_facets do
    
      current_cone := Cdd_ExtendLinearity( external_cone, i[2] );
      
      current_ray_generators := Cdd_GeneratingRays( current_cone ) ;
      
      current_list:= List( [1..Length( generating_rays )], function(j)
                                                           
                                                           if generating_rays[j] in Cone( current_cone ) then
                                                           
                                                                return 1;
                                                                
                                                           else 
                                                           
                                                                return 0;
                                                                
                                                           fi;
                                                           
                                                           end );
                                                           
      Add( list, current_list );
      
      od;
      
return list;
    
end );

##
InstallMethod( RaysInFaces,
               " for cones",
               [ IsCone ],
               
  function( cone )
  local external_cone, list_of_faces, generating_rays, list, current_cone, current_list, current_ray_generators, i,j;  
  
    external_cone := Cdd_H_Rep ( ExternalCddCone ( cone ) );
    
#     Display( "external_cone " ); Display( external_cone  );
    
    list_of_faces:= Cdd_Faces( external_cone );
    
#     Display( "list_of_faces "); Display( list_of_faces );
    
    generating_rays:= RayGenerators( cone );
    
#     Display( "generating_rays "); Display( generating_rays );
    
    list:= [ ];
    
#     Display( "list is  "); Display( list );
    for i in list_of_faces do
    
        if i[ 1 ]<>0 then 
          
            current_cone := Cdd_ExtendLinearity( external_cone, i[ 2 ] );
       
#             Display( "current_cone\n"); Display( current_cone );
       
            current_ray_generators := Cdd_GeneratingRays( current_cone ) ;
      
#             Display( "current_ray_generators"); Display( current_ray_generators );
            
            current_list:= List( [1..Length( generating_rays )], function(j)
                                                           
                                                                  if generating_rays[j] in Cone( current_cone ) then
                                                           
                                                                      return 1;
                                                                
                                                                  else 
                                                           
                                                                      return 0;
                                                                
                                                                  fi;
                                                           
                                                                  end );
                                                                 
#             Display( "current_list"); Display( current_list );
           
                                                           
            Add( list, current_list );
      
#             Display( "list"); Display( list );
      fi;
      
   od;
      
return list;
    
end );

##
InstallMethod( Facets,
               " for external cones",
               [ IsCone ],
               
  function( cone )
    local raylist, rays, conelist, i, lis, j;
    
    raylist := RaysInFacets( cone );
    
    rays := RayGenerators( cone );
    
    conelist := [ ];
    
    for i in [ 1..Length( raylist ) ] do
        
        lis := [ ];
        
        for j in [ 1 .. Length( raylist[ i ] ) ] do
            
            if raylist[ i ][ j ] = 1 then
                
                lis := Concatenation( lis, [ rays[ j ] ] );
                
            fi;
            
        od;
        
        conelist := Concatenation( conelist, [ lis ] );
        
    od;
    
    if conelist = [ [ ] ] then 
       return [ Cone( [ List( [ 1 .. AmbientSpaceDimension( cone ) ], i->0 ) ] ) ];
    fi;
    
    return List( conelist, Cone );
    
end );

##
InstallMethod( Faces,
               " for external cones",
               [ IsCone ],
               
  function( cone )
    local raylist, rays, conelist, i, lis, j;
    
    raylist := RaysInFaces( cone );
    
    rays := RayGenerators( cone );
    
    conelist := [ ];
    
    for i in [ 1..Length( raylist ) ] do
        
        lis := [ ];
        
        for j in [ 1 .. Length( raylist[ i ] ) ] do
            
            if raylist[ i ][ j ] = 1 then
                
                lis := Concatenation( lis, [ rays[ j ] ] );
                
            fi;
            
        od;
        
        conelist := Concatenation( conelist, [ lis ] );
        
    od;
    
    lis := [ Cone( [ List( [ 1 .. AmbientSpaceDimension( cone ) ], i-> 0 ) ] ) ];
    
    return Concatenation( lis, List( conelist, Cone ) );
    
end );

InstallMethod( FVector,
               "for cones",
               [ IsCone ],
  function( cone )
  local faces, dim_of_faces;
  
  faces:= Faces( cone );
  
  dim_of_faces := List( faces, Dimension );
  
  return List( [ 1..Maximum( dim_of_faces) ], i-> Length( Positions( dim_of_faces, i) ) );
  
  end );


##
InstallMethod( LinearSubspaceGenerators,
               [ IsCone ],
               
  function( cone )
  local inequalities, basis, new_basis;
  
  inequalities:=  DefiningInequalities( cone );
  
  basis := NullspaceMat( TransposedMat( inequalities ) );
  
  new_basis := List( basis, i-> LcmOfDenominatorRatInList( i )*i  );
  
  return  new_basis;
   
end );

##
InstallMethod( LinealitySpaceGenerators,
               [ IsCone ],
   
   LinearSubspaceGenerators
   
 );
 
##
InstallMethod( GridGeneratedByCone,
               " for homalg cones.",
               [ IsCone ],
               
  function( cone )
    local rays, M, grid;
    
    rays := RayGenerators( cone );
    
    M := HomalgMatrix( rays, HOMALG_MATRICES.ZZ );
    
    M := HomalgMap( M, "free", ContainingGrid( cone ) );
    
    grid := ImageSubobject( M );
    
    SetFactorGrid( cone, FactorObject( grid ) );
    
    SetFactorGridMorphism( cone, CokernelEpi( M ) );
    
    return grid;
    
end );

##
InstallMethod( GridGeneratedByOrthogonalCone,
               " for homalg cones.",
               [ IsCone ],
               
  function( cone )
    local rays, M;
    
    rays := RayGenerators( cone );
    
    M := HomalgMatrix( rays, HOMALG_MATRICES.ZZ );
    
    M := Involution( M );
    
    M := HomalgMap( M, ContainingGrid( cone ), "free" );
    
    return KernelSubobject( M );
    
end );

##
InstallMethod( FactorGrid,
               " for homalg cones.",
               [ IsCone ],
               
  function( cone )
    local rays, M, grid;
    
    rays := RayGenerators( cone );
    
    M := HomalgMatrix( rays, HOMALG_MATRICES.ZZ );
    
    M := HomalgMap( M, "free", ContainingGrid( cone ) );
    
    grid := ImageSubobject( M );
    
    SetGridGeneratedByCone( cone, grid );
    
    SetFactorGridMorphism( cone, CokernelEpi( M ) );
    
    return FactorObject( grid );
    
end );

##
InstallMethod( FactorGridMorphism,
               " for homalg cones.",
               [ IsCone ],
               
  function( cone )
    local rays, grid, M;
    
    rays := RayGenerators( cone );
    
    M := HomalgMatrix( rays, HOMALG_MATRICES.ZZ );
    
    M := HomalgMap( M, "free", ContainingGrid( cone ) );
    
    grid := ImageSubobject( M );
    
    SetGridGeneratedByCone( cone, grid );
    
    SetFactorGrid( cone, FactorObject( grid ) );
    
    return CokernelEpi( M );
    
end );

InstallMethod( LatticePointsGenerators, 
               [ IsCone ], 
               
    function( cone )
    local n;
    
    n:= AmbientSpaceDimension( cone );
    
    return LatticePointsGenerators( Polyhedron( [ List( [ 1 .. n ], i -> 0 ) ], cone ) );
    
    end );


## This is horrible 
##      
# 
# InstallMethod( LatticePointsGenerators, 
#                [ IsCone ], 
#                
#   function( cone )
#   local N,lineality_space, d, n, M, current_list,i, new_lineality_base, combi,B,
#   rays_not_in_lineality, R, H, all_points, proj1, proj2, new_proj2, min_proj, new_N, new_B,
#   points1,points2, proj12, proj123,h,pos, new_lineality, proj1234, rays_pro, rays_pro_mod, H2;
#   
#   n:= AmbientSpaceDimension( cone );
#   
#   if IsPointed( cone ) then 
#   
#           return [ [ ListWithIdenticalEntries(n,0) ], HilbertBasis( cone ), [ ] ];
#           
#   fi;
#   
#   if Dimension( cone )= Length( LinealitySpaceGenerators( cone ) ) then
#   
#           return [ [ ListWithIdenticalEntries(n,0) ], [ ], 
#                     ShallowCopy( LLLReducedBasis( HilbertBasis( Cone( LinealitySpaceGenerators( cone ) ) ), "linearcomb" )!.basis ) ];
#           
#   fi;
#   
#   lineality_space:= LinealitySpaceGenerators( cone );
#   
#   d:= Length( lineality_space );
#   
#   M:= ShallowCopy( lineality_space );
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
# #   
#   combi:= testttt2( new_lineality_base );
#   
#   R:= RayGenerators( cone );
#   
#   rays_not_in_lineality:= [ ];
#   
#   for i in R do 
#   
#      if not -i in R then Add( rays_not_in_lineality, i ); fi;
#      
#   od;
#   
#   H:= List( combi, c-> HilbertBasis( Cone( Concatenation( c, rays_not_in_lineality ) ) ) );
#   
#   all_points:= [ ];
#   
#   for i in H do 
#   
#       Append( all_points, i );
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
#   H:= NmzModuleGenerators( ExternalNmzPolyhedron( Polyhedron( proj1234, rays_pro_mod ) ) );
#   
#   H2:= List( H, function( h )
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
#   if Length( pos )=0 then
#   
#         Error( "Something went wrong! This shouldn't happen, please tell me about this!" );
#         
#   else
#   
#         Add( points2, all_points[ pos[1] ] );
#         
#   fi;
#   
#   od;
#   
#   new_lineality:= ShallowCopy( LLLReducedBasis( HilbertBasis( Cone( combi[1] ) ), "linearcomb" )!.basis );
#   
#   return [ [ ListWithIdenticalEntries(n,0) ], points2, new_lineality ];
#   
# end );
# 

##
InstallMethod( StarSubdivisionOfIthMaximalCone,
               " for homalg cones and fans",
               [ IsFan, IsInt ],
               
  function( fan, noofcone )
    local maxcones, cone, ray, cone2;
    
    maxcones := MaximalCones( fan );
    
    maxcones := List( maxcones, RayGenerators );
    
    if Length( maxcones ) < noofcone then
        
        Error( " not enough maximal cones" );
        
    fi;
    
    cone := maxcones[ noofcone ];
    
    ray := Sum( cone );
    
    cone2 := Concatenation( cone, [ ray ] );
    
    cone2 := UnorderedTuples( cone2, Length( cone2 ) - 1 );
    
    Apply( cone2, Set );
    
    Apply( maxcones, Set );
    
    maxcones := Concatenation( maxcones, cone2 );
    
    maxcones := Difference( maxcones, [ Set( cone ) ] );
    
    maxcones := Fan( maxcones );
    
    SetContainingGrid( maxcones, ContainingGrid( fan ) );
    
    return maxcones;
    
end );


##
InstallMethod( StarFan,
               " for homalg cones in fans",
               [ IsCone and HasIsContainedInFan ],
               
  function( cone )
    
    return StarFan( cone, IsContainedInFan( cone ) );
    
end );

##
InstallMethod( StarFan,
               " for homalg cones",
               [ IsCone, IsFan ],
               
  function( cone, fan )
    local maxcones;
    
    maxcones := MaximalCones( fan );
    
    maxcones := Filtered( maxcones, i -> Contains( i, cone ) );
    
    maxcones := List( maxcones, HilbertBasis );
    
    ## FIXME: THIS IS BAD CODE! REPAIR IT!
    maxcones := List( maxcones, i -> List( i, j -> HomalgMap( HomalgMatrix( [ j ], HOMALG_MATRICES.ZZ ), 1 * HOMALG_MATRICES.ZZ, ContainingGrid( cone ) ) ) );
    
    maxcones := List( maxcones, i -> List( i, j -> UnderlyingListOfRingElementsInCurrentPresentation( ApplyMorphismToElement( ByASmallerPresentation( FactorGridMorphism( cone ) ), HomalgElement( j ) ) ) ) );
    
    maxcones := Fan( maxcones );
    
    return maxcones;
    
end );
##############################
##
##  Extra Operations
##
##############################

# 
# InstallGlobalFunction( "AddIfPossible",
#                        [ IsList, IsVector ],
#                        
#   function( M, v )
#   
#   if M = [] then return [ v ]; fi;
#    
#   if SolutionPostIntMat(M, v )= true then 
#   
#              return M;
#              
#   fi;
#   
#   return Concatenation( M, [ v ] );
#   
# end );

     
InstallGlobalFunction( "testttt", 

 function( m )
 local com;
 
 com:= Combinations( [1..m] );
 
 return List(com, function( h )
           local u;
           u:= [1..m];
           SubtractSet(u, h );
           
           return Concatenation(h,-u);
           end );
           
 
 end );
 
InstallGlobalFunction( "testttt2",

 function( arg )
 local combi,m,l;
 l:= arg[1];
 m:= Length( l );
 combi:= testttt( m );
 
  return List( combi, h-> List( h, j->l[ AbsInt( j ) ]*j/AbsInt( j )  )   );
 
end);    
  
 
# InstallGlobalFunction( "SolutionPostIntMat",
#                        [ IsList, IsVector ],
#                        
#   function( M, v )
#   local N, new_M, id, P, sol, kern, Ver,u,r;
#   
#    sol:= SolutionNullspaceIntMat(M, v ); 
#   
#    N:= sol[ 1 ];
#   
#    kern:= sol[ 2 ]; 
#   
#    if N = fail then return false;fi;
#   
#    if ForAll(N, n-> n>=0 ) then return true; fi;
# 
#    if Length( kern )= 0 then return false; fi;
#    
#    new_M:= TransposedMat( Concatenation( [ -v ], M ) );
#    id := TransposedMat( Concatenation( [ ListWithIdenticalEntries( Length(M ), 0) ], IdentityMat( Length( M ) ) ) );
# 
#    P:= PolyhedronByInequalities( Concatenation( new_M,-new_M, id ) );
#   
#    u:= VerticesOfMainRatPolytope( P );
#   
#    r:= RayGeneratorsOfTailCone( P );
#   
#    Ver:= LatticePoints( Polytope( Concatenation(u, Iterated(List(u, t-> List( r, w->w+t ) ), Concatenation ) ) ) );
#   
#    return not IsZero( Ver ) and ForAny(Ver, i-> ForAll(i, IsInt ) );
# end );
#   
# InstallGlobalFunction( "IfNotReducedReduceOnce",
#                        [ IsList ],
#                        
# function( N )
# local current_list,i, current_vec, M;
# 
# M:= List( Set( N ) );
# for i in [ 1..Length( M ) ] do
# 
#     current_vec:= M[i];
#     current_list:= ShallowCopy( M );
#     Remove( current_list, i );
#     if Length( AddIfPossible( current_list, current_vec ) )= Length( current_list ) then
#     
#        return [ false, current_list ];
#        
#     fi;
# od;
# 
# return [ true, M ];
# 
# end );
# 
# InstallGlobalFunction( "ReduceTheBase",
#                        [ IsList ],
#   function( M )
#   local current;
#   
#   current:= [ false, M ];
#   
#   while current[ 1 ]=false do
#   
#   current:= IfNotReducedReduceOnce( current[ 2 ] );
#   
#   od;
#   
#   return current;
#   
#   end );


##############################
##
## Methods
##
##############################

##
InstallMethod( FourierProjection,
               [ IsCone, IsInt ],
  function( cone, n )
  local ray_generators, new_rays, i, j;
  
  ray_generators:= RayGenerators( cone );
  
  new_rays:= [ ];
  
  for i in ray_generators do
  
     j:= ShallowCopy( i );
     Remove(j, n );
     Add( new_rays, j );
     
  od;
  
  return Cone( new_rays );
  
end );

InstallMethod( \*,
               [ IsInt, IsCone ],
    function( n, cone )

    if n>0 then
        return cone;
    elif n=0 then
        return Cone( [ List([ 1 .. AmbientSpaceDimension( cone ) ], i-> 0 ) ] );
    else
        return Cone( -RayGenerators( cone ) );
    fi;
    
end );

##
InstallMethod( \*,
               " cartesian product for cones.",
               [ IsCone, IsCone ],
               
  function( cone1, cone2 )
    local rays1, rays2, i, j, raysnew;
    
    rays1 := RayGenerators( cone1 );
    
    rays2 := RayGenerators( cone2 );
    
    rays1 := Concatenation( rays1, [ List( [ 1 .. Length( rays1[ 1 ] ) ], i -> 0 ) ] );
    
    rays2 := Concatenation( rays2, [ List( [ 1 .. Length( rays2[ 1 ] ) ], i -> 0 ) ] );
    
    raysnew := [ 1 .. Length( rays1 ) * Length( rays2 ) ];
    
    for i in [ 1 .. Length( rays1 ) ] do
        
        for j in [ 1 .. Length( rays2 ) ] do
            
            raysnew[ (i-1)*Length( rays2 ) + j ] := Concatenation( rays1[ i ], rays2[ j ] );
            
        od;
        
    od;
    
    raysnew := Cone( raysnew );
    
    SetContainingGrid( raysnew, ContainingGrid( cone1 ) + ContainingGrid( cone2 ) );
    
    return raysnew;
    
end );
 
##
InstallMethod( NonReducedInequalities,
               "for a cone",
               [ IsCone ],
               
  function( cone )
    local inequalities;
    
    if HasDefiningInequalities( cone ) then
        
        return DefiningInequalities( cone );
        
    fi;
    
    inequalities := [ ];
    
    if IsBound( cone!.input_equalities ) then
        
        inequalities := Concatenation( inequalities, cone!.input_equalities, - cone!.input_equalities );
        
    fi;
    
    if IsBound( cone!.input_inequalities ) then
        
        inequalities := Concatenation( inequalities, cone!.input_inequalities );
        
    fi;
    
    if inequalities <> [ ] then
        
        return inequalities;
        
    fi;
    
    return DefiningInequalities( cone );
    
end );

InstallMethod( IntersectionOfCones,
               "for homalg cones",
               [ IsCone and HasDefiningInequalities, IsCone and HasDefiningInequalities ],
               
  function( cone1, cone2 )
    local inequalities, cone;
    
    if not Rank( ContainingGrid( cone1 ) )= Rank( ContainingGrid( cone2 ) ) then
        
        Error( "cones are not from the same grid" );
        
    fi;
    
    inequalities := Unique( Concatenation( [ NonReducedInequalities( cone1 ), NonReducedInequalities( cone2 ) ]  ) );
    
    cone := ConeByInequalities( inequalities );
    
    SetContainingGrid( cone, ContainingGrid( cone1 ) );
    
    return cone;
    
end );

##
InstallMethod( IntersectionOfCones,
               "for homalg cones",
               [ IsCone, IsCone ],
               
  function( cone1, cone2 )
    local cone, ext_cone;
    
    if not Rank( ContainingGrid( cone1 ) )= Rank( ContainingGrid( cone2 ) ) then
        
        Error( "cones are not from the same grid" );
        
    fi;
    
    ext_cone := Cdd_Intersection( ExternalCddCone( cone1), ExternalCddCone( cone2 ) );
    
    cone := Cone( ext_cone );
    
    SetContainingGrid( cone, ContainingGrid( cone1 ) );
    
    return cone;
    
end );

##
InstallMethod( IntersectionOfConelist,
               "for a list of convex cones",
               [ IsList ],
               
  function( list_of_cones )
    local grid, inequalities, equalities, i, cone;
    
    if list_of_cones = [ ] then
        
        Error( "cannot create an empty cone\n" );
        
    fi;
    
    if not ForAll( list_of_cones, IsCone ) then
        
        Error( "not all list elements are cones\n" );
        
    fi;
    
    grid := ContainingGrid( list_of_cones[ 1 ] );
    
  #  if not ForAll( list_of_cones, i -> IsIdenticalObj( ContainingGrid( i ), grid ) ) then
        
  #      Error( "all cones must lie in the same grid\n" );
        
  #  fi;
    
    inequalities := [ ];
    
    equalities := [ ];
    
    for i in list_of_cones do
        
        if HasDefiningInequalities( i ) then
            
            Add( inequalities, DefiningInequalities( i ) );
            
        elif IsBound( i!.input_inequalities ) then
            
            Add( inequalities, i!.input_inequalities );
            
            if IsBound( i!.input_equalities ) then
                
                Add( equalities, i!.input_equalities );
                
            fi;
            
        else
            
            Add( inequalities, DefiningInequalities( i ) );
            
        fi;
        
    od;
    
    if equalities <> [ ] then
        
        cone := ConeByEqualitiesAndInequalities( Concatenation( equalities ), Concatenation( inequalities ) );
        
    else
        
        cone := ConeByInequalities( Concatenation( inequalities ) );
        
    fi;
    
    SetContainingGrid( cone, grid );
    
    return cone;
    
end );

##
InstallMethod( Intersect2,
               "for convex cones",
               [ IsCone, IsCone ],
               
  IntersectionOfCones
  
);

##
InstallMethod( Contains,
               " for homalg cones",
               [ IsCone, IsCone ],
               
  function( ambcone, cone )
    local ineq;
    
    ineq := NonReducedInequalities( ambcone );
    
    cone := RayGenerators( cone );
    
    ineq := List( cone, i -> ineq * i );
    
    ineq := Flat( ineq );
    
    return ForAll( ineq, i -> i >= 0 );
    
end );

##
InstallMethod( \*,
               "for a matrix and a cone",
               [ IsHomalgMatrix, IsCone ],
               
  function( matrix, cone )
    local ray_list, multiplied_rays, ring, new_cone;
    
    ring := HomalgRing( matrix );
    
    ray_list := RayGenerators( cone );
    
    ray_list := List( ray_list, i -> HomalgMatrix( i, ring ) );
    
    multiplied_rays := List( ray_list, i -> matrix * i );
    
    multiplied_rays := List( multiplied_rays, i -> EntriesOfHomalgMatrix( i ) );
    
    new_cone := Cone( multiplied_rays );
    
    SetContainingGrid( new_cone, ContainingGrid( cone ) );
    
    return new_cone;
    
end );



##
InstallMethod( \=,
               "for two cones",
               [ IsCone, IsCone ],
               
  function( cone1, cone2 )
    
    return Contains( cone1, cone2 ) and Contains( cone2, cone1 );
    
end );


##
InstallMethod( \in,
               "for ray generator and cone",
               [ IsList, IsCone ],
               
RayGeneratorContainedInCone

);

InstallMethod( \in,
               " to see if a cone belongs to a list of cones",
               [ IsCone, IsList ],
  function( cone, cones_list )
  local l;
  
  return ForAll( cones_list, i-> cone = i );

end );


##
InstallMethod( RayGeneratorContainedInCone,
               "for cones",
               [ IsList, IsCone ],
               
  function( raygen, cone )
    local ineq;
    
    ineq := NonReducedInequalities( cone );
    
    ineq := List( ineq, i -> Sum( [ 1 .. Length( i ) ], j -> i[ j ]*raygen[ j ] ) );
    
    return ForAll( ineq, i -> i >= 0 );
    
end );

##
InstallMethod( RayGeneratorContainedInCone,
               "for cones",
               [ IsList, IsCone and IsSimplicial ],
               
  function( raygen, cone )
    local ray_generators, matrix;
    
    ray_generators := RayGenerators( cone );
    
    ##FIXME: One can use homalg for this, but at the moment
    ##       we do not want the overhead.
    matrix := SolutionMat( ray_generators, raygen );
    
    return ForAll( matrix, i -> i >= 0 );
    
end );

##
InstallMethod( RayGeneratorContainedInRelativeInterior,
               "for cones",
               [ IsList, IsCone ],
               
  function( raygen, cone )
    local ineq, mineq, equations;
    
    ineq := NonReducedInequalities( cone );
    
    mineq := -ineq;
    
    equations := Intersection( ineq, mineq );
    
    ineq := Difference( ineq, equations );
    
    ineq := List( ineq, i -> i * raygen );
    
    equations := List( equations, i -> i * raygen );
    
    return ForAll( ineq, i -> i > 0 ) and ForAll( equations, i -> i = 0 );
    
end );


#######################################
##
## Methods to construct external cones
##
#######################################

InstallMethod( ExternalCddCone, 
               [ IsCone ], 
               
   function( cone )
   
   local list, new_list, number_of_equalities, linearity, i, u ;
   
   new_list:= [ ];
   if IsBound( cone!.input_rays ) and Length( cone!.input_rays )= 1 and IsZero( cone!.input_rays ) then
   
      new_list:= [ Concatenation( [ 1 ], cone!.input_rays[ 1 ] ) ];
      
      return Cdd_PolyhedronByGenerators( new_list );
      
   fi;
   
   if IsBound( cone!.input_rays ) then 
   
      list := cone!.input_rays;
      
      for i in [1..Length( list ) ] do 
          
          u:= ShallowCopy( list[ i ] );
          
          Add( u, 0, 1 );
          
          Add( new_list, u );
      
      od;
      
      return Cdd_PolyhedronByGenerators( new_list );
   
   fi;
   
   
   if IsBound( cone!.input_equalities ) then
   
      list := StructuralCopy( cone!.input_equalities );
      
      number_of_equalities:= Length( list );
      
      linearity := [1..number_of_equalities];
      
      Append( list, StructuralCopy( cone!.input_inequalities ) );
      
      for i in [1..Length( list ) ] do 
      
          u:= ShallowCopy( list[ i ] );
          
          Add( u, 0, 1 );
          
          Add( new_list, u );
      
      od;
      
      return Cdd_PolyhedronByInequalities( new_list, linearity );
   
   else 
   
      list:= StructuralCopy( cone!.input_inequalities );
      
      for i in [1..Length( list ) ] do 
          
          u:= ShallowCopy( list[ i ] );
          
          Add( u, 0, 1 );
          
          Add( new_list, u );
          
      od;
      
      return Cdd_PolyhedronByInequalities( new_list );
   
   fi;
   
end );
   
      
InstallMethod( ExternalNmzCone, 
              [ IsCone ],
  function( cone )
  local a, list, equalities, i;
  
  list:= [];
   
   if IsBound( cone!.input_rays ) then 
   
        list := StructuralCopy( cone!.input_rays );
        
        if ForAll( Concatenation( list ), IsInt ) then

            return NmzCone( [ "integral_closure", list ] );
        
        else

            a := DuplicateFreeList( List( Concatenation( list ), l -> DenominatorRat( l ) ) );
            
            a := Iterated( a, LCM_INT );
            
            list := a*list;

            return NmzCone( [ "integral_closure", list ] );

        fi;

   fi;
   
   list:= StructuralCopy( cone!.input_inequalities );
   
   if IsBound( cone!.input_equalities ) then
      
      equalities:= StructuralCopy( cone!.input_equalities );
      
      for i in equalities do
      
          Append( list, [ i, -i ] );
          
      od;
      
   fi;
      
    if ForAll( Concatenation( list ), IsInt ) then

        return NmzCone( ["inequalities", list ] );
        
    else

        a := DuplicateFreeList( List( Concatenation( list ), l -> DenominatorRat( l ) ) );
            
        a := Iterated( a, LCM_INT );
            
        list := a*list;

        return NmzCone( ["inequalities", list ] );

    fi;

    Error( "The cone should be defined by vertices or inequalities!" );
    
end );

#####################################
##
## Constructors
##
#####################################

##
InstallMethod( ConeByInequalities,
               "constructor for Cones by inequalities",
               [ IsList ],
               
  function( inequalities )
    local cone, newgens, i, vals;
    
     if Length( inequalities ) = 0 then
        
        Error( "someone must set a dimension\n" );
        
    fi;
    
    cone := rec( input_inequalities := inequalities );
    
    ObjectifyWithAttributes( 
        cone, TheTypeConvexCone
     );
    
    SetAmbientSpaceDimension( cone, Length( inequalities[ 1 ] ) );
    
    return cone;
    
end );

##
InstallMethod( ConeByEqualitiesAndInequalities,
               "constructor for cones by equalities and inequalities",
               [ IsList, IsList ],
               
  function( equalities, inequalities )
    local cone, newgens, i, vals;
    
    if Length( equalities ) = 0 and Length( inequalities ) = 0 then
        
        Error( "someone must set a dimension\n" );
        
    fi;
    
    cone := rec( input_inequalities := inequalities, input_equalities := equalities );
    
    ObjectifyWithAttributes( 
        cone, TheTypeConvexCone
     );
    
    if Length( equalities ) > 0 then
        
        SetAmbientSpaceDimension( cone, Length( equalities[ 1 ] ) );
        
    else
        
        SetAmbientSpaceDimension( cone, Length( inequalities[ 1 ] ) );
        
    fi;
    
    return cone;
    
end );
 
##
InstallMethod( ConeByGenerators,
               "constructor for cones by generators",
               [ IsList ],
               
   function( raylist )
    local cone, newgens, i, vals;
    
    if Length( raylist ) = 0 then
        
        # Think again about this
        return ConeByGenerators( [ [ ] ] );
        
    fi;

    newgens := [ ];
    
    for i in raylist do
        
        if IsList( i ) then
            
            Add( newgens, i );
            
        elif IsCone( i ) then
            
            Append( newgens, RayGenerators( i ) );
            
        else
            
            Error( " wrong rays" );
            
        fi;
        
    od;
    
    cone := rec( input_rays := newgens );
   
    ObjectifyWithAttributes( 
        cone, TheTypeConvexCone
     );
      
     if Length( raylist ) =1 and IsZero( raylist[ 1 ] ) then 
        
        SetIsZero( cone, true );
        
     fi;
     
    newgens := Set( newgens );
    
    SetAmbientSpaceDimension( cone, Length( newgens[ 1 ] ) );
    
    if Length( newgens ) = 1 and not Set( newgens[ 1 ] ) = [ 0 ] then
        
        SetIsRay( cone, true );
        
    else
        
        SetIsRay( cone, false );
        
    fi;
    
    return cone;
    
end );

##
InstallMethod( Cone,
              "construct cone from list of generating rays",
                  [ IsList ],
                  
      ConeByGenerators

    );
   
InstallMethod( Cone, 
              "Construct cone from Cdd cone",
              [ IsCddPolyhedron ],
              
   function( cdd_cone )
   local inequalities, equalities, 
         new_inequalities, new_equalities, u, i;
   
   if cdd_cone!.rep_type = "H-rep" then 
       
           inequalities:= Cdd_Inequalities( cdd_cone );
           
           new_inequalities:= [ ];
           
           for i in inequalities do 
                
                 u:= ShallowCopy( i );
                
                 Remove( u , 1 );
                
                 Add(new_inequalities, u );
               
           od;
           
           if cdd_cone!.linearity <> [] then
               
                 equalities:= Cdd_Equalities( cdd_cone );
                 
                 new_equalities:= [ ];
                 
                 for i in equalities do 
                    
                     u:= ShallowCopy( i );
                     
                     Remove( u , 1 );
                     
                     Add(new_equalities, u );
                    
                 od;
                 
                 return ConeByEqualitiesAndInequalities( new_equalities, new_inequalities);
                 
           fi;
           
           return ConeByInequalities( new_inequalities );
           
    else 
    
           return ConeByGenerators( Cdd_GeneratingRays( cdd_cone ) );
           
    fi;
    
end );
   


################################
##
## Displays and Views
##
################################

##
InstallMethod( ViewObj,
               "for homalg cones",
               [ IsCone ],
               
  function( cone )
    local str;
    
    Print( "<A" );
    
    if HasIsSmooth( cone ) then
        
        if IsSmooth( cone ) then
            
            Print( " smooth" );
            
        fi;
        
    fi;
    
    if HasIsPointed( cone ) then
        
        if IsPointed( cone ) then
            
            Print( " pointed" );
            
        fi;
        
    fi;
    
    if HasIsSimplicial( cone ) then
        
        if IsSimplicial( cone ) then
            
            Print( " simplicial" );
            
        fi;
        
    fi;
    
    if HasIsRay( cone ) and IsRay( cone ) then
        
        Print( " ray" );
        
    else
        
        Print( " cone" );
        
    fi;
    
    Print( " in |R^" );
    
    Print( String( AmbientSpaceDimension( cone ) ) );
    
    if HasDimension( cone ) then
        
        Print( " of dimension ", String( Dimension( cone ) ) );
        
    fi;
    
    if HasRayGenerators( cone ) then
        
        Print( " with ", String( Length( RayGenerators( cone ) ) )," ray generators" );
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for homalg cones",
               [ IsCone ],
               
  function( cone )
    local str;
    
    Print( "A" );
    
    if HasIsSmooth( cone ) then
        
        if IsSmooth( cone ) then
            
            Print( " smooth" );
            
        fi;
        
    fi;
    
    if HasIsPointed( cone ) then
        
        if IsPointed( cone ) then
            
            Print( " pointed" );
            
        fi;
        
    fi;
    
    if IsRay( cone ) then
        
        Print( " ray" );
        
    else
        
        Print( " cone" );
        
    fi;
    
    Print( " in |R^" );
    
    Print( String( AmbientSpaceDimension( cone ) ) );
    
    if HasDimension( cone ) then
        
        Print( " of dimension ", String( Dimension( cone ) ) );
        
    fi;
    
    if HasRayGenerators( cone ) then
        
        Print( " with ray generators ", String( RayGenerators( cone ) ) );
        
    fi;
    
    Print( ".\n" );
    
end );
