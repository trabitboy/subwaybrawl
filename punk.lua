--detection
local range=96
--hitrange
local hitrange=164
local preptime=90
local hittolerance= 64
 punkfeet=321

punkframes={
	-- up={
		-- loadfilter("ply/up1.png"),
		-- loadfilter("punk/up2.png"),
		-- loadfilter("punk/up3.png")
	-- },
	-- down={
		-- loadfilter("punk/down1.png"),
		-- loadfilter("punk/down2.png"),
		-- loadfilter("punk/down3.png")	
	-- },
	left={
		loadfilter("punk/left1.png"),
		loadfilter("punk/left2.png"),
		loadfilter("punk/left3.png"),
		loadfilter("punk/left2.png"),
		
	},
	right={
		loadfilter("punk/right1.png"),
		loadfilter("punk/right2.png"),
		loadfilter("punk/right3.png"),
		loadfilter("punk/right2.png"),
	}	,
	lpunch={
		loadfilter("punk/pleft1.png"),
		-- loadfilter("punk/pleft2.png"),
		-- loadfilter("punk/right2.png"),
		-- loadfilter("punk/right3.png")
	},	
	rpunch={
		loadfilter("punk/pright1.png"),
		-- loadfilter("punk/right2.png"),
		-- loadfilter("punk/right3.png")
	}	,
	lsuffer={
		loadfilter("punk/sleft1.png"),
	},	
	rsuffer={
		loadfilter("punk/sright1.png"),
	},	
	lprepare={
		loadfilter("punk/prleft1.png"),
		loadfilter("punk/prleft2.png"),
		loadfilter("punk/prleft3.png"),
		loadfilter("punk/prleft4.png"),
	},	
	rprepare={
		loadfilter("punk/prright1.png"),
		loadfilter("punk/prright2.png"),
		loadfilter("punk/prright3.png"),
		loadfilter("punk/prright4.png"),
	},
	ld={
		loadfilter("punk/dleft1.png"),
	},	
	rd={
		loadfilter("punk/dright1.png"),
	},	
}

function punkframe(p)
 if p.state==walking then
	return p.wkanm[a4step]
 elseif p.state==punching then
	return p.panm[1]
 elseif p.state==suffer then
	return p.sanm[1]
 elseif p.state==death then
	return p.sanm[1]
 elseif p.state==preparing then
	return p.pranm[a4step]
 end
 -- return ply.pic
end


local function getvertwdw(p)
	ret={}
	ret.y= p.y+punkfeet-verticaltolerance
	ret.w= 2*verticaltolerance
	return ret

end


local function hitwdw(p)
	ret={}
	ret.x=p.cx-hittolerance 
	ret.w=2*hittolerance
	return ret

end

local function reachwdw(p)
	ret={}
	if p.facing=='r' then
	 ret.x=p.cx
	 ret.w=range
	elseif p.facing=='l' then
	 ret.x=p.cx-range
	 ret.w=range
	end
	return ret

end

local function finalreachwdw(p)
	ret={}
	if p.facing=='r' then
	 ret.x=p.cx
	 ret.w=hitrange
	elseif p.facing=='l' then
	 ret.x=p.cx-hitrange
	 ret.w=hitrange
	end
	return ret

end


local function maintaincxfromx(p)
	p.cx=p.x + punkframes.left[1].data:getWidth()/2
end

function initpunk(x,y,dir)
	love.audio.play(eheheh)
	punk={}
	punk.x=x
	punk.y=y
	punk.pic=punkframes.left[1]
	punk.wkanm=punkframes.left
	
	punk.state=walking
	
	if dir=='l' then
		punk.facing='l'
		punk.speed=-1
	else
		punk.facing='r'
		punk.speed=1	
	end
	punk.health=3
	
	punk.frame=punkframe
	punk.move=movepunk
	punk.hitwdw=hitwdw
	punk.reachwdw=reachwdw
	punk.finalreachwdw=finalreachwdw
	punk.getvertwdw=getvertwdw
	maintaincxfromx(punk)
	-- dbg={}
	-- dbg.x=1
	
	return punk
end


