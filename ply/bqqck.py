import pygame
import os
from pygame.locals import *



pics=[
# "frame003.bmp",
"frame006.bmp",
# "frame005.bmp"
]

colorkey=pygame.Color(10,200,200,255)

src = 'C:/Users/thomas/Dropbox/current_zazanim_projects/subrawl'

target=[
        # {"name":"up","area":pygame.Rect(47,80,225-47,349-80)  },
# ##        {"name":"down","area":pygame.Rect(232,80,178,349-80)  },
        # {"name":"down","area":pygame.Rect(222,80,178,349-80)  },
        {"name":"right","area":pygame.Rect(268,117,417-268,409-117)  },
        # {"name":"left","area":pygame.Rect(398,80,178,349-80) ,"invert":True }
        
    ]

tgtwidth=64
tgtheight=int(64*269/178)

pygame.init()
i=1
for pic in pics:
    print( pic )
    src=pygame.image.load(src+"/"+pic)
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
