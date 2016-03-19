#############################################################################
##
##  Fan.gi         NConvex package                 Sebastian Gutsche
##                                                 Kamal Saleh
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Fans for NConvex package.
##
#############################################################################

####################################
##
## Reps
##
####################################

DeclareRepresentation( "IsExternalFanRep",
                       IsFan and IsExternalConvexObjectRep,
                       [ ]
                      );

DeclareRepresentation( "IsConvexFanRep",
                       IsExternalFanRep,
                       [ ]
                      );

DeclareRepresentation( "IsInternalFanRep",
                       IsFan and IsInternalConvexObjectRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfFans",
        NewFamily( "TheFamilyOfFans" , IsFan ) );

BindGlobal( "TheTypeExternalFan",
        NewType( TheFamilyOfFans,
                 IsFan and IsExternalFanRep ) );

BindGlobal( "TheTypeConvexFan",
        NewType( TheFamilyOfFans,
                 IsConvexFanRep ) );

BindGlobal( "TheTypeInternalFan",
        NewType( TheFamilyOfFans,
                 IsInternalFanRep ) );
                 
####################################
##
## Constructors
##
####################################

##
InstallMethod( Fan,
               " for cones",
               [ IsList ],
               
  function( cones )
    local newgens, i, point, extobj, type;
    
    if Length( cones ) = 0 then
        
        Error( " no empty fans allowed." );
        
    fi;
    
    newgens := [ ];
    
    for i in cones do
        
        if IsCone( i ) then
            
            if IsBound( i!.input_rays ) then
                
                Add( newgens, i!.input_rays );
                
            else
                
                Add( newgens, RayGenerators( i ) );
                
            fi;
            
        elif IsList( i ) then
            
            Add( newgens, i );
            
        else
            
            Error( " wrong cones inserted" );
            
        fi;
        
    od;
    
    point := rec( input_cone_list := newgens );
    
    ObjectifyWithAttributes(
        point, TheTypeInternalFan
        );
    
    SetAmbientSpaceDimension( point, Length( newgens[ 1 ][ 1 ] ) );
    
    return point;
    
end );

##
InstallMethod( Fan,
               " for homalg fans",
               [ IsFan ],
               
  IdFunc
  
);


##
InstallMethod( Fan,
               "for rays and cones.",
               [ IsList, IsList ],
               
  function( rays, cones )
    local point, indices;
    
    if Length( cones ) = 0 or Length( rays ) = 0 then
        
        Error( "fan has to have the trivial cone.\n" );
        
    fi;
    
    indices := Set( Flat( cones ) );
    
    if not ForAll( indices, i -> i > 0 and i<= Length( rays ) ) then 
   
              Error( "wrong cones inserted \n" );
              
    fi;
    
    point := rec( input_rays := rays, input_cones := cones );
    
    ObjectifyWithAttributes(
        point, TheTypeConvexFan
        );
     
    
    SetAmbientSpaceDimension( point, Length( rays[ 1 ] ) );
    
    return point;
    
end );


##
InstallMethod( FanWithFixedRays,
               "for rays and cones.",
               [ IsList, IsList ],
               
  Fan
  
);

##############################
##
##  Attributes
##
##############################


InstallMethod( RayGenerators, 
               "for fans",
               [ IsFan ], 
  function( fan )
  
  return RayGenerators( CanonicalizeFan( fan ) );
  
end );

InstallMethod( RaysInMaximalCones, 
               [ IsFan ], 
               
  function( fan )

  return RaysInMaximalCones( CanonicalizeFan( fan ) );
  
end );

##
InstallMethod( GivenRayGenerators,
               "for external fans.",
               [ IsFan ],
               
  function( fan )
    
    if IsBound( fan!.input_rays ) then
        
        return fan!.input_rays;
        
    elif IsBound( fan!.input_cone_list ) then
        
        return List( Set( Union( fan!.input_cone_list ) ) );
        
    else
        
        Error( "Something went wrong." );
        
    fi;
    
end );

