function initlives()
	liveswait=90

end


function updatelives()
 tickanimstep()
 if liveswait>0 then
	liveswait=liveswait-1
 else
   drawfunc=drawgame
   introtimer=refintrotimer
	updatefunc=updatelvlintro
 end

end



function drawlives()

 love.graphics.setCanvas(vscreen)
 love.graphics.clear()
 -- love.graphics.draw(finalpic,0,0)

 -- if gameoverwait==0 then
	-- -- print(animstep)
	-- love.graphics.draw(pbframes[animstep],cvsw-64,cvsh-64)
 -- end
 
 -- love.graphics.print("game over!",200,200)
 -- love.graphics.print("your score",200,300)

 -- love.graphics.print("you have no real score you couldn't keep them calm !",20,540)

 -- love.graphics.print(score,200,570)
 love.graphics.print("lives X "..lives,200,300)

 rdrvscreen()


end 