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

DeclareProperty( "IsEmpty",
                 IsPolytope );


##  <#GAPDoc Label="IsNotEmpty">
##  <ManSection>
##    <Prop Arg="poly" Name="IsNotEmpty"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the polytope <A>poly</A> is not empty.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsNotEmpty",
                 IsPolytope );

##  <#GAPDoc Label="IsLatticePolytope">
##  <ManSection>
##    <Prop Arg="poly" Name="IsLatticePolytope"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the polytope <A>poly</A> is a lattice polytope, i.e. all its vertices are lattice points.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLatticePolytope",
                 IsPolytope );

##  <#GAPDoc Label="IsVeryAmple">
##  <ManSection>
##    <Prop Arg="poly" Name="IsVeryAmple"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the polytope <A>poly</A> is very ample.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsVeryAmple",
                 IsPolytope );

##  <#GAPDoc Label="IsNormalPolytope">
##  <ManSection>
##    <Prop Arg="poly" Name="IsNormalPolytope"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the polytope <A>poly</A> is normal.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsNormalPolytope",
                 IsPolytope );

##  <#GAPDoc Label="IsSimplicialPolytope">
##  <ManSection>
##    <Prop Arg="poly" Name="IsSimplicial" Label="for a polytope"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the polytope <A>poly</A> is simplicial.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSimplicial",
                 IsPolytope );

##  <#GAPDoc Label="IsSimplePolytope">
##  <ManSection>
##    <Prop Arg="poly" Name="IsSimplePolytope"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the polytope <A>poly</A> is simple.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSimplePolytope",
                 IsPolytope );
                 
                 
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

################################
##
## Methods
##
################################

##  <#GAPDoc Label="PROD">
##  <ManSection>
##    <Oper Arg="polytope1,polytope2" Name="*" Label="for polytopes"/>
##    <Returns>a polytope</Returns>
##    <Description>
##      Returns the Cartesian product of the polytopes <A>polytope1</A> and <A>polytope2</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "\*",
                  [ IsPolytope, IsPolytope ] );

DeclareOperation( "\*",
                  [ IsInt, IsPolytope ] );

DeclareOperation( "\*",
                  [ IsPolytope, IsInt ] );

DeclareOperation( "\+",
                  [ IsPolytope, IsPolytope ] );         
                  
DeclareOperation( "IntersectionOfPolytopes",
                  [ IsPolytope, IsPolytope ] );
                  
DeclareOperation( "Points", 
                  [ IsList, IsList] );

DeclareOperation( "FourierProjection", 
                  [ IsPolytope, IsInt ] );