##
InstallMethod( Rays,
               "for fans.",
               [ IsFan ],
               
  function( fan )
    local rays;
    
    rays := RayGenerators( fan );
    
    rays := List( rays, i -> Cone( [ i ] ) );
    
    List( rays, function( i ) SetContainingGrid( i, ContainingGrid( fan ) ); return 0; end );
    
    return rays;
    
end );

## This function ignore the small cones which live in some other cone.

InstallMethod( RaysInTheGivenMaximalCones,
               "for fans",
               [ IsFan ],
               
  function( fan )
    local rays, cones, i, j;
    
    if IsBound( fan!.input_cones ) and IsBound( fan!.input_rays ) then
        
        rays := GivenRayGenerators( fan );
        
        cones := List( [ 1 .. Length( fan!.input_cones ) ], i -> List( [ 1 .. Length( rays ) ], j -> 0 ) );
        
        for i in [ 1 .. Length( fan!.input_cones ) ] do
            
            for j in fan!.input_cones[ i ] do
                
                cones[ i ][ j ] := 1;
                
            od;
            
        od;
        
        return ListOfMaximalConesInList( cones );
        
    fi;
    
    if IsBound( fan!.input_cone_list ) then
        
        rays := GivenRayGenerators( fan );
        
        ## Dont use ListWithIdenticalEntries here since it has new sideeffects.
        cones := List( [ 1 .. Length( fan!.input_cone_list ) ], i -> List( [ 1 .. Length( rays ) ], j -> 0 ) );
        
        for i in [ 1 .. Length( fan!.input_cone_list ) ] do
            
            for j in [ 1 .. Length( rays ) ] do
                
                if rays[ j ] in fan!.input_cone_list[ i ] then
                    
                    cones[ i ][ j ] := 1;
                    
                fi;
                
            od;
            
        od;
        
        return ListOfMaximalConesInList( cones );
        
    fi;
    
end );

InstallMethod( MaximalCones,
               "for external fans.",
               [ IsFan ],
               
  function( fan )
    local raylist, rays, conelist, i, lis, j;
    
    raylist := RaysInMaximalCones( fan );
    
    rays := RayGenerators( fan );
    
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
    
    conelist := List( conelist, Cone );
    
    Perform( conelist, function( i ) SetContainingGrid( i, ContainingGrid( fan ) ); return 0; end );
    
    Perform( conelist, function( i ) SetIsContainedInFan( i, fan ); return 0; end );
    
    return conelist;
    
end );

##
InstallMethod( MaximalCones,
               [ IsFan, IsInt],
               
  function( fan, n )
  local all_max_cones, new_list, i; 
  
  all_max_cones:= MaximalCones( fan );
  
  new_list:= [ ];
  
  for i in all_max_cones do
  
      if Dimension( i ) = n then Add( new_list, i ); fi;
      
  od;
  
  return new_list;
  
end );

##
InstallMethod( GivenMaximalCones,
               "for external fans.",
               [ IsFan ],
               
  function( fan )
    local raylist, rays, conelist, i, lis, j;
    
    raylist := RaysInTheGivenMaximalCones( fan );
    
    rays := GivenRayGenerators( fan );
    
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
    
    conelist := List( conelist, Cone );
    
    Perform( conelist, function( i ) SetContainingGrid( i, ContainingGrid( fan ) ); return 0; end );
    
    Perform( conelist, function( i ) SetIsContainedInFan( i, fan ); return 0; end );
    
    return conelist;
    
end );

