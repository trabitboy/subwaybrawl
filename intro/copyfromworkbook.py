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
    # {'i':"069",'t':"bg"},
    {'i':"039",'t':"t1"},
    {'i':"040",'t':"t2"},
    {'i':"041",'t':"t3"},
    {'i':"042",'t':"t4"},
    {'i':"043",'t':"t5"},
    {'i':"044",'t':"t6"},

    ]

for obj in tomove:
    print(obj)
##    key=obj.keys().get(0)
    src=pygame.image.load(wb+"frame"+obj['i']+'.bmp')
    pygame.image.save(src,tgt+obj['t']+'ts.png')
