function calc_error,w,wref

  s = size(w)
  if s(0) eq 2 then $
    ; For 1D: errors in rho, ux, p, Eint
    return, (total(abs(w(*,0)-wref(*,0)))/ total(abs(wref(*,0))) $
    +        total(abs(w(*,1)-wref(*,1)))/ total(abs(wref(*,1))) $
    +        total(abs(w(*,4)-wref(*,4)))/ total(abs(wref(*,4))) $
    +        total(abs(w(*,5)-wref(*,5)))/ total(abs(wref(*,5))))/4 $
  else $
    ; For 2D: errors in rho, ux, uy (normalized to ux), p, Eint
    return, (total(abs(w(*,*,0)-wref(*,*,0)))/ total(abs(wref(*,*,0))) $
    +        total(abs(w(*,*,1)-wref(*,*,1)))/ total(abs(wref(*,*,1))) $
    +        total(abs(w(*,*,2)-wref(*,*,2)))/ total(abs(wref(*,*,1))) $
    +        total(abs(w(*,*,4)-wref(*,*,4)))/ total(abs(wref(*,*,4))) $
    +        total(abs(w(*,*,5)-wref(*,*,5)))/ total(abs(wref(*,*,5))))/5

end