InstallMethod( CanonicalizeFan, 
               [ IsFan ],
 
 function( fan )
 local list_of_max, new_gen, cones,i,j, F, max_cones, rays_in_max_cones; 
 
 list_of_max:= GivenMaximalCones( fan );
 
 new_gen:= [ ];
 
 for i in list_of_max do 
 
     Append( new_gen, RayGenerators( i ) );
     
 od;
 
 new_gen:= List( Set( new_gen ) );
 
 cones := List( [ 1 .. Length( list_of_max ) ], i -> List( [ 1 .. Length( new_gen ) ], j -> 0 ) );
      
 for i in [ 1 .. Length( list_of_max ) ] do
            
        for j in [ 1 .. Length( new_gen ) ] do
                
                if new_gen[ j ] in RayGenerators( list_of_max[ i ] ) then
                    
                    cones[ i ][ j ] := 1;
                    
                fi;
                
        od;
            
 od;

 max_cones:= ListOfMaximalConesInList( cones );
 
 rays_in_max_cones:= [ ];
 
 for i in [ 1..Length( max_cones ) ] do
        
        Add( rays_in_max_cones, [ ] );
        
        for j in [ 1..Length( new_gen ) ] do 
        
             if max_cones[ i ][ j ] =1 then Add( rays_in_max_cones[ i ], j ); fi;
              
        od;
        
 od;
 
 F:= Fan( new_gen, rays_in_max_cones );
 
 SetRayGenerators( F, new_gen );
 
 SetRaysInMaximalCones( F, max_cones );

 return F;
 
 end );
 

InstallMethod( AllCones,
               [ IsFan ],
 
 function( fan )
 local max_cones, cones,current_list_of_faces, i, j;
 
 
 max_cones:= MaximalCones( fan );
 
 cones:= [ ];
 
 for i in max_cones do 
 
    current_list_of_faces:= Faces( i );
    
    for j in current_list_of_faces do 
    
       if not j in cones then 
       
            Add( cones, j );
            
       fi;
       
    od;
    
 od;
 
 return cones;
 
end );


InstallMethod( FVector, 
               [ IsFan ], 
  function( fan )
  local dim_of_cones; 
  
  dim_of_cones := List( AllCones( fan ), Dimension );
  
  return List( [ 1.. Dimension( fan ) ], i-> Length( Positions( dim_of_cones, i ) ) );
  
end );
 
##
InstallMethod( Dimension,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return Maximum( List(MaximalCones( fan ), i-> Dimension( i ) ) );
    
end );

##
InstallMethod( AmbientSpaceDimension,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return Length( RayGenerators( fan )[ 1 ] );
    
end );

#########################
##
##  Properties
##
#########################

InstallMethod( IsItReallyFan, 
               [ IsFan ],
  
  function( fan )
  local L, max_cones, combi;
  
  max_cones:= MaximalCones( fan );
  
  combi := Combinations( [1..Length( max_cones) ], 2 );
  
  L:= ForAll( combi, function( i)
                     local u;
                     
                     u:= IntersectionOfCones( max_cones[ i[ 1 ] ], max_cones[ i[ 2 ] ] );
                     
                     if u in Faces( max_cones[ i[ 1 ] ] ) and u in Faces( max_cones[ i[ 2 ] ] ) then 
                     
                         return true ;
                         
                     else 
                     
                         return false;
                         
                     fi;
                     
                     return true;
   
                     end );
  
  return L;
  
end );

##
InstallMethod( IsComplete, 
               [ IsFan ], 
  function( fan )
  local list_of_cones, current_facets, number_of_cones_containing_j,u,i,j;
  
  if Dimension( fan ) < AmbientSpaceDimension( fan ) then 
         
         return false;
  
  fi;
  
  list_of_cones:= MaximalCones( fan, AmbientSpaceDimension( fan ) );
  
  for i in  list_of_cones do
  
      current_facets:= Facets( i );
      
      for j in current_facets do 
      
           number_of_cones_containing_j:=
            
             Sum( List( list_of_cones, function( u )
                                
                                       if Contains( u, j ) then 
                                
                                          return 1;
                                      
                                       else 
                                
                                          return 0;
                                     
                                       fi;
                                
                                       end ) );
           
           if number_of_cones_containing_j < 2 then 
           
                       return false;
                       
           fi;
      od;
      
   od;
   
   return true;
   
   end );
   
##
InstallMethod( IsPointed,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return ForAll( MaximalCones( fan ), IsPointed );
    
end );

