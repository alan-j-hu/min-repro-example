structure Main =
  struct
    (* code from smlnj-lib/RegExp/FrontEnd/awk-syntax.sml *)
    fun patmatch s = let
      fun done s = let val _ = TextIO.print s in () end
    in         case (Array.sub(s, 0))
		   of 123 (* #"{" *) => done "A"
		    | 63 (* #"?" *)=> done "B"
		    | 42 (* #"*" *) => done "C"
		    | 43 (* (#"+") *) => done "D"
		    | 124 (* (#"|") *) => done "E"
		    | 41 (* (#")") *) => done "F"
		    | 40 (* (#"(") *) => done "G"
		    | 46 (* (#".") *) => done "H"
		    | 94 (* (#"^") *) => done "I"
		    | 36 (* (#"$") *) => done "J"
		    | 91 (* (#"[") *) => done "K"
		    | 92 (* (#"\\") *) => done "L"
		    | c => done "M"
		  (* end case *)
		end

    val _ = patmatch (Array.array(1, 92))

    fun main (_, _) = OS.Process.success
  end
