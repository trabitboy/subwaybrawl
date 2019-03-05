
-- difselmulti=1 --default value

difselframes={
	-- bg=loadfilter("intro/bgts.png"),
	-- truck={
		-- loadfilter("intro/t1ts.png"),
		-- loadfilter("intro/t2ts.png"),
		-- loadfilter("intro/t3ts.png"),
		-- loadfilter("intro/t4ts.png"),
		-- loadfilter("intro/t5ts.png"),
		-- loadfilter("intro/t6ts.png"),
		-- loadfilter("intro/t7ts.png"),
	-- }
}

easypic=loadfilter("difficultyselect/e.png")
normalpic=loadfilter("difficultyselect/m.png")
hardpic=loadfilter("difficultyselect/h.png")

function initdifsel()
 difselwait=60
 dfpic=normalpic
 difselmulti=0.5
end

function initdifselhard()
 difselwait=60
 dfpic=normalpic
 difselmulti=1
end


function updatedifsel()
 

 tickanimstep()

 if difselwait>0 then
	difselwait=difselwait-1
 else
 
	 j=polljoy()
    score=0
    lives=3
	 
	 if love.keyboard.isDown("space")  or j.mainfire~=nil  then
  	  inittuto()
	  drawfunc=drawtuto
	  updatefunc=updatetuto
	 end
	 
	 if love.keyboard.isDown("left") or j.left then
		print('easy mode')
		dfpic=easypic
		currenttable='easy'
		difselmulti=0.1
	 end

	 if love.keyboard.isDown("up") or j.up then
		print('normal mode')
		currenttable='normal'
		dfpic=normalpic
		difselmulti=0.3
		print("difselmulti "..difselmulti)
	end
	 
	 if love.keyboard.isDown("right") or j.right then
		print('hard mode')
		currenttable='hard'
		dfpic=hardpic
		difselmulti=1
	 end
	 
 end
end



function drawdifsel()
 love.graphics.setCanvas(vscreen)
 love.graphics.clear()
 -- love.graphics.draw(intro.bg,0,0)
  love.graphics.setColor(255,255,255,255) 

  love.graphics.draw(dfpic.pic,0,0)
 -- love.graphics.printf("letting food pass by calms everyone ",100,330,300,"center")

 if difselwait==0 then
	-- print(animstep)
	love.graphics.draw(pbframes[animstep].pic,cvsw-64,cvsh-64)
 end

 -- love.graphics.print("your score",200,300)
 -- love.graphics.print(score,200,400)
 rdrvscreen()
end 