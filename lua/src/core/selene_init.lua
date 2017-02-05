function selene_init()local function a(b,c,...)c=type(c)local function d(e,...)if not e then return false else return c==e or d(...)end end;if not d(...)then local g=string.format("bad argument #%d (%s expected, got %s)",b,table.concat({...}," or "),c)error(g,3)end end;local function h(i)local k;if type(i)=='table'then k={}for l,m in pairs(i)do k[l]=m end else k=i end;return k end;local function n(o,p,q)a(1,o,"number")a(2,p,"number","nil")a(3,q,"number","nil")if not p and q then return math.min(o,q)elseif p and not q then return math.max(o,p)else return math.max(math.min(o,q),p)end end;local function r(s,t)a(1,s,"table","function")a(2,t,"number","nil")if type(s)=="function"then return t end;local u=getmetatable(s)return u and u.parCount or t end;local function v(s)if type(s)=="table"then local u=getmetatable(s)return u and u.ltype or"table"end;return type(s)end;local function w(x)a(1,x,"table")local y=v(x)if y=="list"or y=="stringlist"then return true elseif y=="map"then return false elseif y=="table"then for z in pairs(x)do if type(z)~="number"then return false elseif z<1 then return false end end;return true end;return false end;local function A(b,c)if not w(c)then local g=string.format("[Selene] bad argument #%d (list expected, got %s)",b,c)error(g,2)end end;local function B(C,D,E,F)D=D or false;if F then if D then table.insert(C,F)else C[E]=F end else table.insert(C,E)end end;local function G(s)if type(s)=="table"and w(s)then return ipairs(s)else return pairs(s)end end;local H={map=true,list=true,stringlist=true}local function I(s)if H[v(s)]then return G(s)else return pairs(s)end end;local J={"map","list","stringlist"}local function K(b,c,...)c=v(c)local L={...}if#L==0 then L=J end;local function d(e,...)if not e then return false else return c==e or d(...)end end;if not d(table.unpack(L))then local g=string.format("[Selene] bad argument #%d (%s expected, got %s)",b,table.concat({...}," or "),c)error(g,3)end end;local function M(b,c,...)K(b,c,"function")if type(c)=="function"then return end;local N=r(c,nil)c=type(c)if not N then local g=string.format("[Selene] bad argument #%d (function expected, got %s)",b,c)error(g,2)end;if#{...}==0 then return end;local O=3;local function d(e,...)a(O,e,"number")if not e then return false else O=O+1;return N==e or d(...)end end;if not d(...)then local g=string.format("[Selene] bad argument #%d (%s parameter(s) expected, got %s)",b,table.concat({...}," or "),N)error(g,3)end end;local P={__call=function(C)return C._tbl end,__len=function(C)return#C._tbl end,__pairs=function(C)return pairs(C._tbl)end,__ipairs=function(C)return ipairs(C._tbl)end,__tostring=function(C)return tostring(C._tbl)end,__index=function(C,E)return C._tbl[E]end,__newindex=function(C,E,Q)error("[Selene] attempt to insert value into "..v(C),2)end,ltype="map"}local R=h(P)R.ltype="list"local S={__call=function(T,...)return T._fnc(...)end,__len=function(T)return#T._fnc end,__pairs=function(T)return pairs(T._fnc)end,__ipairs=function(T)return ipairs(T._fnc)end,__tostring=function(T)return tostring(T._fnc)end,__index=function(T,E)return T._fnc[E]end,__newindex=P.__newindex,ltype="function"}local U={}local V={}local W=h(P)W.ltype="stringlist"W.__call=function(X)return table.concat(X._tbl)end;W.__tostring=W.__call;local function Y(...)local x=...if#{...}>1 or type(x)~="table"then x={...}end;x=x or{}local Z={}for z,j in pairs(U)do Z[z]=j end;Z._tbl=x;setmetatable(Z,P)return Z end;local function _(a0)a(1,a0,"table","nil")a0=a0 or{}local Z={}for z,j in pairs(V)do Z[z]=j end;Z._tbl={}for z=1,#a0 do if not a0[z]or type(a0[z])~="string"or#a0[z]>1 then error("[Selene] could not create list: bad table key: "..z.." is not a character",2)end;Z._tbl[z]=a0[z]end;setmetatable(Z,W)return Z end;local function a1(a0)a(1,a0,"string","nil")a0=a0 or""local Z={}for z,j in pairs(V)do Z[z]=j end;Z._tbl={}for z=1,#a0 do Z._tbl[z]=a0:sub(z,z)end;setmetatable(Z,W)return Z end;local function a2(...)local Z=Y(...)for z in pairs(Z._tbl)do if type(z)~="number"then error("[Selene] could not create list: bad table key: "..z.." is not a number",2)elseif z<1 then error("[Selene] could not create list: bad table key: "..z.." is below 1",2)end end;setmetatable(Z,R)return Z end;local function a3(...)local Z=Y(...)for z in pairs(Z._tbl)do if type(z)~="number"then return Z elseif z<1 then return Z end end;setmetatable(Z,R)return Z end;local function a4(f,a5)a(1,f,"function")a(2,a5,"number")if a5<0 then error("[Selene] could not create function: bad parameter amount: "..a5 .." is below 0",2)end;local a6={}local a7=h(S)a6._fnc=f;a7.parCount=a5;setmetatable(a6,a7)return a6 end;local function a8(x)if type(x)=="string"then return a1(x)else return a3(x)end end;P.__concat=function(a9,aa)local ab=v(a9)if ab=="map"and type(aa)=="table"then local ac=h(a9._tbl)for l,m in I(aa)do ac[l]=m end;return a3(ac)else local ad=v(aa)error(string.format("[Selene] attempt to concatenate %s and %s (cannot insert %s into %s)",ab,ad,ad,ab),2)end end;local function ae(a9,aa,af)local ab=v(a9)if(ab=="list"or ab=="stringlist")and af(aa)then local ac=h(a9._tbl)for ag,m in ipairs(aa)do table.insert(ac,m)end;return a3(ac)else local ad=v(aa)error(string.format("[Selene] attempt to concatenate %s and %s (cannot insert %s into %s)",ab,ad,ad,ab),2)end end;R.__concat=function(a9,aa)return ae(a9,aa,w)end;local function ah(Q)return v(Q)=="stringlist"end;W.__concat=function(a9,aa)return ae(a9,aa,ah)end;R.__add=function(a9,aa)local ab=v(a9)if ab=="list"then local ac=h(a9._tbl)table.insert(ac,aa)return a3(ac)else local ad=v(aa)error(string.format("[Selene] attempt to add %s and %s (cannot insert %s into %s)",ab,ad,ad,ab),2)end end;local function ai(self,aj)return aj+1,#self end;local function ak(self,aj)return 1,#self-aj end;local function al(self,aj)return 1,aj end;local function am(self,aj)return#self-aj+1,#self end;local function an(z,j)return j end;local function ao(z,j)return z,j end;local function ap(self)return self end;local function aq(self)return a3({})end;local function ar(a5)if a5==1 then return an else return ao end end;local function as(self,at,z,j)return table.concat(self._tbl,at,z,j)end;local function au(self,f)K(1,self)M(2,f)local a5=ar(r(f,2))for z,j in G(self)do f(a5(z,j))end end;local function av(self,f)K(1,self)M(2,f)local aw={}local a5=ar(r(f,2))for z,j in G(self)do B(aw,false,f(a5(z,j)))end;return a3(aw)end;local function ax(self,f)K(1,self,"map","list")M(2,f)local ay=false;do if v(self)=="list"then ay=true end end;local az={}local a5=ar(r(f,2))for z,j in G(self)do if f(a5(z,j))then B(az,ay,z,j)end end;return a3(az)end;local function aA(self,aj,aB)local aC={}local aD,aE=aB(self,aj)for z=aD,aE do B(aC,false,self._tbl[z])end;return a3(aC)end;local function aF(self,aj,aB)return self:sub(aB(self,aj))end;local function aG(self,aj,aB,aH,aI,aJ)if aj==0 then return aH(self)elseif aj==#self then return aI(self)else return aJ(self,aj,aB)end end;local function aK(self,aj,aB,aH,aI)K(1,self,"list","stringlist")a(2,aj,"number")aj=n(aj,0,#self)return aG(self,aj,aB,aH,aI,aA)end;local function aL(self,aj)return aK(self,aj,ai,ap,aq)end;local function aM(self,aj)return aK(self,aj,ak,ap,aq)end;local function aN(self,aj)return aK(self,aj,al,aq,ap)end;local function aO(self,aj)return aK(self,aj,am,aq,ap)end;local function aP(self,f,aB,aH,aI)K(1,self,"list","stringlist")M(2,f)local a5=ar(r(f,2))local aQ=0;for z,j in G(self)do if not f(a5(z,j))then break end;aQ=z end;return aG(self,aQ,aB,aH,aI,aA)end;local function aR(self,f)return aP(self,f,ai,ap,aq)end;local function aS(self,f)return aP(self,f,al,aq,ap)end;local function aT(self,aD,aE,aU,aV,aW)a(2,aD,"number","nil")a(3,aE,"number","nil")a(4,aU,"number","nil")aU=aU or 1;if aU==0 then error("[Selene] bad argument #4 (got step size of 0)",3)end;aD=math.max(1,(not aD or aD==0)and(aU<0 and#self or 1)or aD<0 and aD+#self+1 or aD)aE=math.min(#self,(not aE or aE==0)and(aU<0 and 1 or#self)or aE<0 and aE+#self+1 or aE)local aX={}for z=aD,aE,aU do B(aX,false,aV(self,z))end;return aW(aX)end;local function aY(self,z)return self._tbl[z]end;local function aZ(self,aD,aE,aU)K(1,self,"list","stringlist")return aT(self,aD,aE,aU,aY,a3)end;local function a_(self,b0)K(1,self,"list","stringlist")local b1={}for z,j in G(self)do table.insert(b1,1,j)end;return b0(b1)end;local function b2(self)return a_(self,a3)end;local function b3(self)local b4={}for z,j in G(self)do b4[j]=z end;return b4 end;local function b5(self)K(1,self)return a3(b3(self))end;local function b6(self,aD,f)K(1,self)M(3,f)local u=aD;for z,j in G(self)do u=f(u,j)end;return u end;local function b7(self,aD,f)return b6(b2(self),aD,f)end;local function b8(self,f)K(1,self,"list","stringlist")M(2,f)if#self<=0 then error("[Selene] bad argument #1 (got empty list)",2)end;local u=self[1]for z=2,#self do u=f(u,self._tbl[z])end;return u end;local function b9(self,f)return b8(b2(self),f)end;local function ba(self,f)K(1,self)M(2,f)local a5=ar(r(f,2))for z,j in G(self)do if f(a5(z,j))then return j end end end;local function bb(self)a(1,self,"table")local bc={}for z,j in ipairs(self)do if type(j)=="table"and w(j)then for l,m in ipairs(j)do if m~=nil then table.insert(bc,m)end end elseif j~=nil then table.insert(bc,j)end end;return bc end;local function bd(self)K(1,self,"list")return a3(bb(self._tbl))end;local function be(self,f)K(1,self)M(2,f)local aw={}local a5=ar(r(f,2))for z,j in G(self)do local bf,bg=f(a5(z,j))if bg==nil and type(bf)=="table"and w(bf)then for l,m in ipairs(bf)do if m~=nil then B(aw,false,m)end end elseif bf~=nil then B(aw,false,bf,bg)end end;return a3(aw)end;local function bh(self,bi)K(1,self,"list","stringlist")K(2,bi,"list","stringlist","function","table")local bj={}local y=v(bi)if y=="function"then local a5=ar(r(bi,2))for z,j in G(self)do table.insert(bj,{j,f(a5(z,j))})end elseif y=="table"then A(2,bi)assert(#self==#bi,"length mismatch in zip: Argument #1 has "..tostring(#self)..", argument #2 has "..tostring(#bi))for z in G(self)do table.insert(bj,{self._tbl[z],bi[z]})end else assert(#self==#bi,"length mismatch in zip: Argument #1 has "..tostring(#self)..", argument #2 has "..tostring(#bi))for z in G(self)do table.insert(bj,{self._tbl[z],bi._tbl[z]})end end;return a2(bj)end;local function bk(self,Q)K(1,self)for z,j in G(self)do if j==Q then return true end end;return false end;local function bl(self,E)K(1,self)return self._tbl[E]~=nil end;local function bm(self,f)K(1,self)M(2,f)local a5=ar(r(f,2))local bn=0;for z,j in G(self)do if f(a5(z,j))then bn=bn+1 end end;return bn end;local function bo(self,f)K(1,self)M(2,f)local a5=ar(r(f,2))for z,j in G(self)do if f(a5(z,j))then return true end end;return false end;local function bp(self,f)K(1,self)M(2,f)local a5=ar(r(f,2))for z,j in G(self)do if not f(a5(z,j))then return false end end;return true end;local function bq(self)local br={}for z in G(self)do table.insert(br,z)end;return br end;local function bs(self)local bt={}for ag,j in G(self)do table.insert(bt,j)end;return bt end;local function bu(self)K(1,self)for ag,j in ipairs(bq(self))do self._tbl[j]=nil end;return self end;local function bv(self)K(1,self)return a2(bq(self))end;local function bw(self)K(1,self)return a2(bs(self))end;local function bx(aD,aE,aU)a(1,aD,"number")a(2,aE,"number")a(3,aU,"number","nil")aU=aU or 1;local by={}for z=aD,aE,aU do table.insert(by,z)end;return by end;local function bz(bA,bB)K(1,bA,"table")K(2,bB,"table","function")A(1,bA)A(2,bB)local bj={}assert(#bA==#bB,"length mismatch in zip: Argument #1 has "..tostring(#bA)..", argument #2 has "..tostring(#bB))for z in ipairs(bA)do table.insert(bj,{bA[z],bB[z]})end;return bj end;local function bC(self,f,...)K(1,self)M(2,f)local bD=f(self._tbl,...)local bE=v(bD)if bE=="table"or bE=="string"then return a8(bD)else return bD end end;local function bF(self)K(1,self,"table")for ag,j in ipairs(bq(self))do self[j]=nil end;return self end;local function bG(self,f)K(1,self,"stringlist")M(2,f)local az={}local a5=ar(r(f))for z,j in G(self)do if f(a5(z,j))then B(az,false,a5(z,j))end end;return _(az)end;local function bH(self,aj,aB)K(1,self,"stringlist")self=aB(self,aj)return table.concat(self._tbl)end;local function bI(self,aj)return bH(self,aj,aL)end;local function bJ(self,aj)return bH(self,aj,aM)end;local function bK(self,aj)return bH(self,aj,aN)end;local function bL(self,aj)return bH(self,aj,aO)end;local function bM(self,f)return bH(self,f,aR)end;local function bN(self,f)return bH(self,f,aS)end;local function bO(self,aD,aE,aU)K(1,self,"stringlist")return aT(self,aD,aE,aU,aY,_)end;local function bP(self)return a_(self,_)end;local function bQ(self)return""end;local function bR(self,f)a(1,self,"string")M(2,f)local a5=ar(r(f))for z=1,#self do f(a5(z,j))end end;local function bS(self,f)a(1,self,"string")M(2,f)local aw={}local a5=ar(r(f))for z=1,#self do B(aw,false,f(a5(z,self:sub(z,z))))end;return a3(aw)end;local function bT(self,f)a(1,self,"string")M(2,f)local aw={}local a5=ar(r(f))for z=1,#self do local bf,bg=f(a5(z,self:sub(z,z)))if bg==nil and type(bf)=="table"and w(bf)then for l,m in ipairs(bf)do if m~=nil then B(aw,false,m)end end elseif bf~=nil then B(aw,false,bf,bg)end end;return a3(aw)end;local function bU(self,f)a(1,self,"string")M(2,f)local az={}local a5=ar(r(f))for z=1,#self do local j=self:sub(z,z)if f(a5(z,j))then B(az,false,a5(z,j))end end;return table.concat(az)end;local function bV(self,aj,aB,aH,aI)a(1,self,"string")a(2,aj,"number")aj=n(aj,0,#self)return aG(self,aj,aB,aH,aI,aF)end;local function bW(self,aj)return bV(self,aj,ai,ap,bQ)end;local function bX(self,aj)return bV(self,aj,ak,ap,bQ)end;local function bY(self,aj)return bV(self,aj,al,bQ,ap)end;local function bZ(self,aj)return bV(self,aj,am,bQ,ap)end;local function b_(self,f,aB,aH,aI)a(1,self,"string")M(2,f)local a5=ar(r(f))local c0=0;for z=1,#self do local a0=self:sub(z,z)if not f(a5(z,a0))then break end;c0=z end;return aG(self,c0,aB,aH,aI,aF)end;local function c1(self,f)return b_(self,f,ai,ap,bQ)end;local function c2(self,f)return b_(self,f,al,bQ,ap)end;local function c3(self,z)return self:sub(z,z)end;local function c4(self,aD,aE,aU)a(1,self,"string")return aT(self,aD,aE,aU,c3,_)end;local function c5(self,aD,f)a(1,self,"string")M(3,f)local u=aD;for z=1,#self do u=f(u,self:sub(z,z))end;return u end;local function c6(self,aD,f)return c5(self:reverse(),aD,f)end;local function c7(self,f)a(1,self,"string")M(3,f)if#self<=0 then error("[Selene] bad argument #1 (got empty string)",2)end;local u=self:sub(1,1)for z=2,#self do u=f(u,self:sub(z,z))end;return u end;local function c8(self,f)return c7(self:reverse(),f)end;local function c9(self,at)a(1,self,"string")a(2,at,"string","number","nil")local x={}if type(at)=="number"then while#self>0 do table.insert(x,self:sub(1,at))self=self:sub(at+1)end else at=at or""local ca;if#at<=0 then ca="."else ca="([^"..at.."]+)"end;for X in self:gmatch(ca)do table.insert(x,X)end end;return a2(x)end;local function cb(self,Q)a(1,self,"string")return string.find(self,Q,1,true)~=nil end;local function cc(self,f)a(1,self,"string")M(2,f)local a5=ar(r(f,2))local bn=0;for z=1,#self do if f(a5(z,self:sub(z,z)))then bn=bn+1 end end;return bn end;local function cd(self,f)a(1,self,"string")M(2,f)local a5=ar(r(f,2))for z=1,#self do if f(a5(z,self:sub(z,z)))then return true end end;return false end;local function ce(self,f)a(1,self,"string")M(2,f)local a5=ar(r(f,2))for z=1,#self do if not f(a5(z,self:sub(z,z)))then return false end end;return true end;local function cf(X,z)z=z+1;local a0=X:sub(z,z)if a0 and#a0>=1 then return z,a0 else return nil end end;local function cg(X)return cf,X,0 end;local function ch(bA,bB,ci)a(1,bA,"number")a(2,bB,"number")a(3,ci,"number")if not bit32 then return end;return bit32.bor(bit32.band(bit32.bnot(bA),bB,ci),bit32.band(bA,bit32.bnot(bB),ci),bit32.band(bA,bB,bit32.bnot(ci)))end;local function cj(bA,bB,ci)return not bA and bB and ci or bA and not bB and ci or bA and bB and not ci end;local ck=selene_parser()local function cl(cm,cn)return ck.parse(cm,cn)end;local co="Selene 0.1.0.4"local function cp(cq)cq.string.foreach=bR;cq.string.map=bS;cq.string.flatmap=bT;cq.string.filter=bU;cq.string.drop=bW;cq.string.dropright=bX;cq.string.dropwhile=c1;cq.string.take=bY;cq.string.takeright=bZ;cq.string.takewhile=c2;cq.string.slice=c4;cq.string.fold=c5;cq.string.foldleft=c5;cq.string.foldright=c6;cq.string.reduce=c7;cq.string.reduceleft=c7;cq.string.reduceright=c8;cq.string.split=c9;cq.string.contains=cb;cq.string.count=cc;cq.string.exists=cd;cq.string.forall=ce;cq.string.iter=cg;cq.table.shallowcopy=h;cq.table.flatten=function(C)A(1,C)return bb(C)end;cq.table.range=bx;cq.table.flip=function(C)a(1,C,"table")return b3(C)end;cq.table.zipped=bz;cq.table.clear=bF;cq.table.keys=function(C)a(1,C,"table")return bq(C)end;cq.table.values=function(C)a(1,C,"table")return bs(C)end;if cq.bit32 then cq.bit32.bfor=ch;cq.bit32.nfor=cj end end;local function cr()U.concat=as;U.foreach=au;U.map=av;U.flatmap=be;U.filter=ax;U.drop=aL;U.dropright=aM;U.dropwhile=aR;U.take=aN;U.takeright=aO;U.takewhile=aS;U.slice=aZ;U.reverse=b2;U.flip=b5;U.fold=b6;U.foldleft=b6;U.foldright=b7;U.reduce=b8;U.reduceleft=b8;U.reduceright=b9;U.find=ba;U.flatten=bd;U.zip=bh;U.contains=bk;U.containskey=bl;U.count=bm;U.exists=bo;U.forall=bp;U.call=bC;U.clear=bu;U.keys=bv;U.values=bw;U.shallowcopy=function(self)K(1,self)return a3(h(self._tbl))end;V.foreach=au;V.map=av;V.flatmap=be;V.filter=bG;V.drop=bI;V.dropright=bJ;V.dropwhile=bM;V.take=bK;V.takeright=bL;V.takewhile=bN;V.slice=bO;V.reverse=bP;V.flip=b5;V.foldleft=b6;V.foldright=b7;V.reduce=b8;V.reduceleft=b8;V.reduceright=b9;V.split=function(self,at)K(1,self,"stringlist")return c9(tostring(self),at)end;V.contains=bk;V.count=bm;V.exists=bo;V.forall=bp;V.iter=function(self)K(1,self,"stringlist")return cg(tostring(self))end;V.call=bC end;local function cs(cq,ct)if not cq or type(cq)~="table"then cq=_G or _ENV end;if cq._selene and cq._selene.isLoaded then return end;if not cq._selene then cq._selene={}end;if ct then cq._selene.liveMode=true end;cq._selene._new=a8;if not cq.checkArg then cq.checkArg=a end;cq._selene._newString=a1;cq._selene._newList=a2;cq._selene._newFunc=a4;cq._selene._VERSION=co;cq._selene._parse=cl;cq.ltype=v;cq.checkType=K;cq.checkFunc=M;cq.parCount=r;cq.lpairs=I;cq.isList=w;cp(cq)cr(cq)if cq._selene and cq._selene.liveMode then cq._selene.oldload=cq.load;cq.load=function(cu,cv,bg,cw)if cq._selene and cq._selene.liveMode then if type(cu)=="function"then local a0=""local cx=cu()while cx and#cx>0 do a0=a0 ..cx;cx=cu()end;cu=a0 end;cu=cq._selene._parse(cu)end;return cq._selene.oldload(cu,cv,bg,cw)end end;cq._selene.isLoaded=true end;local function cy(cq)if not cq or type(cq)~="table"then cq=_G or _ENV end;if not cq._selene or not cq._selene.isLoaded then return end;if cq._selene and cq._selene.liveMode and cq._selene.oldload then cq.load=cq._selene.oldload end;do local cz=cq._selene.liveMode;cq._selene={}cq._selene.liveMode=cz end;cq.ltype=nil;cq.checkType=nil;cq.checkFunc=nil;cq.parCount=nil;cq.lpairs=nil;cq.isList=nil;cq.string.foreach=nil;cq.string.map=nil;cq.string.flatmap=nil;cq.string.filter=nil;cq.string.drop=nil;cq.string.dropright=nil;cq.string.dropwhile=nil;cq.string.take=nil;cq.string.takeright=nil;cq.string.takewhile=nil;cq.string.slice=nil;cq.string.fold=nil;cq.string.foldleft=nil;cq.string.foldright=nil;cq.string.reduce=nil;cq.string.reduceleft=nil;cq.string.reduceright=nil;cq.string.split=nil;cq.string.contains=nil;cq.string.count=nil;cq.string.exists=nil;cq.string.forall=nil;cq.string.iter=nil;cq.table.shallowcopy=nil;cq.table.flatten=nil;cq.table.range=nil;cq.table.flip=nil;cq.table.zipped=nil;cq.table.clear=nil;cq.table.keys=nil;cq.table.values=nil;if cq.bit32 then cq.bit32.bfor=nil;cq.bit32.nfor=nil end;cq._selene.isLoaded=false end;if _selene and not _selene.isLoaded and _selene.doAutoload then cs(_G or _ENV)end;local cA={}cA.parser=ck;cA.parse=cl;cA.load=cs;cA.unload=cy;cA.isLoaded=function()return _selene and _selene.isLoaded end;return cA end
