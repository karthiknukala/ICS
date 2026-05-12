(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Congruence closure

  @author Harald Ruess
  @author N. Shankar
*)

module S: Solution.SET0

module Infsys: (Infsys.EQ with type e = S.t)
  (** A {i congruence closure} state represents the conjunction of 
    a set of equalities [x = f(x1,...,xn)] with [x], [xi] term variables and [f] 
    an uninterpreted function symbol. This set of equalities is 
    - {i injective} in that [x = a] and [y = a] implies [x = y], and 
    - {i functional} in that [x = a] and [x = b] implies [a = b].
  *)
