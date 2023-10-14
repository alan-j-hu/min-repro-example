structure Main =
  struct
    (* code from smlnj-lib/RegExp/FrontEnd/awk-syntax.sml *)
    fun patmatch s = let
      fun done s = let val _ = TextIO.print s in () end
    in         case (String.sub(s, 0))
		   of (#"{") => done "A"
		    | (#"?") => done "B"
		    | (#"*") => done "C"
		    | (#"+") => done "D"
		    | (#"|") => done "E"
		    | (#")") => done "F"
		    | (#"(") => done "G"
		    | (#".") => done "H"
		    | (#"^") => done "I"
		    | (#"$") => done "J"
		    | (#"[") => done "K"
		    | (#"\\") => done "L"
		    | c => done "M"
		  (* end case *)
		end

    val _ = patmatch "("

    fun main (_, _) = OS.Process.success
  end
