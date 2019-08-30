#
# NConvex: new version of the Package Convex
#
# This file is a script which compiles the package manual.
#

if fail = LoadPackage("AutoDoc", "2016.02.16") then
    Error("AutoDoc version 2016.02.16 or newer is required.");
fi;

AutoDoc( 
        rec(
          autodoc := rec( files := [ "doc/intro.autodoc" ] ),
          extract_examples := rec( units := "Single" ),
          scaffold := rec( entities := [ "GAP4", "homalg", "ToricVarieties" ] ),

          ## The following commented code is to include some latex packages that is needed to draw diagrams in tikz.
          ## It is commented since they may cause error while creating documentation if the latex installation 
          ## does not provide these packages.
          ##
          
          #?scaffold := rec( entities := [ "GAP4", "homalg", "TroicVarieties" ],
          #?gapdoc_latex_options := rec(
          #?LateExtraPreamble := """\usepackage{amsmath}
          #?\usepackage[T1]{fontenc}
          #?\usepackage{tikz}
          #?\usetikzlibrary{shapes,arrows,matrix}
          #?\usepackage{mathdots}
          #?\usepackage{cancel}
          #?\usepackage{color}
          #?\usepackage{siunitx}
          #?\usepackage{array}
          #?\usepackage{multirow}
          #?\usepackage{amssymb}
          #?\usepackage{gensymb}
          #?\usepackage{tabularx}
          #?\usepackage{booktabs}
          #?\usetikzlibrary{fadings}""" ) ),

            )
);

QUIT;
