--[[
*****************************************************************************************
*        COPYRIGHT � 2020 Mark Parker/mSparks CC-BY-NC4
*****************************************************************************************
]]
fmsFunctions={}
dofile("acars/acars.lua")

fmsPages["NAVRAD"]=createPage("NAVRAD")
fmsPages["NAVRAD"]["template"]={

"        NAV RADIO       ",
"                        ",
string.format("%6.2f %4s  %4s %6.2f", simDR_radio_nav_freq_hz[2]*0.01, simDR_radio_nav03_ID, simDR_radio_nav04_ID, simDR_radio_nav_freq_hz[3]*0.01),
string.format("                        ", ""),
string.format(" %03d     %3s  %3s    %03d", simDR_radio_nav_obs_deg[2], "---", "---", simDR_radio_nav_obs_deg[3]),
"                        ",
string.format("%06.1f         %06.1f   ", simDR_radio_adf1_freq_hz, simDR_radio_adf2_freq_hz),
"                        ",
string.format("%6.2f/%03d%s             ", simDR_radio_nav_freq_hz[0]*0.01, simDR_radio_nav_obs_deg[0], "˚"),
"                        ",
"                        ", 
"                        ",
"<ACARS                  "
}
fmsPages["NAVRAD"]["templateSmall"]={
"                        ",
" VOR L             VOR R",
"      M         M       ",
" CRS      RADIAL     CRS",
"                        ",
" ADF L             ADF R",
"      ANT            ANT",
" ILS                    ",
"           M            ",
"                        ",
"                        ",
"                        ",
"                        ",
}

fmsFunctionsDefs["INDEX"]={}
fmsFunctionsDefs["INDEX"]["L3"]={"setpage","ACARS"}

fmsFunctionsDefs["NAVRAD"]["L6"]={"setpage","ACARS"}

function fmsFunctions.setpage(fmsO,value)
  fmsO["pgNo"]=1
  fmsO["inCustomFMC"]=true
  fmsO["currentPage"]=value 
 print("setpage " .. value)
end

function fmsFunctions.setdata(fmsO,value) 
  if value=="depdst" then
    dep=string.sub(fmsO["scratchpad"],1,4)
    dst=string.sub(fmsO["scratchpad"],-4)
    --fmsModules["data"]["fltdep"]=dep
    --fmsModules["data"]["fltdst"]=dst
    setFMSData("fltdep",dep)
    setFMSData("fltdst",dst)
  elseif value=="flttime" then 
    hhV=string.sub(fmsO["scratchpad"],1,2)
    mmV=string.sub(fmsO["scratchpad"],-2)
    setFMSData("flttimehh",hhV)
    setFMSData("flttimemm",mmV)
  elseif value=="rpttime" then 
    hhV=string.sub(fmsO["scratchpad"],1,2)
    mmV=string.sub(fmsO["scratchpad"],-2)
    setFMSData("rpttimehh",hhV)
    setFMSData("rpttimemm",mmV)
  elseif value=="fltdate" then 
    setFMSData("fltdate",os.date("%Y%m%d"))
  else
    setFMSData(value,fmsO["scratchpad"])
  end
  fmsO["scratchpad"]=""
end

function fmsFunctions.showmessage(fmsO,value)
  acarsSystem.currentMessage=value
  fmsO["inCustomFMC"]=true
  fmsO["currentPage"]="VIEWACARSMSG" 
end