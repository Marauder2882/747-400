registerFMCCommand("sim/ground_ops/service_plane","GROUND SERVICES")
registerFMCCommand("sim/ground_ops/pushback_stop","STOP PUSHBACK")
registerFMCCommand("sim/ground_ops/pushback_left","PUSHBACK LEFT")
registerFMCCommand("sim/ground_ops/pushback_straight","PUSHBACK STRAIGHT")
registerFMCCommand("sim/ground_ops/pushback_right","PUSHBACK RIGHT")

fmsPages["GNDHNDL"]=createPage("GNDHNDL")
fmsPages["GNDHNDL"].getPage=function(self,pgNo,fmsID)
  local lineA="<REMOVE CHOCKS          "
  local LineB="<REQUEST GROUND SERVICES"
  local LineC="<REQUEST PUSH BACK      "	
  if B747DR__gear_chocked == 0.0 then
      lineA="<REQUEST CHOCKS         "
  end

  return {

  "     GROUND HANDLING    ",
  "                        ",
  "<GROUND SERVICES",
  "                        ",
  lineA,
  "                        ",
  "<PUSH BACK              ",
  "                        ",
  "                        ",
  "                        ",
  "  "..fmsModules["lastcmd"], 
  "                        ",
  "<INDEX                  "
  }
end

fmsPages["GNDHNDL"].getSmallPage=function(self,pgNo,fmsID)
  return {
  "                        ",
  "                        ",
  "                        ",
  "                        ",
  "                        ",
  "                        ",
  "                        ",
  "                        ",
  "                        ",
  "      LAST ACTION       ",
  "                        ",
  "                        ",
  "                        "
  }
end
fmsFunctionsDefs["GNDHNDL"]["L1"]={"setpage","GNDSRV"}
fmsFunctionsDefs["GNDHNDL"]["L2"]={"setDref","CHOCKS"}
fmsFunctionsDefs["GNDHNDL"]["L3"]={"setpage","PUSHBACK"} 
fmsFunctionsDefs["GNDHNDL"]["L6"]={"setpage","INDEX"}

fmsPages["GNDSRV"]=createPage("GNDSRV")
fmsPages["GNDSRV"].getPage=function(self,pgNo,fmsID)
  local lineA=string.format("%03d",B747DR_fuel_add)
	


  return {

  "     GROUND SERVICES    ",
  "                        ",
  "<REQUEST GROUND SERVICES",
  "                        ",
  "                        ",
  "                        ",
  " "..lineA,
  "                        ",
  "                        ",
  "                        ",
  "  "..fmsModules["lastcmd"], 
  "                        ",
  "<GND HNDL               "
  }
end

fmsPages["GNDSRV"].getSmallPage=function(self,pgNo,fmsID)
  return {
  "                        ",
  "                        ",
  "                        ",
  "                        ",
  "                        ",
  "ADD FUEL                ",
  "     x1000kg            ",
  "                        ",
  "                        ",
  "      LAST ACTION       ",
  "                        ",
  "                        ",
  "                        "
  }
end
fmsFunctionsDefs["GNDSRV"]["L1"]={"setdata","services"}
fmsFunctionsDefs["GNDSRV"]["L3"]={"setdata","fuelpreselect"}
fmsFunctionsDefs["GNDSRV"]["L6"]={"setpage","GNDHNDL"}

fmsPages["PUSHBACK"]=createPage("PUSHBACK")
fmsPages["PUSHBACK"].getPage=function(self,pgNo,fmsID)
  

  local LineA="<PUSHBACK LEFT          "
  local LineB="<STRAIGHT PUSHBACK      "
  local LineC="<PUSHBACK RIGHT         "
  local LineD="<REMOVE CHOCKS          "	
  if B747DR__gear_chocked == 0.0 then
      LineD="<REQUEST CHOCKS         "
  end
  if simDR_groundspeed>0.01 then 
    LineA="<STOP PUSHBACK          "
    LineB="                        "
    LineC="                        "
    fmsFunctionsDefs["PUSHBACK"]["L1"]={"doCMD","sim/ground_ops/pushback_stop"}
    fmsFunctionsDefs["PUSHBACK"]["L2"]=nil 
    fmsFunctionsDefs["PUSHBACK"]["L3"]=nil
  else
    fmsFunctionsDefs["PUSHBACK"]["L1"]={"doCMD","sim/ground_ops/pushback_left"}
    fmsFunctionsDefs["PUSHBACK"]["L2"]={"doCMD","sim/ground_ops/pushback_straight"} 
    fmsFunctionsDefs["PUSHBACK"]["L3"]={"doCMD","sim/ground_ops/pushback_right"}
  end

  return {

  "    PUSHBACK HANDLING   ",
  "                        ",
  LineA,
  "                        ",
  LineB,
  "                        ",
  LineC,
  "                        ",
  LineD,
  "                        ",
  "  "..fmsModules["lastcmd"], 
  "                        ",
  "<GND HNDL               "
  }
end
fmsPages["PUSHBACK"].getSmallPage=function(self,pgNo,fmsID)
  return {
  "                        ",
  "                        ",
  "                        ",
  "                        ",
  "                        ",
  "                        ",
  "                        ",
  "                        ",
  "                        ",
  "      LAST ACTION       ",
  "                        ",
  "                        ",
  "                        "
  }
end
fmsFunctionsDefs["PUSHBACK"]["L6"]={"setpage","GNDHNDL"}