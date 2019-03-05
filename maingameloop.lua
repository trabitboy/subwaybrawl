
refintrotimer = 60

gos={}


-- function checklvlup()
 -- if #gameobjs==0 and #evtbuffer==0 then
    -- print("next lvl")
	-- currentLvl=currentLvl+1
	-- startCurrLvl()
 -- end
-- end


--by adding points this way a visual fx can be added 
function postscore(points,cx,cy)
 score =score + points
end

-- function tickuprank()
 -- if tickupinhib>0 then
  -- tickupinhib=tickupinhib-1
 -- end

 -- if tickupinhib==0 then
 -- --seems sometimes rank goes below zero 
 -- --and rankcounter>=0 then
  -- --rankcounter=rankcounter+1
  -- print("difselmulti "..difselmulti)
  -- rankcounter=rankcounter+difselmulti
  
  -- print("RANK UP "..rankcounter)
  -- tickupinhib=tickupref
 -- end
-- end

-- function maintainglobrank()
 -- oldrank=rank
 -- if rankcounter>=seuil5 then
  -- rank=5
 -- elseif rankcounter>=seuil4 then
  -- rank=4
 -- elseif rankcounter>=seuil3 then
  -- rank=3
 -- elseif rankcounter>=seuil2 then
  -- rank=2
 -- else
  -- rank=1 
 -- end

 -- if rank>oldrank then
  -- love.audio.play(rankup)
 -- elseif rank<oldrank then
  -- love.audio.play(rankdown)
 
 
 -- end
-- end


function tickanimstep()
 animclk=animclk+1

 if animclk>animchge then 
	animclk=0
	animstep=animstep+1
	if animstep>3 then
	 animstep=1
	end
	a4step=a4step+1
	if a4step>4 then
	 a4step=1
	end
	a5step=a5step+1
	if a5step>5 then
	 a5step=1
	end

 end 
end


-- function pointinwall (x,y,screen)
-- --walls
 -- if screen.walls~=nil then
	 -- for i,v in pairs(screen.walls) 
	  -- do
	   -- -- print("bhv")
	   -- -- if v.blocking==true then
		-- if(
  		    -- (
		     -- (v.minx <= x ) and (x <=v.maxx)
			-- )
			-- and
			-- (
			 -- (v.miny <= y ) and (y <=v.maxy)
			
			-- )
		-- ) then
		 -- print("BLOCKING POINT WALL COLL")
		 -- return true
		-- end
	   -- end
	  -- -- end
  -- end

  -- return false
-- end

-- --WIP for nega ben
-- function wallcoll(tx,ty,hb,screen)
-- --walls
 -- if screen.walls~=nil then
	 -- for i,v in pairs(screen.walls) 
	  -- do
		-- ret= coll(tx+hb.x,ty+hb.y,hb.w,hb.h,v.minx,v.miny,v.maxx-v.minx,v.maxy-v.miny)
		-- if ret == true then
		 -- print("BLOCKING WALL COLL o "..tx+hb.x..' '..ty+hb.y..' '..hb.w..' '..hb.h..' w '..v.minx..' '..v.miny..' '..v.maxx-v.minx..' '..v.maxy-v.miny)
		 
		 -- return true
		-- end
	   -- end
	  -- -- end
  -- end

  -- return false

-- end

-- --being refac for nega ben
-- function plywallcoll(tx,ty,screen)

	-- return wallcoll(tx,ty,ply.hbx,screen)
-- --walls
 -- -- if screen.walls~=nil then
	 -- -- for i,v in pairs(screen.walls) 
	  -- -- do
	   -- -- -- print("bhv")
	   -- -- -- if v.blocking==true then
		-- -- ret= coll(tx+ply.hbx.x,ty+ply.hbx.y,ply.hbx.w,ply.hbx.h,v.minx,v.miny,v.maxx-v.minx,v.maxy-v.miny)
		-- -- if ret == true then
		 -- -- print("BLOCKING WALL COLL")
		 -- -- return true
		-- -- end
	   -- -- end
	  -- -- -- end
  -- -- end

  -- -- return false
-- end

-- function checkblockingcoll(tx,ty)
 -- for i,v in pairs(curscreen.gos) 
  -- do
   -- -- print("bhv")
   -- if v.blocking==true then
    -- ret= collhbs(tx,ty,ply.hbx,v.x,v.y,v.hbx)
	-- if ret == true then
	 -- print("BLOCKING COLL")
	 -- return true
	-- end
   -- end
  -- end
  
