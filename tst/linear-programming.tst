gap> START_TEST( "linear-programming.tst");
gap> trails := 20;;
gap> N := 17;;
gap> for i in [ 1 .. trails ] do
> n := NanosecondsSinceEpoch() mod N;;
> if n <> 0 then
>   N := n;
>   break;
> fi;
> od;;
gap> M := 2 + NanosecondsSinceEpoch() mod 3;;
gap> P := List( [ 1 .. N ], i -> List( [ 1 .. M ], i -> Random( [ -10 .. 10 ] ) ) );;
gap> target_func := List( [ 1 .. M ], i -> Random( [ -1000 .. 1000 ] ) );;
gap> max := Maximum( List( P, p -> target_func*p ) );;
gap> min := Minimum( List( P, p -> target_func*p ) );;
gap> P := Polytope( P );;
gap> r := NanosecondsSinceEpoch() mod 1000;;
gap> SolveLinearProgram( P, "max", Concatenation( [r], target_func ) )[2] = max + r;
true
gap> SolveLinearProgram( P, "min", Concatenation( [r], target_func ) )[2] = min + r;
true


