#############################################################################
##
##  NPolytope.gd         NConvex package            Sebastian Gutsche
##                                                  Kamal Saleh
##
##  Copyright 2019 Mathematics Faculty, Siegen University, Germany
##
##  Fans for NConvex package.
##
#############################################################################



DeclareCategory( "IsPolytope",
                 IsConvexObject );

####################################
##
## Constructors
##
####################################

#! @Chapter Polytopes
#! @Section Creating polytopes

#! @Arguments arg 
#! @Returns a **Polytope** Object
#! @Description  
#! The function takes a list of lists $[L_1, L_2, ...]$ where each $L_j$ represents 
#! an inequality and returns the polytope defined by them (if they define a polytope). 
#! For example the $j$'th entry $L_j = [c_j,a_{j1},a_{j2},...,a_{jn}]$ corresponds to the inequality
#! $c_j+\sum_{i=1}^n a_{ji}x_i \geq 0$.
DeclareOperation( "PolytopeByInequalities",
                  [ IsList ] );
#! @Arguments arg 
#! @Returns a **Polytope** Object
#! @Description  
#! The function takes the list of the vertices and returns the polytope defined by them.
DeclareOperation( "Polytope",
                  [ IsList ] );

                  
####################################
##
## Attributes
##
####################################

#! @Section Attributes

#! @Arguments polytope 
#! @Returns a CddPolyhedron
#! @Description  
#! Converts the polytope to a CddPolyhedron. The functions of CddInterface can then be applied
#! on this polyhedron.
DeclareAttribute( "ExternalCddPolytope",
                    IsPolytope );

#! @Arguments polytope 
#! @Returns a List
#! @Description  
#! The function returns the list of integer points inside the polytope.                    
DeclareAttribute( "LatticePoints",
                    IsPolytope );
  
#! @Arguments polytope 
#! @Returns a List
#! @Description  
#! The function returns the interior lattice points inside the polytope.                    
DeclareAttribute( "RelativeInteriorLatticePoints",
                    IsPolytope );
 
DeclareAttribute( "LatticePointsGenerators",
                    IsPolytope );

#! @Arguments polytope 
#! @Returns a list of lists
#! @Description  
#! The function returns the vertices of the polytope  
DeclareAttribute( "VerticesOfPolytope",
                    IsPolytope );

#! @Arguments polytope 
#! @Returns a list of lists
#! @Description  
#! The same output as <C>VerticesOfPolytope</C>.
DeclareOperation( "Vertices",
                  [ IsPolytope ] );
                  
DeclareOperation( "HasVertices",
                  [ IsPolytope ] );

#! @Arguments polytope 
#! @Returns a list of lists
#! @Description  
#! The function returns the defining inequalities of the polytope.
#! I.e., a list of lists $[L_1, L_2, ...]$ where each 
#! $L_j=[c_j,a_{j1},a_{j2},...,a_{jn}]$ represents the inequality 
#! $c_j+\sum_{i=1}^n a_{ji}x_i \geq 0$. If $L$ and $-L$ occur in the 
#! output then $L$ is called a defining-equality of the polytope.
DeclareAttribute( "DefiningInequalities",
                    IsPolytope );                    

#! @Arguments polytope 
#! @Returns a list of lists
#! @Description
#! The function returns the defining-equalities of the polytope.
DeclareAttribute( "EqualitiesOfPolytope",
                    IsPolytope );

#! @Arguments polytope 
#! @Returns a list of lists
#! @Description  
#! The function returns the list of the inequalities of the facets.
#! Each defining inequality that is not defining-equality of the 
#! polytope is a facet inequality.
DeclareAttribute( "FacetInequalities",
                    IsPolytope );

#! @Arguments polytope 
#! @Returns a list of lists
#! @Description  
#! The function returns list of lists $L$. The entries of each $L_j$
#! in $L$ consists of $0$'s or $1$'s. For instance, if $L_j=[1,0,0,1,0,1]$, then
#! The polytope has $6$ vertices and the vertices of the $j$'th facet are $\{V_1,V_4,V_6\}$.
DeclareAttribute( "VerticesInFacets",
                    IsPolytope );

#! @Arguments polytope 
#! @Returns a fan
#! @Description  
#! The function returns the normal fan of the given polytope.
DeclareAttribute( "NormalFan",
                    IsPolytope );