##
InstallMethod( IsSmooth,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return ForAll( MaximalCones( fan ), IsSmooth );
    
end );

InstallMethod( IsRegularFan,
                " for fans",
                [ IsFan ],
  IsSmooth );              

##
InstallMethod( IsFullDimensional,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return ForAny( MaximalCones( fan ), i -> Dimension( i ) = AmbientSpaceDimension( i ) );
    
end );


##
InstallMethod( IsSimplicial,
               " for homalg fans",
               [ IsFan ],
               
  function( fan )
    
    fan := MaximalCones( fan );
    
    return ForAll( fan, IsSimplicial );
    
end );

#########################
##
##  Methods
##
#########################
      
##
InstallMethod( \*,
               "for fans.",
               [ IsFan, IsFan ],
               
  function( fan1, fan2 )
    local rays1, rays2, m1, m2, new_m, new_rays, cones1, cones2, i, j, k, new_cones, akt_cone, new_fan;
    
    rays1 := RayGenerators( fan1 );
    
    rays2 := RayGenerators( fan2 );
    
    m1 := Rank( ContainingGrid( fan1 ) );
    
    m2 := Rank( ContainingGrid( fan2 ) );
    
    m1 := List( [ 1 .. m1 ], i -> 0 );
    
    m2 := List( [ 1 .. m2 ], i -> 0 );
    
    rays1 := List( rays1, i -> Concatenation( i, m2 ) );
    
    rays2 := List( rays2, i -> Concatenation( m1, i ) );
    
    new_rays := Concatenation( rays1, rays2 );
    
    cones1 := RaysInMaximalCones( fan1 );
    
    cones2 := RaysInMaximalCones( fan2 );
    
    new_cones := [ ];
    
    m1 := Length( rays1 );
    
    m2 := Length( rays2 );
    
    for i in cones1 do
        
        for j in cones2 do
            
            akt_cone := [ ];
            
            for k in [ 1 .. m1 ] do
                
                if i[ k ] = 1 then
                    
                    Add( akt_cone, k );
                    
                fi;
                
            od;
            
            for k in [ 1 .. m2 ] do
                
                if j[ k ] = 1 then
                    
                    Add( akt_cone, k + m1 );
                    
                fi;
                
            od;
            
            Add( new_cones, akt_cone );
            
        od;
        
    od;
    
    new_fan := FanWithFixedRays( new_rays, new_cones );
    
    SetContainingGrid( new_fan, ContainingGrid( fan1 ) + ContainingGrid( fan2 ) );
    
    return new_fan;
    
end );

##
##
InstallMethod( ToricStarFan,
               "for fans",
               [ IsFan, IsCone ],
               
  function( fan, cone )
    local maximal_cones, rays_of_cone, defining_inequalities, value_list, cone_list, i, j, breaker;
    
    maximal_cones := MaximalCones( fan );
    
    rays_of_cone := RayGenerators( cone );
    
    cone_list := [ ];
    
    breaker := false;
    
    for i in maximal_cones do
        
        defining_inequalities := DefiningInequalities( i );
        
        for j in rays_of_cone do
            
            value_list := List( defining_inequalities, k -> k * j );
            
            if not ForAll( value_list, k -> k >= 0 ) or not 0 in value_list then
                
                breaker := true;
                
                continue;
                
            fi;
            
        od;
        
        if breaker then
            
            breaker := false;
            
            continue;
            
        fi;
        
        Add( cone_list, cone );
        
    od;
    
    cone_list := Fan( cone_list );
    
    SetContainingGrid( cone_list, ContainingGrid( fan ) );
    
end );
##
InstallMethod( \*,
               "for homalg fans.",
               [ IsCone, IsFan ],
               
  function( cone, fan )
    
    return Fan( [ cone ] ) * fan;
    
end );

##
InstallMethod( \*,
               "for homalg fans.",
               [ IsFan, IsCone ],
               
  function( fan, cone )
    
    return fan * Fan( [ cone ] );
    
end );

