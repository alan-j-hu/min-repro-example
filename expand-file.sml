structure ExpandFile :> sig
  end = struct
    structure RE = RegExpFn (
      structure P = AwkSyntax
      structure E = BackTrackEngine)
    val placeholderRE = RE.compileString "[\\t ]*@([a-zA-Z][-a-zA-Z0-9_]*)@[\\t ]*"
  end
