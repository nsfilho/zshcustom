if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    set clipboard+=unnamedplus
  endif
endif
