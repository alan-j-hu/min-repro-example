structure Main =
  struct
    val _ = StringCvt.scanString AwkSyntax.scan "[\\t ]*@([a-zA-Z][-a-zA-Z0-9_]*)@[\\t ]*"

    fun main (_, _) = OS.Process.success
  end
