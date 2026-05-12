(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Inference system for the theory {!Th.arr} of functional array

  @author Harald Ruess
  @author N. Shankar
*)


module Infsys: (Infsys.EQ with type e = Solution.Set.t)
  (** Inference system for the theory {!Th.arr} of extensional arrays
    as defined in module {!Funarr}.

    A context consists of equalities of the form [x = b] with [x] a
    variable and [b] a flat array term with variables as arguments:
    - [create(a)] for creating a constant array with 'elements' [a]
    - [a[i:=x]] for updating array [a] at position [i] with [x]
    - [a[j]] for selection the value of array [a] at position [j]
    
    Right-hand sides of context equalities [x = a] are kept in 
    canonical form.  That is, if the variable equality [y = z]
    has been merged using [Arr.merge], then the noncanonical [y]
    is not appearing on any right-hand side.
    
    Forward chaining is used to keep configurations {i confluent}.
    - (1) [u = a[i:=x]] ==> [x = u[i]],
    - (2) [i<>j], [u = a[i:=x]] ==> [u[j] = a[j]],
    - (3) [i<>j], [v = a[i:=x][j:=y]] ==> [v = a[j:=y][i:=x]],
    - (4) [u = a[i:=y][i:=x]] ==> [u = a[i:=x]],
    - (5) [u = create(a)[j]] ==> [u = a]
    
    Here, [i<>j] are the known disequalities in a variable partition
    (see {!Partition.t}). *)


module Ops: Can.OPS
  (** Various operations with a set of flat equalities of the
    form [u = x * y] as context. *)

