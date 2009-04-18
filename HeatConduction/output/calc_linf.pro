function calc_linf,w
  return,max(abs(w(*,*,0)-w(*,*,1)))
end
