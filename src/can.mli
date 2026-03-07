(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Inference system for canonizable, ground confluent theories.

  @author Harald Ruess
*)

type config = Partition.t * Solution.Set.t 

(** A {i canonizable and ground confluent} theory [th] is specified 
  by means of a
  - replacement [map f a] for replacing uninterpreted 
  subterms of [a] with [f a] and canonizing the result,
  - a theory-specific canonizer;
  - chainings functions [of_var_equal], [of_var_diseq], [of_var_diseq] 
  for keeping equality sets ground confluent by triggering inference rules
  on pure equalities, variable equalities, and variable disequalities, respectively; and
  - a branching function [disjunction]. *)
module type T = sig
  val th : Th.t
  val map : (Term.t -> Term.t) -> Term.t -> Term.t
  val sigma : Sym.t -> Term.t list -> Term.t
  val of_equal : Fact.Equal.t -> config -> Fact.Equal.t list
  val of_var_equal : Fact.Equal.t -> config -> Fact.Equal.t list
  val of_var_diseq : Fact.Diseq.t -> config -> Fact.Equal.t list
  val disjunction : config -> Clause.t
end


module Make(Can: T): (Infsys.EQ with type e = Solution.Set.t)
  (** Constructing an inference system from the specification [Can]
    of a canonizable and ground confluent theory. *)


(** Operations for canonizable theories. *)
module type OPS = sig
  val is_flat : Term.t -> bool
  val is_pure : Term.t -> bool
  val find : Partition.t * Solution.Set.t -> Jst.Eqtrans.t
  val inv : Partition.t * Solution.Set.t -> Jst.Eqtrans.t
end 

module Ops(Can: T): OPS
