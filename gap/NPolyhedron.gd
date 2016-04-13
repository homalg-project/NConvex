#############################################################################
##
##  Polyhedron.gd         NConvex package        Sebastian Gutsche
##                                               Kamal Saleh
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Polyhedrons for NConvex.
##
#############################################################################

DeclareCategory( "IsPolyhedron",
                 IsConvexObject );

#####################################
##
## Constructors
##
#####################################

#! @Chapter Polyhedrons
#! @Section Creating polyhedron

#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
#! The function takes a list in which every entry represents an inequality and returns the polyhedron defined by them.
DeclareOperation( "PolyhedronByInequalities",
                  [ IsList ] );

#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
DeclareOperation( "Polyhedron",
                  [ IsPolytope, IsCone ] );
#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
DeclareOperation( "Polyhedron",
                  [ IsList, IsCone ] );
#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
DeclareOperation( "Polyhedron",
                  [ IsPolytope, IsList ] );
#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
DeclareOperation( "Polyhedron",
                  [ IsList, IsList ] );

                 
#####################################
##
## Structural Elements
##
#####################################

#! @Section Attributes

#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
#! Converts the given polyhedron to CddPolyhedron.
DeclareAttribute( "ExternalCddPolyhedron",
                   IsPolyhedron );
#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
#! Converts the given polyhedron to NmzPolyhedron 
DeclareOperation( "ExternalNmzPolyhedron",
                   [ IsPolyhedron ] );
                   
#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
#! Returns the Defining inequalities of the given polyhedron.                   
DeclareAttribute( "DefiningInequalities",
                   IsPolyhedron );

#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
#! Returns the main rational polytope of the polyhedron.
DeclareAttribute( "MainRatPolytope",
                  IsPolyhedron );

#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
#! Returns the main polytope of the given polyhedron.
DeclareAttribute( "MainPolytope",
                  IsPolyhedron );
#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
#! Returns the vertices of the main rational polytope of the polyhedron.
DeclareAttribute( "VerticesOfMainRatPolytope",
                  IsPolyhedron );

#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
#! Returns the vertices of the main integral polytope of the given polyhedron.
DeclareAttribute( "VerticesOfMainPolytope",
                  IsPolyhedron );

#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
#! Returns the tail cone of the polyhedron.
DeclareAttribute( "TailCone",
                  IsPolyhedron );

#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
#! Returns the Ray Generators of the tail cone
DeclareAttribute( "RayGeneratorsOfTailCone",
                  IsPolyhedron );

DeclareAttribute( "HomogeneousPointsOfPolyhedron",
                  IsPolyhedron );

DeclareAttribute( "LatticePointsGenerators",
                  IsPolyhedron );
#! @Arguments arg 
#! @Returns a **Polyhedron** Object
#! @Description  
#! Returns a basis to the lineality space of the polyhedron.
DeclareAttribute( "BasisOfLinealitySpace",
                  IsPolyhedron );

#####################################
##
## Properties
##
#####################################

DeclareProperty( "IsNotEmpty",
                 IsPolyhedron );

DeclareProperty( "IsBounded",
                 IsPolyhedron );

DeclareProperty( "IsPointed",
                 IsPolyhedron );
                                  
DeclareGlobalFunction( "Draw" );

#! @InsertChunk example3
