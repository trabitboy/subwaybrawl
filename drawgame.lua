
-- function displayradar()
 -- love.graphics.print ("FIRE RADAR:",pfw+4,8)
 -- for j=0,(mzy-1)
 -- do
  -- for i=0,(mzx-1)
  -- do
   -- if lvl[mzx*j+i]~=nil then
	-- if checkroom(mzx*j+i) then
     -- love.graphics.setColor(255,0,0,255)
	-- else
     -- love.graphics.setColor(255,255,255,255)	
	-- end
    -- love.graphics.rectangle("fill",pfw+8+i*8+1,32+j*8+1,6,6)
   -- end
  -- end
 -- end
  -- love.graphics.setColor(255,255,255,255)
-- end

-- function displaygauge()
    -- xcur=ggx
	-- ycur=cvsh-16
    -- -- love.graphics.draw(rank3,64,64)

	-- -- for i=1,maxrang
	-- -- for i=1,8
	-- for i=1,rankcounter
    -- do
	 -- if i>seuil3 then
      -- love.graphics.draw(rank3,xcur,ycur)
	 
	 -- elseif i>seuil2 then
      -- love.graphics.draw(rank2,xcur,ycur)
	 
	 -- else
      -- love.graphics.draw(rank1,xcur,ycur)
	 -- end
	 -- ycur=ycur-16
	-- end
-- end

-- function drawbaddiehealth()
 -- if baddieobserved~=nil then
  -- chunks=baddieobserved.hp /10
  
  -- xcur=0
  -- ycur=0
  
  -- for i=1,chunks
  -- do
   -- love.graphics.draw(rank1,xcur,ycur)
   -- ycur=ycur+32
  -- end  
 
 -- end

-- end

function displayscore()
  love.graphics.draw(scoremask,512,0)
  
  love.graphics.print("score",590,100)
  love.graphics.print(score,590,115)
end

function drawhitbox(o)
 if o.hbx~=nil then
  --we have something to blit
  --TODO
  love.graphics.setColor(0,0,0,255)
  love.graphics.setLineWidth(3)
  if o.zoom~=nil then
   love.graphics.rectangle("line",o.zx+o.hbx.x,o.zy+o.hbx.y,o.hbx.w,o.hbx.h)
  else
   love.graphics.rectangle("line",o.x+o.hbx.x,o.y+o.hbx.y,o.hbx.w,o.hbx.h)
  end
  love.graphics.setColor(255,255,255,255)
 end
end

--of curr screen
function dbgdrawwallboxes()
	if curscreen.walls~=nil then
		for i,w in ipairs(curscreen.walls)
		do
		 love.graphics.rectangle("line",w.minx,w.miny,w.maxx-w.minx,w.maxy-w.miny)
		end
	end
end

--above death overlay
function drawwallboxes()
	love.graphics.setColor(1,1,1,0.3) 
	if curscreen.walls~=nil then
		for i,w in ipairs(curscreen.walls)
		do
		 love.graphics.rectangle("fill",w.minx,w.miny,w.maxx-w.minx,w.maxy-w.miny)
		end
	end
end


