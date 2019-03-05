
function tick(self)
 self.time=self.time -1
 if self.time <= 0 then
  self.finished=true
 end
end 

function createtimer(ticks)
 ret={}
 ret.ticks=ticks
 ret.time=ticks
 
 ret.tick=tick 
 
 return ret
end 