-- -- --walls
 -- -- if curscreen.walls~=nil then
	 -- -- for i,v in pairs(curscreen.walls) 
	  -- -- do
	   -- -- -- print("bhv")
	   -- -- -- if v.blocking==true then
		-- -- ret= coll(tx+ply.hbx.x,ty+ply.hbx.y,ply.hbx.w,ply.hbx.h,v.minx,v.miny,v.maxx-v.minx,v.maxy-v.miny)
		-- -- if ret == true then
		 -- -- print("BLOCKING WALL COLL")
		 -- -- return true
		-- -- end
	   -- -- end
	  -- -- -- end
  -- -- end
 -- if plywallcoll(tx,ty,curscreen) then
  -- return true 
 -- end

  
 -- return false

-- end


function updatelvlintro()
 introtimer=introtimer-1
 if introtimer==0 then
  updatefunc=updategame
 end
end

function updatelvloutro()
 outrotimer=outrotimer-1
 if outrotimer==0 then
  -- updatefunc=updategame
   lvlglob.current=lvlglob.current+1
   levels[lvlglob.current]()
   updatefunc=updatelvlintro
   return

 end
end

--TODO
--new style room change:
-- if player center out of room, we navigate to new room if possible (
-- if one is defined in the map, if target point is not blocking)
-- if blocking search for a position that is not 
-- ( if nav left right, scan height )
-- ( if nav up down, scan width )
-- function emptybordernav(mox,moy)
		-- --dflt
		-- newx=ply.x
		-- newy=ply.y
		
		-- if(mox==1) then
			-- newx=8
		-- end
		-- if(mox==-1) then
			-- newx=pfw-(ply.w+8)
		-- end
		-- if(moy==1) then
			-- newy=8
		-- end
		-- if(moy==-1) then
			-- newy=pfh-(ply.h+8)
		-- end
		
		
		-- tgt = getscreenfromoffset(mox,moy)
		-- if tgt~=nil then
 		-- --search for block
			  -- if plywallcoll(newx,newy,tgt) then
				   -- print("basic block")
				   -- --if block, check if center is in walls
				   -- --(means that hand drawn misalignment should be no more than half size of ply)
				   -- if pointinwall(newx+ply.w/2,newy+ply.h/2,tgt) then 
				   -- -- if center in wall, we can do nothing for you
				    -- print("target center in wall, nothing we can do")
				    -- return false
				   -- end
				   -- print( "target not in wall, trying to slide" )
				   -- --TODO if center ok search for better target coord sliding - then +
				   
				   -- goodpos=false
				   
				   -- if mox ~=0 then
				    -- -- x move, sliding on y 
					-- maxslide=ply.h/2
					
					-- for i=1,maxslide 
					-- do
					 -- if plywallcoll(newx,newy+i,tgt)==false then
					  -- goodpos=true
					  -- newy=newy+i
					 -- end
					-- end
		
					-- if goodpos==false then
						-- for i=-maxslide,1 
						-- do
						 -- if plywallcoll(newx,newy+i,tgt)==false then
						  -- goodpos=true
						  -- newy=newy+i
						 -- end
						-- end
					
					-- end
		
				   -- elseif moy ~=0 then 
				    -- --y move sliding on x
					-- maxslide=ply.w/2
					
					-- for i=1,maxslide 
					-- do
					 -- if plywallcoll(newx+i,newy,tgt)==false then
					  -- goodpos=true
					  -- newx=newx+i
					 -- end
					-- end
		
					-- if goodpos==false then
						-- for i=-maxslide,1 
						-- do
						 -- if plywallcoll(newx+i,newy,tgt)==false then
						  -- goodpos=true
						  -- newx=newx+i
						 -- end
						-- end
					
					-- end
					
				   -- end
				   -- if goodpos==false then
				    -- print("couldn t find better pos sliding")
				    -- return false
				   -- else
				    -- print("found better pos sliding")
				    -- success =navigate(mox,moy,newx,newy)
				   -- end

			  -- else
			 
				  -- --no block on land
				   -- success =navigate(mox,moy,newx,newy)
			  -- end
		-- else
		 -- success=false
		-- end
		
		-- return success
-- end

-- --utility
-- function plycx()
 -- return ply.x+ply.w/2
-- end
-- function plycy()
 -- return ply.y+ply.h/2
-- end


function allgosdead()
 ret=true
 for i,p in ipairs(gos)
 do
  if p.state~=death then
   ret=false
   break
  end   
  
 end
 if ret==true then
  print("all gos dead")
 end
 return ret
end

function checkevtlist()
 for i,e in ipairs (evts)
 do
  if e.t<lvltime then
   table.insert(gos,initpunk(e.x,e.y))
   table.remove(evts,i)
  end
 end
 
 --check victory
 left=tbllngth(evts)
 --print(left .. " evts left " )
 if  left==0 
 and allgosdead() 
 then
  gotovictory()
 end
end

