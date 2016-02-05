#############################################################################
##
##  ConvexObject.gd               Convex package       Sebastian Gutsche
##
##  Copyright 2011-2012 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Main Object to be viewed, is almost everything that has a number ;).
##
#############################################################################

##  <#GAPDoc Label="IsConvexObject">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsConvexObject"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of convex objects, the main category of this package.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsConvexObject", 
                 IsObject );


DeclareRepresentation( "IsExternalConvexObjectRep",
                      IsConvexObject and IsAttributeStoringRep,
                      [ ]
                     );

DeclareRepresentation( "IsInternalConvexObjectRep",
                      IsConvexObject and IsAttributeStoringRep,
                      [ ]
                     );


##############################
##
## Attributes
##
##############################

##
DeclareAttribute( "AmbientSpaceDimension",
                  IsConvexObject );
                  
                  
DeclareAttribute( "ContainingGrid",
                  IsConvexObject );

DeclareAttribute( "Dimension",
                  IsConvexObject );
                  
DeclareProperty( "IsFullDimensional",
                 IsConvexObject );