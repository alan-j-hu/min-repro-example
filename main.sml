structure Main =
  struct
    (* code from smlnj-lib/RegExp/FrontEnd/awk-syntax.sml *)
    structure R = RegExpSyntax

    exception Error

    fun scan getc cs = let
	  fun getc' cs = (case (getc cs)
		 of NONE => raise Error
		  | (SOME arg) => arg)
		(* end case *)
	  fun scanAlt (stk, cs) = let
		val (re, cs') = scanSeq([], cs)
		in
		  case (stk, getc cs')
		   of ([], NONE) => (re, cs')
		    | (_, SOME(#"|", cs'')) => scanAlt(re::stk, cs'')
		    | _ => (R.Alt(rev(re::stk)), cs')
		  (* end case *)
		end
	  and scanSeq (stk, cs) = let
		fun done () = (R.Concat(rev stk), cs)
		in
		  case (stk, getc cs)
		   of ([], NONE) => raise Error
		    | ([re], NONE) => (re, cs)
		    | (_, NONE) => done()
		    | (re::r, SOME(#"{", cs')) => done()
		    | (re::r, SOME(#"?", cs')) => done()
		    | (re::r, SOME(#"*", cs')) => done()
		    | (re::r, SOME(#"+", cs')) => done()
		    | (_, SOME(#"|", _)) => done()
		    | (_, SOME(#")", _)) => done()
		    | (_, SOME(#"(", cs')) => done()
		    | (_, SOME(#".", cs')) => done()
		    | (_, SOME(#"^", cs')) => done()
		    | (_, SOME(#"$",cs')) => done()
		    | (_, SOME(#"[", cs')) => done()
		    | (_, SOME(#"\\", cs')) => done()
		    | (_, SOME(c, cs')) => done()
		  (* end case *)
		end
	  in
	    SOME(scanAlt([], cs)) handle Error => NONE
	  end

    (* https://github.com/smlnj/smlnj/blob/7ca892cb6ebfef9dd3619ff8a4bb47055d43208b/tools/ml-lpt/common/expand-file.sml#L51

       and then

       https://github.com/smlnj/smlnj/blob/7ca892cb6ebfef9dd3619ff8a4bb47055d43208b/smlnj-lib/RegExp/Glue/regexp-fn.sml#L29
     *)
    val _ = StringCvt.scanString scan "[\\t ]*@([a-zA-Z][-a-zA-Z0-9_]*)@[\\t ]*"

    fun main (_, _) = OS.Process.success
  end
