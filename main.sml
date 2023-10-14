structure Main =
  struct
    structure Ex = ExpandFile
    fun main (_, _) = OS.Process.success
  end
