Class nacl.GVC
{

ClassMethod Connect(
	serverIP = "192.168.0.9",
	serverPORT = 1972,
	namespace = "USER",
	username = "_SYSTEM",
	password = "SYS") As %Net.DB.Iris
{
  try {
    set %rccon=##class(%Net.DB.DataSource).CreateConnection(serverIP
                           ,serverPORT,namespace,username,password)
    set %rccdb=%rccon.CreateIris()
    }
  catch { zw  b  }  ;; do some error handling
  quit %rccdb
}

/// tosubscript stops loop
ClassMethod View(
	global As %String = "",
	fromsubscript As %List = "",
	tosubscript As %List = "")
{
  quit ..Copy(global,fromsubscript,tosubscript,"")
}

/// rename also works to local variable array
ClassMethod Copy(
	global As %String = "",
	fromsubscript As %List = "",
	tosubscript As %List = "",
	rename As %String = "*")
{
#dim %rccdb as %Net.DB.Iris
 set subs=..Args(fromsubscript)
 set stop=..Args(tosubscript)
 set:rename="*" rename="^"_global 
loop
 if $l(subs),$l(stop),$p(subs,stop)="" quit 1 
 set gx=""""_global_""""
#; write !?20,gx_subs   just for debug
 set x1="quit %rccdb.IsDefined("_gx_subs_")"
   , dd=$xecute(x1)
 if $l(stop),subs]]stop quit 1   
 if dd#10 { 
   set x2="quit %rccdb.Get("_gx_subs_")"
     , val=$xecute(x2)
     , tx=rename_$s($l(subs):"("_$e(subs,2,*)_")",1:"")
     , tv=##class(%Utility).FormatString(val)
     , x3="(val) set "_tx_"=val q 1 "
   if $l(rename),$xecute(x3,val) write tx," = ",tv,!    
   else  write "^",global,tx," = ",tv,!  
   }
up
 set down=$s(dd\10:",""""",1:"")
 set x4="quit %rccdb.GetNext(1,0,0,"_gx_subs_down_")"
   , nxsub=$xecute(x4)
 if nxsub="" {
   set dd=0 
   if down="" set subs=$p(subs,",",1,*-1)
   goto up
   } 
 if '$isvalidnum(nxsub) set nxsub=""""_nxsub_""""
 set $p(subs,",",*+(dd\10))=nxsub   
 if $l(subs,",")<2 quit 1
 goto loop
}

ClassMethod Args(list As %List = "") As %String
{
  if '$listvalid(list) set list=$lb(list)
  set ll=$ll(list),subs=""
  for i=1:1:ll {
    set sub=$li(list,i)
      , subs=subs_","_$s($isvalidnum(sub):sub,1:""""_sub_"""")
  }
  quit subs
}

}
