##############################################################################
##
##  Polytope.gd         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Cones for ConvexForHomalg.
##
#############################################################################

##  <#GAPDoc Label="IsPolytope">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsPolytope"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of a polytope. Every polytope is a convex object.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsPolytope",
                 IsConvexObject );

####################################
##
## Constructors
##
####################################

DeclareOperation( "Polytope",
                  [ IsList ] );
                  
DeclareOperation( "PolytopeByInequalities",
                  [ IsList ] );
                  
####################################
##
## Attributes
##
####################################

DeclareAttribute( "ExternalCddPolytope",
                    IsPolytope );
                    
DeclareAttribute( "LatticePoints",
                    IsPolytope );
DeclareAttribute( "RelativeInteriorLatticePoints",
                    IsPolytope );

DeclareAttribute( "LatticePointsGenerators",
                    IsPolytope );
  
DeclareAttribute( "VerticesOfPolytope",
                    IsPolytope );
                    
DeclareAttribute( "FacetInequalities",
                    IsPolytope );
                    
DeclareAttribute( "EqualitiesOfPolytope",
                    IsPolytope );

DeclareAttribute( "DefiningInequalities",
                    IsPolytope );
                    
DeclareAttribute( "VerticesInFacets",
                    IsPolytope );
                    
DeclareAttribute( "NormalFan",
                    IsPolytope );

DeclareAttribute( "AffineCone",
                    IsPolytope );
                    
####################################
##
## Properties
##
####################################


DeclareProperty( "IsBounded",
                 IsPolytope );
                 
####################################
##
##  Operations
##
####################################


DeclareOperation( "Vertices",
                  [ IsPolytope ] );
                  
DeclareOperation( "HasVertices",
                  [ IsPolytope ] );
