type token =
  | DROP
  | CAN
  | SIMPLIFY
  | ASSERT
  | EXIT
  | SAVE
  | RESTORE
  | REMOVE
  | FORGET
  | RESET
  | SYMTAB
  | SIG
  | VALID
  | UNSAT
  | TYPE
  | SIGMA
  | SOLVE
  | HELP
  | DEF
  | PROP
  | TOGGLE
  | SET
  | GET
  | TRACE
  | UNTRACE
  | CMP
  | FIND
  | USE
  | INV
  | SOLUTION
  | PARTITION
  | MODEL
  | SHOW
  | SIGN
  | DOM
  | SYNTAX
  | COMMANDS
  | SPLIT
  | SAT
  | ECHO
  | CHECK
  | UNDO
  | LOAD
  | DISEQ
  | CTXT
  | IN
  | NOTIN
  | TT
  | FF
  | EOF
  | QUOTE
  | IDENT of (string)
  | STRING of (string)
  | INTCONST of (int)
  | RATCONST of (Mpa.Q.t)
  | PROPVAR of (Name.t)
  | BOT
  | INT
  | REAL
  | BV
  | TOP
  | INF
  | NEGINF
  | ALBRA
  | ACLBRA
  | CLBRA
  | LPAR
  | RPAR
  | LBRA
  | RBRA
  | LCUR
  | RCUR
  | PROPLPAR
  | PROPRPAR
  | UNDERSCORE
  | KLAMMERAFFE
  | COLON
  | COMMA
  | DOT
  | DDOT
  | ASSIGN
  | TO
  | ENDMARKER
  | BACKSLASH
  | EMPTY
  | FULL
  | UNION
  | INTER
  | COMPL
  | DIFF
  | BVCONST of (string)
  | FRESH of (string * int)
  | CONC
  | SUB
  | BWITE
  | BWAND
  | BWOR
  | BWXOR
  | BWIMP
  | BWIFF
  | BWNOT
  | BVCONC
  | EQUAL
  | SUBSET
  | TRUE
  | FALSE
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | EXPT
  | LESS
  | GREATER
  | LESSOREQUAL
  | GREATEROREQUAL
  | UNSIGNED
  | APPLY
  | LAMBDA
  | S
  | K
  | I
  | C
  | WITH
  | CONS
  | CAR
  | CDR
  | NIL
  | INL
  | INR
  | OUTL
  | OUTR
  | INJ
  | OUT
  | HEAD
  | TAIL
  | LISTCONS
  | DISJ
  | XOR
  | IMPL
  | BIIMPL
  | CONJ
  | NEG
  | IF
  | THEN
  | ELSE
  | END
  | PROJ
  | CREATE
  | SUP

val termeof :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Term.t
val atomeof :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Atom.t
val propeof :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Prop.t
val commands :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> unit
val commandseof :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> unit
val commandsequence :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> unit
