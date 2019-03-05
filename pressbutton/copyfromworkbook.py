#copy level frames from zzn workbook
#renames
#TODO calculate forbidden areas and save as lua source
import pygame
import os
import shutil
from pygame.locals import *

wb="c:/Users/thomas/Dropbox/current_zazanim_projects/subrawl/"
tgt="./"

tomove=[
##    {'i':"047",'t':"1b"},
##    {'i':"048",'t':"1bw"},
##    {'i':"049",'t':"1a"},
##    {'i':"055",'t':"bf1"},
    {'i':"047",'t':"pb1"},
    {'i':"048",'t':"pb2"},

    ]

for obj in tomove:
    print(obj)
##    key=obj.keys().get(0)
    src=pygame.image.load(wb+"frame"+obj['i']+'.bmp')
    pygame.image.save(src,tgt+obj['t']+'ts.png')
