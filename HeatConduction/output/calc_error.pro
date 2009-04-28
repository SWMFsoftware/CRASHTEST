function calc_error,w
  return,total(abs(w(*,*,4)-w(*,*,0)))/total(abs(w(*,*,4))) $
         +total(abs(w(*,*,5)-w(*,*,1)))/total(abs(w(*,*,5))) $
         +total(abs(w(*,*,6)-w(*,*,2)))/total(abs(w(*,*,6))) $
         +total(abs(w(*,*,7)-w(*,*,3)))/total(abs(w(*,*,7)))
;  return,total(abs(w(*,*,5)-w(*,*,1)))/total(abs(w(*,*,5)))
end
