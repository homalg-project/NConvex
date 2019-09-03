

BindGlobal( "SOLVE_LINEAR_PROGRAM_USING_CDD",
  function( P, max_or_min, target_func, constructor )
    local ext_cdd_poly, cdd_linear_program; 
    ext_cdd_poly := constructor( P );
    cdd_linear_program := Cdd_LinearProgram( ext_cdd_poly, max_or_min, target_func );
    return Cdd_SolveLinearProgram( cdd_linear_program );
end );

##
InstallMethod( SolveLinearProgram,
  [ IsPolyhedron, IsString, IsList ],
  function( P, max_or_min, target_func )
    return SOLVE_LINEAR_PROGRAM_USING_CDD( P, max_or_min, target_func, ExternalCddPolyhedron );
end );

##
InstallMethod( SolveLinearProgram,
  [ IsPolytope, IsString, IsList ],
  function( P, max_or_min, target_func )
    return SOLVE_LINEAR_PROGRAM_USING_CDD( P, max_or_min, target_func, ExternalCddPolytope );
end );

