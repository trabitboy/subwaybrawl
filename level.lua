
function freshevtlist()
 eventlist={}
 table.insert(eventlist,{x=300,y=99,f='l',t=10})
 table.insert(eventlist,{x=300,y=100,f='l',t=10*60})

 table.insert(eventlist,{x=-100,y=101,f='r',t=20*60})
 table.insert(eventlist,{x=300,y=98,f='l',t=20*60})


 table.insert(eventlist,{x=-100,y=0,f='r',t=40*60})
 table.insert(eventlist,{x=300,y=1,f='l',t=40*60})
 table.insert(eventlist,{x=-100,y=102,f='r',t=40*60})




 table.insert(eventlist,{x=-100,y=103,f='r',t=60*60})

 table.insert(eventlist,{x=300,y=2,f='l',t=60*60})
 table.insert(eventlist,{x=-100,y=5,f='r',t=60*60})
 table.insert(eventlist,{x=300,y=94,f='l',t=60*60})

 
 table.insert(eventlist,{x=-100,y=6,f='r',t=80*60})
 table.insert(eventlist,{x=300,y=31,f='l',t=80*60})
 table.insert(eventlist,{x=-100,y=56,f='r',t=80*60})
 table.insert(eventlist,{x=300,y=75,f='l',t=80*60})
 table.insert(eventlist,{x=-100,y=110,f='r',t=80*60})
 table.insert(eventlist,{x=300,y=150,f='l',t=80*60})

 
 
 
 return eventlist
end