function updategame()
 

  lvltime=lvltime+1
 
 checkevtlist()
 
 
 -- tickuprank()
 -- maintainglobrank()
 tickanimstep()
 
 
  -- overlayopacity=rankcounter/28*255
 
  -- if rankcounter>=28 then
   -- lives=lives-1
   
   -- if lives==0 then
    -- initgameover()
    -- finalpic=gameover
    -- drawfunc=drawgameover
    -- updatefunc=updategameover
   -- else
    -- levels[lvlglob.current]()
    -- initlives()
    -- drawfunc=drawlives
    -- updatefunc=updatelives
  
   -- end
  -- end
 
 
 
 
 -- if to_apply ~=nil then
  -- for i,v in pairs(to_apply) 
  -- do
   -- -- print("bhv")
   -- -- v.behavior(v,i) 
   -- tx=tx+v.ox
   -- ty=ty+v.oy
   -- table.remove(to_apply,i)
  -- end
  
 
 -- end
 
 
 -- local tx=ply.x
 -- local ty=ply.y

 
 -- local bxdir,bydir
 -- bxdir=xdir
 -- bydir=ydir
 
 -- xdir=0
 -- ydir=0
 
 for i,p in ipairs(gos) 
 do
  p.move(p)
 
 end

 
 j=polljoy()

 moveply(j)
 
 firepressed = love.keyboard.isDown("space") or j.mainfire==true

 -- if firepressed then
  -- gotovictory()
 -- end
 
 -- if love.keyboard.isDown("left") or love.keyboard.isDown("a") or j.left~=nil then
  -- gotogameover()
 -- end
 
 
 
 -- if love.keyboard.isDown('b') then 
	-- displayboxs=true
 -- end
 -- if love.keyboard.isDown('n') then
	-- displayboxs=false
-- end
 
 -- if love.keyboard.isDown("left") or love.keyboard.isDown("a") or j.left~=nil then
  -- if firepressed==false then
   -- tx=ply.x-plyspeed
  -- end
  -- xdir=-1
  -- facing="l"
 -- end
 -- if love.keyboard.isDown("right") or love.keyboard.isDown("d") or j.right~=nil then
  -- if firepressed==false then
   -- tx=ply.x+plyspeed
  -- end
  -- xdir=1
  -- facing="r"
 -- end
 -- if love.keyboard.isDown("up") or love.keyboard.isDown("w") or j.up~=nil then
  -- if firepressed==false then
   -- ty=ply.y-plyspeed
  -- end
  -- ydir=-1
  -- facing="u"
 -- end
 -- if love.keyboard.isDown("down") or love.keyboard.isDown("s") or j.down~=nil then
  -- if firepressed==false then
   -- ty=ply.y+plyspeed
  -- end
  -- ydir=1
  -- facing="d"
 -- end
 
 -- if xdir==0 and ydir==0 then
  -- xdir=bxdir
  -- ydir=bydir
 -- end
  
 -- if firepressed or fingertwoid~=nil or j.mainfire~=nil then
  -- fireBullet(ply.x,ply.y+ply.h/2)
  -- -- print("fire")
 -- end

 -- -- print("ply.w ")
 -- -- print(ply.w)
 -- if outofpf(tx,ty,ply.w,ply.h)==false and checkblockingcoll(tx,ty)==false then
  -- --nothing
  -- -- print("BLOCKING")
 -- -- else
  -- ply.x=tx
  -- ply.y=ty
 -- end
 
 -- nav=false
 
 -- if plycx()>pfw-16 then
  -- nav=emptybordernav(1,0)
 -- elseif plycy()>pfh-16 then
  -- nav=emptybordernav(0,1)
 -- elseif plycx()<16 then
  -- nav=emptybordernav(-1,0)
 -- elseif plycy()<16 then
  -- nav=emptybordernav(0,-1)  
 -- end
 
 -- if nav==true then
    -- print("nav true")
	-- --see you on next screen
	-- return
 -- end
 
 -- for i,v in pairs(curscreen.gos) 
 -- do
  -- -- print("bhv")
  -- v.bfunc(v,i) 
  
 -- end
 
 
 -- if bulletinhib>0 then
  -- bulletinhib=bulletinhib-1
 -- end
 
 -- for i,v in pairs(bullets) 
 -- do
  -- -- print("bhv")
  -- v.behavior(v,i) 
 -- end
 
 
 -- --tick firezoom factor
 -- fireinctimer=fireinctimer+1
 -- if fireinctimer>=fireincchg then
  -- fireinctimer=0
 -- end
 
 -- if checkvictory() then
  -- if levels[lvlglob.current+1]~=nil then
   -- outrotimer=120
   -- updatefunc=updatelvloutro
  -- -- lvlglob.current=lvlglob.current+1
   -- -- levels[lvlglob.current]()
   -- -- return
  -- else
   -- gotovictory()
   -- return
  -- end
 -- end
end

function gotogameover()
   finalpic=gameover
   initgameover()
   drawfunc=drawgameover
   updatefunc=updategameover

end

function gotovictory()
   finalpic=victory
   initgameover()
   drawfunc=drawgameover
   updatefunc=updategameover

end