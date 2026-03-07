(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Inference system for Shostak theories.

  @author Harald Ruess
*)


(** A Shostak theory [th] is specified by means of a
  - replacement [map f a] for replacing uninterpreted 
  subterms of [a] with [f a] and canonizing the result, and
  - a {i solver} [solve]. 
  - an extended {i canonizer} [map f a] for replacing uninterpreted
  positions [x] of [a] with [f b] followed by canonization in the
  given theory, and
  - a {i branching} function [disjunction]. If [disjunction] always returns [Not_found],
  then [th] is also said to be a {i convex} Shostak theory. *)
module type T = sig
  val th : Th.t
  val map : (Term.t -> Term.t) -> Term.t -> Term.t
  val solve : Fact.Equal.t -> Fact.Equal.t list
  val disjunction : Fact.Equal.t -> Clause.t
end


module Make(Sh: T): (Infsys.EQ with type e = Solution.Set.t)
  (** Constructing an inference system from a Shostak theory [Th].
    For a description of the correctness statement of these inference
    rules, see module {!Infsys}.

    As an invariant, equality sets for representing contexts
    of Shostak theories are {i ordered} equalities of the 
    form [x = a] with [x] a variable and [a] a nonvariable, 
    [Sh.th]-pure term.  In addition, these equality sets are in
    - {i solved form}, that is, there are no [x = a], [y = b]
    with [x] a variable in [b].
    - {i canonical}, that is, if [x = y] has been propagated
    using the [propagate] rule, then the {i noncanonical} [x] does 
    not appear in the equality set.  Also, right-hand sides are
    always kept in canonical form w.r.t to the given theory canonizer [map].

    In case of {i convex} Shostak theories, [disjunction] always fails,
    and there is no branching. 

    In case of {i incomplete} Shostak theories, [solve] might raise
    {!Exc.Incomplete} on an equality [a = b].  Now, [a], [b] are
    named apart and the corresponding variable equality is merged.
    Notice, that incomplete solvers might lead to an incompleteness in
    the inference procedure.
 *)