#! @Arguments polytope 
#! @Returns a cone
#! @Description  
#! If the ambient space of the polytope is $\mathrm{R}^n$, then the output is a cone in 
#! $\mathrm{R}^{n+1}$. The defining rays of the cone are 
#! ${[a_{j1},a_{j2},...,a_{jn},1]}_j$ such that $V_j=[a_{j1},a_{j2},...,a_{jn}]$ is
#! a vertex in the polytope.
DeclareAttribute( "AffineCone",
                    IsPolytope );

DeclareAttribute( "BabyPolytope",
                    IsPolytope );

#! @Arguments polytope 
#! @Returns a Polytope
#! @Description  
#! The function returns the polar polytope of the given polytope.                   
DeclareAttribute( "PolarPolytope",
                    IsPolytope );

#! @Arguments polytope 
#! @Returns a Polytope
#! @Description  
#! The function returns the dual polytope of the given polytope.
DeclareAttribute( "DualPolytope",
                    IsPolytope );

DeclareOperation( "GaleTransform", [ IsHomalgMatrix ] );

####################################
##
## Properties
##
####################################

#! @Section Properties

#! @Arguments polytope 
#! @Returns a true or false
#! @Description  
#! returns if the polytope empty or not
DeclareProperty( "IsEmpty",
                 IsPolytope );

DeclareProperty( "IsNotEmpty",
                 IsPolytope );

#! @Arguments polytope 
#! @Returns a true or false
#! @Description  
#! returns if the polytope is lattice polytope or not.
DeclareProperty( "IsLatticePolytope",
                 IsPolytope );
#! @Arguments polytope 
#! @Returns a true or false
#! @Description  
#! returns if the polytope is very ample or not.
DeclareProperty( "IsVeryAmple",
                 IsPolytope );

#! @Arguments polytope 
#! @Returns a true or false
#! @Description  
#! returns if the polytope is normal or not.
DeclareProperty( "IsNormalPolytope",
                 IsPolytope );

#! @Arguments polytope 
#! @Returns a true or false
#! @Description  
#! returns if the polytope is simplicial or not.
DeclareProperty( "IsSimplicial",
                 IsPolytope );

#! @Arguments polytope 
#! @Returns a true or false
#! @Description  
#! returns if the polytope is simplex polytope or not.
DeclareProperty( "IsSimplexPolytope",
                 IsPolytope );
                 
#! @Arguments polytope 
#! @Returns a true or false
#! @Description  
#! returns if the polytope is simple or not.
DeclareProperty( "IsSimplePolytope",
                 IsPolytope );
                 
DeclareProperty( "IsBounded",
                 IsPolytope );

#! @Arguments polytope 
#! @Returns a true or false
#! @Description  
#! returns if the polytope is reflexive or not, i.e., if its dual polytope is lattice
#! polytope.
DeclareProperty( "IsReflexive", IsPolytope );

################################
##
## Methods
##
################################

#! @Section Operations on polytopes

#! @Arguments polytope1, polytope2
#! @Returns a polytope
#! @Description
#! The output is cartesian product of the input polytopes.
DeclareOperation( "\*",
                  [ IsPolytope, IsPolytope ] );

#! @Arguments polytope1, polytope2
#! @Returns a polytope
#! @Description
#! The output is Minkowski sum of the input polytopes.
DeclareOperation( "\+",
                  [ IsPolytope, IsPolytope ] );

#! @Arguments n, polytope
#! @Returns a polytope
#! @Description
#! The output is Minkowski sum of the input polytope with itself $n$ times.
DeclareOperation( "\*",
                  [ IsInt, IsPolytope ] );

DeclareOperation( "\*",
                  [ IsPolytope, IsInt ] );

#! @Arguments polytope1, polytope2
#! @Returns a polytope
#! @Description
#! The output is the intersection of the input polytopes. 
DeclareOperation( "IntersectionOfPolytopes",
                  [ IsPolytope, IsPolytope ] );
                  
DeclareOperation( "Points", 
                  [ IsList, IsList] );

DeclareOperation( "FourierProjection", 
                  [ IsPolytope, IsInt ] );

#! @Arguments polytope
#! @Returns a list
#! @Description
#! Returns a random interior point in the polytope.
DeclareOperation( "RandomInteriorPoint", 
                  [ IsPolytope ] );

#! @Arguments M, polytope
#! @Returns true or false
#! @Description
#! Checks if the given point is interior point of the polytope.
DeclareOperation( "IsInteriorPoint", 
                  [ IsList,IsPolytope ] );

#! @InsertChunk example2
