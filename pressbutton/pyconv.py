import pygame
import os
from pygame.locals import *


pics=[
    "pb1ts.png",
    "pb2ts.png",
##    "bf3ts.png"
    ]

colorkey=pygame.Color(10,200,200,255)


x1=148
y1=256
x2=383
y2=472
w=x2-x1
h=y2-y1


target=[
        {"name":"pb","area":pygame.Rect(x1,y1,x2-x1,y2-y1)  }
##        {"name":"down","area":pygame.Rect(232,80,178,349-80)  },
##        {"name":"right","area":pygame.Rect(398,80,178,349-80)  },
##        {"name":"left","area":pygame.Rect(398,80,178,349-80) ,"invert":True }

    ]

##tgtwidth=64
##tgtheight=int(tgtwidth*h/w)
tgtwidth=64
tgtheight=int(tgtwidth*h/w)

pygame.init()
i=1
for pic in pics:
    print( pic )
    src=pygame.image.load(pic)
    src.set_colorkey(colorkey)
    for tgt in target:
        print(tgt)
        tgtsurf=pygame.Surface((tgt["area"].w,tgt["area"].h))
        tgtsurf.blit(src,(0,0),tgt["area"])
        if "invert" in tgt :
            tgtsurf=pygame.transform.flip(tgtsurf,True,False)
        
        
        tgtsurf=pygame.transform.scale(tgtsurf,(tgtwidth,tgtheight))
        
        pygame.image.save(tgtsurf,tgt["name"]+str(i)+".png")
        
    i=i+1
pygame.quit()
