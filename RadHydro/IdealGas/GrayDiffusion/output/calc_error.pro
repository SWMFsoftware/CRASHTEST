function calc_error,w
  return,total(abs(w(*,0)-w(*,5)))/total(abs(w(*,5))) $
         +total(abs(w(*,1)-w(*,6)))/total(abs(w(*,6))) $
         +total(abs(w(*,2)-w(*,7)))/total(abs(w(*,7))) $
         +total(abs(w(*,3)-w(*,8)))/total(abs(w(*,8))) $
         +total(abs(w(*,4)-w(*,9)))/total(abs(w(*,9)))
end
