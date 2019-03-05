--touch support


fingeroneid=nil
xfingerone=nil
yfingerone=nil

--data to be pulled is put here
moveoffsetx=nil
moveoffsety=nil


fingertwoid=nil
xfingertwo=nil
yfingertwo=nil




function love.touchpressed( id, x, y, dx, dy, pressure )
 print("TOUCH")
 print(x)
 print(y)
 print(id)
 
 if fingeroneid==nil then
  print("begin touch 1")
  fingeroneid=id
  xfingerone=x
  yfingerone=y
 elseif fingertwoid == nil then
  fingertwoid=id
 end
 
end

--when a drag vector is identified, pushed here to move player
to_apply={}

function pushrelative(ox,oy)
 v={}
 if android == true then
  v.ox=oy
  v.oy=-ox
 
 else
  v.ox=ox
  v.oy=oy
 
 end
 table.insert(to_apply,v)
end

function love.touchmoved( id, x, y, dx, dy, pressure )
 -- print("MOVE")
 -- print(x)
 -- print(y)
 -- print(id)
 
 if id==fingeroneid then
  -- print("fingerone dragged")
  moveoffsetx=x-xfingerone
  moveoffsety=y-yfingerone
  xfingerone=x
  yfingerone=y
  -- print(moveoffsetx)
  -- print(moveoffsety)
  pushrelative(moveoffsetx,moveoffsety)
 end
 
 
end

function love.touchreleased( id, x, y, dx, dy, pressure )
 -- print("RELEASE")
 print(x)
 print(y)
 print(id)
 if fingeroneid== id then
  fingeroneid=nil
 end
 if fingertwoid== id then
  fingertwoid=nil
 end
 
end