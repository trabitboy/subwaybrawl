baseplyhealth=4
sensibilitydist=64
plyfeet=267
bdmgwin=96
edmgwin=164
deathtime=240

verticaltolerance=32
local stuntime=30


plyframes={
	-- up={
		-- loadfilter("ply/up1.png"),
		-- loadfilter("ply/up2.png"),
		-- loadfilter("ply/up3.png")
	-- },
	-- down={
		-- loadfilter("ply/down1.png"),
		-- loadfilter("ply/down2.png"),
		-- loadfilter("ply/down3.png")	
	-- },
	left={
		loadfilter("ply/left1.png"),
		loadfilter("ply/left2.png"),
		loadfilter("ply/left3.png"),
		loadfilter("ply/left2.png"),
		
	},
	right={
		loadfilter("ply/right1.png"),
		loadfilter("ply/right2.png"),
		loadfilter("ply/right3.png"),
		loadfilter("ply/right2.png"),
	}	,
	pright={
		loadfilter("ply/pright1.png"),
		-- loadfilter("ply/right2.png"),
		-- loadfilter("ply/right3.png")
	}	,
	pleft={
		loadfilter("ply/pleft1.png"),
		-- loadfilter("ply/left2.png"),
		-- loadfilter("ply/left3.png")
		
	},
	sright={
		loadfilter("ply/sright1.png"),
		-- loadfilter("ply/right2.png"),
		-- loadfilter("ply/right3.png")
	}	,
	sleft={
		loadfilter("ply/sleft1.png"),
		-- loadfilter("ply/left2.png"),
		-- loadfilter("ply/left3.png")
		
	},
	dright={
		loadfilter("ply/dright1.png"),
		-- loadfilter("ply/right2.png"),
		-- loadfilter("ply/right3.png")
	}	,
	dleft={
		loadfilter("ply/dleft1.png"),
		-- loadfilter("ply/left2.png"),
		-- loadfilter("ply/left3.png")
		
	},
}

walking='w'
punching='p'
suffer='s'
still='st'
death='d'

preparing='pr'


local function getdmgwdw(p)
	ret={}
	if p.facing=='r' then
		ret.x=p.cx+bdmgwin
		ret.w=edmgwin-bdmgwin
	elseif p.facing=='l' then
		ret.x=p.cx-edmgwin
		ret.w=edmgwin-bdmgwin
	end
	return ret
end

--triggered from baddies
local function tostun(p)
	p.health=p.health-1
	p.state=suffer
	--maybe use a post mechanism ?
	p.stimer=createtimer(stuntime)
	p.stanm=plyframes.sleft
end

local function getsensibilitywdw(p)
	ret={}
	ret.x= p.cx-sensibilitydist
	ret.w= sensibilitydist*2
	return ret

end


local function maintaincxfromx()
	ply.cx=ply.x + plyframes.left[1].data:getWidth()/2
	
end

local function getvertwdw(p)
	ret={}
	ret.y= p.y+plyfeet-verticaltolerance
	ret.w= 2*verticaltolerance
	return ret

end


function initply()
	ply={}
	ply.health=baseplyhealth
	ply.x=0
	ply.y=100
	ply.pic=plyframes.right[1]
	ply.wkanm=plyframes.right
	
	ply.state=walking
	ply.facing='r'
	plyspeed=1

	maintaincxfromx()
	
	ply.getdmgwdw=getdmgwdw
	ply.getsensibilitywdw=getsensibilitywdw
	ply.getvertwdw=getvertwdw
	ply.tostun=tostun
	-- dbg={}
	-- dbg.x=1
end



function initpunch()
	ptimer = createtimer(30)
	ply.state=punching
	if ply.facing=='l' then
	 ply.panm=plyframes.pleft 
	elseif ply.facing=='r' then 
	 ply.panm=plyframes.pright
	end
	love.audio.play(swoosh) 
	-- ply.pic=ply.panm[1]
end

function todeathstate(p)
 p.state=death
 p.danm=plyframes.dright
 p.dtimer=createtimer(deathtime)
end

function moveply()

 firepressed = love.keyboard.isDown("space") or j.mainfire==true

 if ply.state==suffer then
	tick(ply.stimer)
	if ply.stimer.finished then
	 if ply.health<1 then
	  todeathstate(ply)
	  return
	 else
	  ply.state=walking
	 end
	end
 elseif ply.state==death then
  tick(ply.dtimer)
  if ply.dtimer.finished then
   gotogameover()
  end
 elseif ply.state==walking then
	tx=ply.x 
	ty=ply.y
	ply.pic=ply.wkanm[animstep]
	if firepressed then 
	 initpunch()
	 return
	end
 
	if love.keyboard.isDown("left") or love.keyboard.isDown("a") or j.left~=nil then
	 tx=ply.x-plyspeed
	 xdir=-1
	 ply.facing="l"
	 ply.wkanm=plyframes.left 
	end
	if love.keyboard.isDown("right") or love.keyboard.isDown("d") or j.right~=nil then
	 tx=ply.x+plyspeed
	 xdir=1
	 ply.facing="r"
	 ply.wkanm=plyframes.right
	end
	 if love.keyboard.isDown("up") or love.keyboard.isDown("w") or j.up~=nil then
	   ty=ply.y-plyspeed*2
	 end
	 if love.keyboard.isDown("down") or love.keyboard.isDown("s") or j.down~=nil then
	   ty=ply.y+plyspeed*2
	 end

	if ty<-100
	or tx+64<0
	or tx+64>540
	or ty>380
	then 
	 return
	end
	
    ply.x=tx
	ply.y=ty

 elseif ply.state==punching then
  	tick(ptimer)
	if ptimer.finished then
	 ply.state=walking
	 return
	end
 end
 
 
 maintaincxfromx()
end


function plyframe()
 if ply.state==walking then
	return ply.wkanm[a4step]
 elseif ply.state==punching then
	return ply.panm[1]
 elseif ply.state==suffer then
	return ply.stanm[1]
 elseif ply.state==death then
	return ply.danm[1]
 end
 -- return ply.pic
end
