function calc_error,w
  return,total(abs(w(*,*,0)-w(*,*,1)))/total(abs(w(*,*,1)))
end
