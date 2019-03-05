
numvid=1

vids={
	'demovids/lv1trailer.ogv',
	-- 'demovids/boss1trailer.ogv',
	'demovids/lv2trailer.ogv',
	-- 'demovids/boss2trailer.ogv',
}

function initvideo()
 love.audio.stop()
 numvid=numvid+1
 if numvid>tbllngth(vids) then
  numvid=1
 end
 print (" numvid played "..numvid)
 video = love.graphics.newVideo( vids[numvid] )
 video:play()
end

function updatevideo()
 tickanimstep()
 j=polljoy()

 if love.keyboard.isDown("space") or j.mainfire==true  then
  video:pause()
  inittitle()
  updatefunc=updatetitle
  drawfunc=drawtitle
 end
 
 if video:isPlaying()==false then
    love.audio.stop()
	love.audio.play(ambiance) 
  inittitle()
  updatefunc=updatetitle
  drawfunc=drawtitle
  
 end
end


function drawvideo()
 love.graphics.setCanvas(vscreen)
 
 love.graphics.draw(video)

 if titlewait==0 then
	-- print(animstep)
	love.graphics.draw(pbframes[animstep].pic,cvsw-64,cvsh-64)
 end

 rdrvscreen()

end