function checkplyhit(p)
 if wdwoverlap(p.finalreachwdw(p),ply.getsensibilitywdw(ply))
 and ywdwoverlap(p.getvertwdw(p),ply.getvertwdw(ply))
 and ply.state~=death
 then
	print("PLY HIT!!!!!")
	love.audio.play(hardflat)
	ply.tostun(ply)
 end
end

--trigger in fact
function initpunkpunch(p)
	love.audio.play(swoosh) 

	p.ptimer = createtimer(30)
	p.state=punching
	if p.facing=='l' then
	 p.panm=punkframes.lpunch 
	else
	 p.panm=punkframes.rpunch
	end
	-- p.pic=punk.panm[1]
	
	checkplyhit(p)
	
end



function checkplyblow(p)

	hw=p.hitwdw(p)

	if ply.state==punching then
		--if punk is within hit window, it goes to suffer stqte
		
		--for this we need ply hit window
		wdw=ply.getdmgwdw(ply)
		
		if wdwoverlap(wdw,hw ) then
			love.audio.play(hardflat)
			print("HIT " )
			return true
		end
		
	end

end

function initdeathpunk(p)
	p.dtimer=createtimer(30)
	p.state=death
	if p.facing=='l' then
	 p.speed=1
	elseif p.facing=='r' then
	 p.speed=-1
	end
end

function initsufferpunk(p)

	p.health=p.health-1
	if p.health < 1 then
		initdeathpunk(p)
		return
	end

	print("suffer state todo")
	p.state=suffer
	p.sanm=punkframes.lsuffer
	
	p.stimer= createtimer(30)
end

function initprep(p)
 p.state=preparing
 p.prtimer=createtimer(preptime)
	if p.facing=='l' then
	 p.pranm=punkframes.lprepare
	elseif p.facing=='r' then
	 p.pranm=punkframes.rprepare
	end
end

function switchdir(p)
	if p.facing=='l' then
	 p.facing='r'
	 p.wkanm=punkframes.right 
	else 
	 p.facing='l'
	 p.wkanm=punkframes.left
	end
    p.speed=-p.speed

	p.x=p.x+p.speed*2 -- not to be stuck on border
end

function movepunk(p)

 maintaincxfromx(p)


 if p.state==walking then
 
	if p.cx<0 or p.cx>600 then 
     switchdir(p)
	 return
	end

 
 
	if checkplyblow(p) then
		initsufferpunk(p)
		return
	end


	if wdwoverlap(ply.getsensibilitywdw(ply),p.reachwdw(p))
	and ywdwoverlap(ply.getvertwdw(ply),p.getvertwdw(p))
	then 
		initprep(p)
		return
	end
	
	tx=p.x 
	ty=p.y
	-- p.pic=punk.wkanm[animstep]

	tx=tx+p.speed
	-- if love.keyboard.isDown("left") or love.keyboard.isDown("a") or j.left~=nil then
	 -- tx=punk.x-punkspeed
	 -- xdir=-1
	 -- facing="l"
	 -- punk.wkanm=punkframes.left 
	-- end
	-- if love.keyboard.isDown("right") or love.keyboard.isDown("d") or j.right~=nil then
	 -- tx=punk.x+punkspeed
	 -- xdir=1
	 -- facing="r"
	 -- punk.wkanm=punkframes.right
	-- end
	
	
	 
	 
	 
    p.x=tx
	p.y=ty
 elseif p.state==preparing then
  tick(p.prtimer)
  if p.prtimer.finished then
   initpunkpunch(p)
  end
 elseif p.state==punching then
  	tick(p.ptimer)
	if p.ptimer.finished then
	 p.state=walking
	 return
	end
 elseif p.state==suffer then
  	tick(p.stimer)
	if p.stimer.finished then
	 p.state=walking
	 return
	end	
 elseif p.state==death then
	--we could use the timer to apply trajectory
	
	tick(p.dtimer)
	if (p.dtimer.finished) then
	 p.speed=0
	 p.sanm=punkframes.ld
	end
	p.x=p.x+p.speed
  	-- tick(p.stimer)
	-- if p.stimer.finished then
	 -- p.state=walking
	 -- return
	-- end	
 end
 
end


