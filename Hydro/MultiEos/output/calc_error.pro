function calc_error,w,wref
  ; errors in rho, ux, uy (normalized to ux), p, Eint
  return, total(abs(w(*,*,0)-wref(*,*,0)))/ total(abs(wref(*,*,0))) $
    +     total(abs(w(*,*,1)-wref(*,*,1)))/ total(abs(wref(*,*,1))) $
    +     total(abs(w(*,*,2)-wref(*,*,2)))/ total(abs(wref(*,*,1))) $
    +     total(abs(w(*,*,4)-wref(*,*,4)))/ total(abs(wref(*,*,4))) $
    +     total(abs(w(*,*,5)-wref(*,*,5)))/ total(abs(wref(*,*,5)))
end