##
InstallMethod( ToricStarFan,
               "for fans",
               [ IsFan, IsCone ],
               
  function( fan, cone )
    local maximal_cones, rays_of_cone, defining_inequalities, value_list, cone_list, i, j, breaker;
    
    maximal_cones := MaximalCones( fan );
    
    rays_of_cone := RayGenerators( cone );
    
    cone_list := [ ];
    
    breaker := false;
    
    for i in maximal_cones do
        
        defining_inequalities := DefiningInequalities( i );
        
        for j in rays_of_cone do
            
            value_list := List( defining_inequalities, k -> k * j );
            
            if not ForAll( value_list, k -> k >= 0 ) or not 0 in value_list then
                
                breaker := true;
                
                continue;
                
            fi;
            
        od;
        
        if breaker then
            
            breaker := false;
            
            continue;
            
        fi;
        
        Add( cone_list, cone );
        
    od;
    
    cone_list := Fan( cone_list );
    
    SetContainingGrid( cone_list, ContainingGrid( fan ) );
    
    return cone_list;
    
end );
      
#########################
##
##  Simple functions
##
#########################

InstallMethod( FirstLessTheSecond,
               [ IsList, IsList],
               
 function( u,v)
 local x;
 
 x:= List( [ 1..Length( u) ], i-> u[i]<=v[i] );
 
 if false in x then 
 
        return false; 
        
 else 
 
        return true;
   
 fi;
 
end );


InstallMethod( OneMaximalConeInList,
              [ IsList ],
 function( u )
 local list, max, new_u, i;
 
 new_u:= List( Set( ShallowCopy( u ) ) );
 
 max:= ShallowCopy( new_u[1] );
 
 for i in new_u do
 
     if FirstLessTheSecond( max, i ) then 
            
            max:= ShallowCopy( i );
            
     fi;
 
 od;
 
 list := [ ];
 
 for i in new_u do 
 
      if FirstLessTheSecond( i, max ) then 
 
           Add( list, i );
           
      fi;
      
  od;
 
 return [ max, list ];
 
 end );
            
InstallMethod( ListOfMaximalConesInList,
               [ IsList ],
               
  function( L )
  local list_of_max, current, new_L;
  
  list_of_max := [ ];
  
  new_L:= Set( L  );
  
  while Length( new_L )<> 0 do
  
      current:= OneMaximalConeInList( new_L );
      
      Add( list_of_max, current[ 1 ] );
      
      SubtractSet( new_L, current[ 2] );
      
  od;
  
  return list_of_max;
  
  end );
  
####################################
##
## Display Methods
##
####################################

##
InstallMethod( ViewObj,
               "for homalg fans",
               [ IsFan ],
               
  function( fan )
    local str;
    
    Print( "<A" );
    
    if HasIsComplete( fan ) then
        
        if IsComplete( fan ) then
            
            Print( " complete" );
            
        fi;
    
    fi;
    
    if HasIsPointed( fan ) then
        
        if IsPointed( fan ) then
            
            Print( " pointed" );
            
        fi;
    
    fi;
      
    if HasIsSmooth( fan ) then
        
        if IsSmooth( fan ) then
            
            Print( " smooth" );
            
        fi;
    
    fi;
    
    Print( " fan in |R^" );
    
    Print( String( AmbientSpaceDimension( fan ) ) );
    
    if HasRays( fan ) then
        
        Print( " with ", String( Length( Rays( fan ) ) )," rays" );
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for homalg polytopes",
               [ IsFan ],
               
  function( fan )
    local str;
    
    Print( "A" );
    
    if HasIsComplete( fan ) then
        
        if IsComplete( fan ) then
            
            Print( " complete" );
            
        fi;
    
    fi;
    
    Print( " fan in |R^" );
    
    Print( String( AmbientSpaceDimension( fan ) ) );
    
    if HasRays( fan ) then
        
        Print( " with ", String( Length( Rays( fan ) ) )," rays" );
        
    fi;
    
    Print( ".\n" );
    
end );