function drawgame()
 love.graphics.setCanvas(vscreen)
 
 --maybe remove clear sometimes for smear effects
 -- love.graphics.setColor(255,255,255,255)
 love.graphics.clear(1.0,1.0,1.0)
 -- love.graphics.draw(blank,pfx,pfy)
 
 --bg display
  love.graphics.draw(tmpbg.pic,0,-150)
 
 --we need to sort objects to blit by z order
 toblit={}
 
 if plyframe()~=nil then
  -- love.graphics.draw(plyframe().pic,ply.x,ply.y)
  table.insert(toblit, {idx= (ply.y+plyfeet),pic=plyframe().pic,x=ply.x,y=ply.y})
 end
 for i,p in ipairs(gos) 
 do
  -- love.graphics.draw(p.frame(p).pic,p.x,p.y)
  table.insert(toblit, {idx= (p.y+punkfeet),pic=p.frame(p).pic,x=p.x,y=p.y})
 end 
 
 function sortblit(a,b)
  if a.idx<b.idx 
  then 
	return true 
  end
 end
 
 table.sort(toblit,sortblit)
 for i,b in ipairs(toblit) 
 do
  love.graphics.draw(b.pic,b.x,b.y)
  -- table.insert(toblit, {idx= (p.y+punkfeet),pic=p.frame(p).pic,x=p.x,y=p.y})
 end 
 
 
 
 
 if dbox==true then
	 wdw=ply.getdmgwdw(ply)
	 love.graphics.setColor(1.0,0.0,0.0,0.25)
	 love.graphics.rectangle("fill", wdw.x, 10, wdw.w, 400 )
	 vwdw=ply.getvertwdw(ply)
	 love.graphics.rectangle("fill",0 , vwdw.y, 600, vwdw.w )
	 swdw=ply.getsensibilitywdw(ply)
	 love.graphics.setColor(0.0,1.0,0.0,0.25)
	 love.graphics.rectangle("fill", swdw.x, 10, swdw.w, 400 )
	 love.graphics.setColor(1.0,1.0,1.0,1.0)
	 -- love.graphics.rectangle("fill", ply.cx-5, 10, ply.cx+5, 100 )
	 
	 
 end
 
 for i,p in ipairs(gos) 
 do
    if dbox==true then
 	 rwdw=p.reachwdw(p)
	 love.graphics.setColor(1.0,0.0,0.0,0.25)
	 love.graphics.rectangle("fill", rwdw.x, 10, rwdw.w, 400 )
	 vwdw=p.getvertwdw(p)
	 love.graphics.rectangle("fill",  10, vwdw.y, 600, vwdw.w )
	  wdw=p.hitwdw(p)
	  love.graphics.setColor(0.0,1.0,0.0,0.25)
	  love.graphics.rectangle("fill", wdw.x, 10, wdw.w, 400 )
	  frwdw=p.finalreachwdw(p)
	  love.graphics.setColor(1.0,1.0,0.0,0.25)
	  love.graphics.rectangle("fill", frwdw.x, 10, frwdw.w, 400  )
	  love.graphics.setColor(1.0,1.0,1.0,1.0)
	 
	end
	-- love.graphics.draw(p.frame(p).pic,p.x,p.y)
 end 
 
 -- love.graphics.draw(punkframes.left[1].pic,400,240)

 -- love.graphics.draw(punkframes.lpunch[1].pic,200,240)

 -- if displayboxs then
  -- drawhitbox(ply)
 -- end
 
 -- for i,v in pairs(curscreen.gos) 
 -- do 
 
   -- if v.zoom~=nil then
    -- love.graphics.push()
    -- love.graphics.scale(v.zoom, v.zoom)   -- reduce everything by 50% in both X and Y coordinates
	-- local w=v.picdata:getWidth()
	-- local h=v.picdata:getHeight()
	-- zoomcorrect=(1/v.zoom)
	-- bcx=v.cx*zoomcorrect
	-- bcy=v.cy*zoomcorrect
	
	-- bx=bcx-w/2
	-- by=bcy-h/2
	
    -- love.graphics.draw(v.pic.pic,bx,by)
   -- -- love.graphics.print("Scaled text", 50, 50) 
    -- love.graphics.pop()
   -- else
    -- love.graphics.draw(v.pic.pic,(pfx+v.x),(pfy+v.y))
   -- end
   -- --dbg
   -- if displayboxs then
    -- drawhitbox(v)
   -- end
 -- -- love.graphics.print("Normal text", 50, 50)  
 -- end
 
 -- for i,v in pairs(bullets) 
 -- do 
  -- love.graphics.setColor(1,1,1,200/255) 
  -- love.graphics.draw(v.pic.pic,pfx+v.x,pfy+v.y)
  -- love.graphics.setColor(1,1,1,1) 
 -- end
 
 -- if displayboxs then
  -- dbgdrawwallboxes()
 -- end
 -- -- drawbaddiehealth()
 -- displayscore() 
 -- displaygauge()
 -- displayradar()
 -- love.graphics.setColor(1,0,0,overlayopacity/255) 
 -- love.graphics.rectangle("fill",0,0,640,480)
 -- if overlayopacity>64 then
  -- love.graphics.setColor(1,1,1,(overlayopacity-64)/255) 
  -- love.graphics.draw(deathframes[animstep].pic,0,0)
  
  -- --experimental, add shader
  -- -- drawwallboxes()
  
  
  
 -- end
 
 
 if updatefunc==updatelvlintro then
  love.graphics.setColor(0,0,0,1) 
  love.graphics.rectangle("fill",200,200,100,100)
  love.graphics.setColor(1,1,1,1) 
  love.graphics.print("Oo. GeT BrAwLiN' .oO",210,210)
 end

 if updatefunc==updatelvloutro then
  love.graphics.rectangle("fill",200,200,100,100)
  love.graphics.setColor(0,0,0,1) 
  love.graphics.setColor(1,1,1,1) 
  love.graphics.print('well done !',210,210)
 end


 
 love.graphics.setColor(1,1,1,1) 
 rdrvscreen()
end
