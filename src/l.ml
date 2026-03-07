(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

open Mpa

module T: Shostak.T = struct
  let th = Th.app
  let map = Apply.map

  let solve e = 
    let (a, b, rho) = e in
      try
	let sl = Apply.solve (a, b) in
	let inj (a, b) = Fact.Equal.make a b rho in
	  List.map inj sl
      with
	  Exc.Inconsistent -> raise(Jst.Inconsistent(rho))

  exception Found of Term.t * Term.t

  let disjunction (_, a, _) =
    let rec split_in_term a =
      match Apply.d_interp a with
	| Sym.C, [b; c; _; _] -> 
	    raise(Found(b, c))
	| _, al ->
	    List.iter split_in_term al
    in
      try
	split_in_term a;
	raise Not_found
      with
	  Found(b, c) -> 
	    let e = Atom.mk_equal (b, c)
	    and d = Atom.mk_diseq (b, c) in
	      Clause.of_list ([e; d],Jst.dep0)
end

module S = Solution.Set

module Infsys0: (Infsys.EQ with type e = Solution.Set.t) = struct

  type e = S.t

  module I = Shostak.Make(T)

  let current = I.current
  let initialize = I.initialize
  let finalize = I.finalize

  open Infsys

  (** Replace foreign first-order terms. *)
  let rec export () = 
    S.iter export1 (current())

  and export1 ((x, a, rho) as e) =
    if is_first_order a then
      begin
	G.put (Fact.of_equal e) !g;
	S.restrict (current()) x
      end 

  and is_first_order a =
    try
      let f = Term.App.sym_of a in
      let i = Sym.theory_of f in
	not(i = Th.app)
    with
	Not_found -> false

  let abstract = I.abstract

  let merge e = 
    assert(Fact.Equal.is_pure Th.app e);
    I.merge e;
    export ()

  let dismerge d = 
    I.dismerge d;
    export ()

  let branch = I.branch
 
 let normalize = I.normalize

  let propagate e = 
    I.propagate e;
    export ()

   (** Apply disequality [x <> y] to [C x y a b]. *)
  let propagate_diseq d =
    I.propagate_diseq d;
    let (x, y, rho) = d in
    let disapply e = 
      let (z, a, tau) = e in
      let a' = Apply.disapply (x, y) a in
	if a == a' then () else 
	  let e' = Fact.Equal.make z a' (Jst.dep2 rho tau) in
	    S.update (!p, current()) e'
    in
      S.Dep.iter (current()) disapply x;
      S.Dep.iter (current()) disapply y;
      export ()
			  
end


(** Tracing inference system. *)
module Infsys: (Infsys.EQ with type e = S.t) =
  Infsys.Trace(Infsys0)
    (struct
       type t = S.t
       let level = "cl"
       let eq = S.eq
       let diff = S.diff
       let pp = S.pp
     end)
