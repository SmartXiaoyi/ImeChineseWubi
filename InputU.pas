{*************************************************************************}
{������뷨�ǰѱ��˵�ƴ���ĳ�������뷨�ˣ��������ֿ���������������cpu��}
{����,�ڵ���cpu�������ʴ�98���½���50��������Ӧ���ˣ��ⷽ��û�����޸�.���}
{���뷨���ص���:                                                        	}
{  1��������ĸֱ�Ӱ��س�ʱ����ֱ������Ӣ��.                              	}
{  2����һ�·ֺ�,�ٰ���ĸ�������������,�����,��,��,���ȡ�              	}
{  3�������Լ����ɾ���ִʡ�						                                  }
{  4�������Լ����ɾ�����š�						                                  }
{  5�����Ե��뵼���ʿ⼰���ſ⡣						                              }
{  6����ctrl���������Ӣ��ת����������԰�����������ƴ�����뷨�򿪣�����ƴ}
{�����뷨ʱ������ctrl�����С�						                                  }
{ 									                                                      }
{���⣺1��������360���������������ģ������Ӳ������á�			              }
{      2��ƴ������û����ɣ������á�					                            }
{������кõĽ���������˴��룬�뷢����һ�ݹ�ͬѧϰ������			            }
{  									                                                      }
{                                     ��į�������䣺346397392@qq.com	    }
{						                              2020��4��13��                   }
{	 �޸��������뷨�����ڼ�Page up pagedown �Ȱ���ʧ������� 2022��10��19�� }
{*************************************************************************}
unit inputU;

interface

uses
  Windows, Messages, SysUtils,Forms, StdCtrls, Controls, Graphics, Classes,
  ExtCtrls,dialogs, Menus,   ComCtrls, Spin,Registry,
  ActnList,TlHelp32,ShellAPI, Mask;
  const
    WM_hookKEY  =$450; //������Ϣ      WM_HOOKKEY = WM_USER + $1200;
    sy:array[1..2] of longint=(0,$1);
type
  node=record
    h:longint;  //���� ���
    cs:integer; //������־
    bd:integer; //���״̬
    zt:integer; //����״̬
  end;
type
  zikusuoyinleixing=record //������������
    en:string;        //����a---y
    shou:integer;   //�ַ��׵�ַ
    wei:integer;    //�ַ�β��ַ
  end;
  Tinputfrm = class(TForm)
    StaticText1: TStaticText;
    PopupMenu1: TPopupMenu;
    menuDefineWord: TMenuItem;
    menuDefineSymbol: TMenuItem;
    menuAbout: TMenuItem;
    menuImportLibrary: TMenuItem;
    RzBitBtn3: TButton;
    RzBitBtn4: TButton;
    menuExportLibrary: TMenuItem;
    Label1: TMemo;
    menuExportSymbols: TMenuItem;
    Panel1: TPanel;
    Button1: TLabel;
    RzBitBtn1: TLabel;
    Button3: TLabel;
    RzBitBtn2: TLabel;
    menuText: TMenuItem;
    menuExit: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;

    procedure Mymessage(var msg:Tmessage); Message WM_HookKEY;
    procedure Destroy(Sender: TObject);
    procedure ve(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure menuDefineWordClick(Sender: TObject);
    procedure StaticText1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure menuDefineSymbolClick(Sender: TObject);
    procedure menuAboutClick(Sender: TObject);
    procedure RzBitBtn1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RzBitBtn4Click(Sender: TObject);
    procedure RzBitBtn3Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label122MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure menuImportLibraryClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure menuExportLibraryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure menuExportSymbolsClick(Sender: TObject);
    procedure menuTextClick(Sender: TObject);
    procedure menuExitClick(Sender: TObject);

  private
    { Private declarations }
    OldMessage: TMessageEvent;
    function  IsDigital(Value: string): boolean;
    procedure DoMessage(var Msg: TMsg; var Handled: Boolean);
    function  CheckMouseInRect(ControlHandle: THandle): Boolean;
  public
    { Public declarations }

    Procedure CreateParams(var Params:TCreateParams);override;
    Procedure WriteMemory(xm,sz:integer);
    function  HasNum(s:string):Boolean;
    procedure Song(s:string);
    procedure song2(s:string);
    function  StrNum(Source:string ;Sub:string ): Integer;
    function  FindStr(ShortStr:String;LongStrIng:String):Integer;
    procedure Duma(key:longint);
    function  ReadFromRegS(const RootKey: HKEY; const Key, Name: string): string;
    function  CheckTask(ExeFileName: string): Boolean;  //�жϳ����Ƿ�������
    function  Kill_Task(ExeFileName: string):integer;//�ر�Ӧ�ó���
  end;

var
   inputfrm: Tinputfrm;
   nodepoint:^node;   //�ڴ��ļ���ַ
   zikusuoyin:array[1..25] of zikusuoyinleixing;
   fileM:THandle;    //�ڴ�ӳ���ļ�
   cishu,Inputtype:Integer;
   wzi:array[1..10] of Integer;
   copys,s1,s2:string; //s3
   jm,zw,zdfha,zdfhz:TStringlist;
   t:array[1..1000] of string;
   tarr:array[1..1000] of string;
   max,lastwz,f1,f2,f3:Longint;
   zbx,bdxh,zt,tn,fn,fshow,k:Integer;
   fsign:Boolean;

Const
  ROOT_KEY = HKEY_CURRENT_USER;
  SYS_KEY = '\Software\ccsoftware\%S\path';

implementation

uses InputwayFormU,nounglozeU,SelectformU,EduceFormU, VisibleFormU;
procedure HookOn ; stdcall; external 'zskd.dll';
procedure HookOff ; stdcall; external 'zskd.dll';

{$R *.DFM}
procedure CountChineseChars(SpecStr:string;var aa:string;var bb:string); //�ѱ����뺺�ַֿ����ֱ��������������
var
  shuzu1,shuzu,WSStr:WideString;
  //shuzu1,shuzu,WSStr:string;
  TempStr:string;
  j,i:integer;
begin
  WSStr:=SpecStr;
  j:=1;
  for i:=1 to length(WSStr)do
    begin
      if (ord(WSStr[i])>=33) and (ord(WSStr[i])<=127)then
        begin
           TempStr:=Wsstr[i];
           if (TempStr[1]in['a'..'z','A'..'Z'])then
              begin
                 if j=0 then
                    shuzu:=shuzu+' '+TempStr
                 else
                    shuzu:=shuzu+TemPstr;
                 j:=j+1;
              end
           else
           //ghgfhdf
        end
      else
        begin
          if(ord(WSStr[i])>=127)then
              begin
                 shuzu1:=shuzu1+WSStr[i];
                 j:=0;
              end;

        end;
    end;
   aa:=shuzu;
   bb:=shuzu1;
   shuzu:='';
   shuzu1:='';
end;
//д���ر�־
Procedure Tinputfrm.WriteMemory(xm,sz:integer);
begin
  FileM:=OpenFileMapping(FILE_MAP_WRITE,False,'kdHook');
  if FileM<>0 then
  begin
    nodePoint:=MapViewOfFile(FileM,FILE_MAP_WRITE,0,0,0);
    case xm of
    1:nodePoint^.cs:=sz;
    2:nodepoint^.bd:=sz;
    3:nodepoint^.zt:=sz;
    end;
    UnmapViewOfFile(nodePoint);
  end;
  CloseHandle(FileM);
end;
function Tinputfrm.Kill_Task(ExeFileName: string):Integer;  //�ر��ⲿ����
const
  PROCESS_TERMINATE=$0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,FProcessEntry32);
  while integer(ContinueLoop) <> 0 do
    begin
      if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
           UpperCase(ExeFileName))
       or (UpperCase(FProcessEntry32.szExeFile) =
           UpperCase(ExeFileName))) then
        TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0),
                          FProcessEntry32.th32ProcessID), 0);
      ContinueLoop := Process32Next(FSnapshotHandle,FProcessEntry32);
    end;
end;
function Tinputfrm.ReadFromRegS(const RootKey: HKEY; const Key, Name: string): string;
var
  Reg: TRegistry;
begin
  Result := '';
  Reg := TRegistry.Create;
  try
    Reg.RootKey := RootKey;
    if Reg.OpenKey(Key, True) then
      if Reg.ValueExists(Name) then Result := Reg.ReadString(Name);
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;
function Tinputfrm.CheckMouseInRect(ControlHandle: THandle): Boolean;
var
  r:TRect;
  p:TPoint;
begin
  GetWindowRect(ControlHandle,r);
  GetCursorPos(p);
  Result := PtInRect(r,p);
end;
procedure Tinputfrm.DoMessage(var Msg: TMsg; var Handled: Boolean);  //��ȡ����ƶ���Ϣ

begin
  if Assigned(OldMessage) then
     OldMessage(Msg,Handled);
end;
function Tinputfrm.HasNum(s:string):Boolean; //�ж��ַ������Ƿ��������
var
  i:integer;
begin
  Result:=True;
  for i:=1 to length(s) do
    begin
      if (s[i] in ['0'..'9']) then
       begin
         Result:=True;
         Exit;
       end;
    end;
  Result:=False;
end;
procedure Tinputfrm.Song(s:string);
var
 chkl:HKL;
 i:Integer; //  ,j
 ch:byte;
 tpt:Tpoint;
 FocusHandle: DWORD;
 CurrentPos: TPoint;
begin
  copys:=Trim(s);
  //chkl:= HKL($E0060804);
  chkl:= HKL($00000804);
  SendMessage(f3,WM_INPUTLANGCHANGEREQUEST,1,longint(chkl));
  i:=1;
  while i<= Length(s) do
  begin
    {
    ch:=byte(s[i]);
    if Windows.IsDBCSLeadByte(ch)then
      begin
        Inc(i);
        SendMessage(f3,WM_IME_CHAR,MakeWord(byte(s[i]),ch),0);
      end
    else
      begin
        SendMessage(f3,WM_IME_CHAR,word(ch),0);
      end;
    Inc(i);
    }
    SendMessage(f3,WM_IME_CHAR,Ord(s[i]),0);
    i:=i+1;
  end;
  Writememory(1,0);
  s1:='';cishu:=0;max:=0;
  StaticText1.caption:='��į����';
  Label1.Text:=s2;
  ///�ƶ�����
  FocusHandle :=f3;
  AttachThreadInput(GetCurrentThreadId, GetWindowThreadProcessId(GetForegroundWindow(), nil), TRUE);

  GetCaretPos(CurrentPos);
  Windows.ClientToScreen(FocusHandle, CurrentPos);

  Left:=CurrentPos.X+50;
  Top:=CurrentPos.Y+25;
  Height:=self.RzBitBtn3.Height+1;//****************????
end;
procedure Tinputfrm.song2(s:string);
var
chkl:hkl;
a,b,j,i:integer;
FocusHandle: DWORD;
 CurrentPos: TPoint;
begin
  copys:=s;
  chkl := HKL($e0060804);//(Screen.Imes.Objects[1]);
    SendMessage(f3, WM_INPUTLANGCHANGEREQUEST, 1, longint(chkl));
  j:=length(s);
  for i:=2 to j+1 do
      begin
          sendmessage(f3,wm_ime_char,(ord(S[i-1])), 0);
      end;
  Writememory(1,0);
  s1:='';cishu:=0;max:=0;
  StaticText1.caption:='��į����';
  Label1.Text:=s2;
   ///�ƶ�����
  FocusHandle :=f3;
  AttachThreadInput(GetCurrentThreadId, GetWindowThreadProcessId(GetForegroundWindow(), nil), TRUE);

  GetCaretPos(CurrentPos);
  Windows.ClientToScreen(FocusHandle, CurrentPos);

  Left:=CurrentPos.X+50;
  Top:=CurrentPos.Y+25;
  Height:=self.RzBitBtn3.Height+1;//****************???? 
end;
function Tinputfrm.StrNum(Source:string ;Sub:string ): Integer;
var
  Buf :string;
  i :integer;
  Len :integer;
begin 
   Result :=0;
   Buf:=Source;
   i := Pos(Sub, Buf);
   Len := Length(Sub);
    while i <>0  do
      begin
        Inc(Result);
        Delete(Buf,1,i+Len-1);
        i:=Pos(Sub,Buf); 
      end;
end;
function Tinputfrm.FindStr(ShortStr:String;LongStrIng:String):Integer;
var
   i:integer;
begin
   Result:=1;
   for i:=1 to length(ShortStr) do
    begin      
      if LongStrIng=ShortStr[i] then
        begin
          Result:=i;
          Exit;
        end;
    end;
end;
function Tinputfrm.IsDigital(Value: string): boolean;
var
  i, j: integer;
  str: char;
begin
  result := False;
  Value := Trim(Value);
  j := Length(Value);
  if j = 0 then
  begin
    result := false;
    exit;
  end;
  for i := 1 to j do
  begin
    str := Value[i];
    if (str in ['0'..'9']) then
     begin
       result := True;
       exit;
    end;
  end;
end;

{$R-}
procedure Tinputfrm.Duma(Key:Longint);
var
 f:Thandle;
 ff:Textfile;
 s,bm,mb,Str,tstr,gg:String;
 wz:Longint;
 tj1,tj3:Boolean;
 ok,i,n,J,v,w,tint,r:Integer;
 BitMap: TBitMap;
 x,g,c: Integer;
begin
    tj1:=(key>=65) and (key<=90);
    tj3:=(key=189) or (key=187) or (key=220);
  case key of
    189:key:=45;
    187:key:=61;
    220:key:=92;
    end;
  //==== ���ⰴ������
  case key of
  191:  begin
            if bdxh=1 then
                if HiWord(GetKeystate(Vk_SHIFT))=0 then song('��') else song('��')
            else
                if HiWord(GetKeystate(Vk_SHIFT))=0 then song('/') else song('?');
        end;//��'/'�����桢��
  190:  begin
            if bdxh=1 then
              begin
              if HiWord(GetKeystate(Vk_SHIFT))=0 then song('��') else song('��');
              end
            else if HiWord(GetKeystate(Vk_SHIFT))=0 then song('.')else song('>');
        end;
  188:  begin
            if bdxh=1 then
               begin
                  if HiWord(GetKeystate(Vk_SHIFT))=0 then
                      song('��')
                     else song('��');
               end
              else
               begin
               if HiWord(GetKeystate(Vk_SHIFT))=0 then song(',') else song('<');
               end;
        end;
  186: begin   //����Զ������
      if HiWord(GetKeystate(Vk_SHIFT))=0 then
          begin
            zbx:=zbx+1;
           if (zbx=2) or (zbx=5) then
             begin
                if bdxh=1 then song('��') else song(';');
                if zbx =2 then zbx:=0 else zbx:=3;
             end;
          end
        else
        begin
          if bdxh=1 then song('��') else song(':');
        end;
  end;
  222: begin
          if bdxh=1 then
              begin
                if HiWord(GetKeystate(Vk_SHIFT))<>0 then
                    begin                         
                        if zt=0 then  //�������0�������
                             begin
                               song('��');
                               zt:=3;//�������3�������
                             end
                         else
                             begin
                               song('��');
                               zt:=0;
                             end;
                    end
                else
                  song('��');
              end
          else
                if HiWord(GetKeystate(Vk_SHIFT))=0 then song(#39) else song('"');
       end;
  end;
  //===== ���ⰴ���������

  if tj1 or tj3  then    //�������ĸ
     begin
       cishu:=cishu+1;
       s1:=s1+chr(key+32);
     end;
  if cishu=1  then
     begin
       wzi[cishu]:=sy[key-64];
       lastwz:=sy[key-63];
     end;
  if key=8 then
     begin
       if cishu=1 then
         s1:=''
       else
         delete(s1,length(s1),1);
       cishu:=cishu-1;
       fn:=9;
       tn:=0;
       RzBitBtn3.Enabled:=False;
       RzBitBtn4.Enabled:=False;
       for g:=1 to 1000 do
       begin
         t[g]:='';
         tarr[g]:='';
       end;
     end;
  if key=27 then
     begin
       s1:='';cishu:=0;max:=0;
       StaticText1.caption:='��į����';
       label1.text:=s2;
       exit;
     end;

  if key in [34,40] then
     begin
       if RzBitBtn4.Enabled=True then
          RzBitBtn4.Click;
       Exit;
     end
  else if key in [33,38] then
     begin
       if RzBitBtn3.Enabled=True then
          RzBitBtn3.Click;
       Exit;
     end;

  writememory(1,cishu);
  if (Key=32) then
    begin
     if Fsign=True then
        song(Trim(tarr[1]))
     else if t[1]<>'' then
        Song(Trim(t[1]));
       for g:=1 to 1000 do
       begin
         t[g]:='';
         tarr[g]:='';
       end;
       zbx:=0;statictext1.Caption:='��į����';
       fsign:=False;
       fn:=9;
       tn:=0;
       RzBitBtn3.Enabled:=False;
       RzBitBtn4.Enabled:=False;
       //t[1]:='';
       //tarr[1]:='';
       s1:='';
    end;
  if key=13 then
     begin
        if s1<>'' then
           begin
              song2(s1);
              for g:=1 to 1000 do
                  begin
                      t[g]:='';
                      tarr[g]:='';
                  end;
              zbx:=0;
              fsign:=False;
              fn:=9;
              tn:=0;
              RzBitBtn3.Enabled:=False;
              RzBitBtn4.Enabled:=False;
              s1:='';
           end;
     end;


  if (key>48) and (key<58) and (key-48<=max) then
    begin
      if fsign=False then
        begin
          song(Trim(t[key-48]));
          RzBitBtn3.Enabled:=False;
          RzBitBtn4.Enabled:=False;
          zbx:=0;
        end
      else if fsign=True then
        begin
         if tarr[1]<>'' then
           begin
             song(Trim(tarr[key-48]));
             fsign:=False;
             fn:=9;
             tn:=0;
             zbx:=0;
             RzBitBtn3.Enabled:=False;
             RzBitBtn4.Enabled:=False;
           end;
        end;
    end;
  StaticText1.caption:=s1;
  if  s1='' then
    begin
       Randomize;//��ʼ���������
       r:=random(4);
       case r OF
        0:  StaticText1.caption:='��į�����������';
        1:  StaticText1.caption:='����ctrl������Ӣ���л�' ;
        2:  StaticText1.caption:=';+��ĸ �������' ;
        3:  StaticText1.caption:='������; ����;' ;
       End;
    end;
  //

                           
  if (zbx=1)or(zbx=4) then  wz:=zdfha.IndexOf(LowerCase(s1))  else 
  wz:=jm.IndexOf(LowerCase(s1));
  if (wz=-1) then
     begin
       Label1.Text:='';
       for g:=1 to 1000 do
       begin
         t[g]:='';
         tarr[g]:='';
       end;
       Exit;
     end;
  str:='';
  tstr:='';
  for g:=1 to 1000 do
   begin
    t[g]:='';
    tarr[g]:='';
   end;
  Label1.Text:='';
  if (zbx=1)or(zbx=4) then
  begin
     if Trim(s1)<>'' then  //ȡ���Զ�������ĸ���ڵ�˳��ȡ�����ֱ���
     begin
        w:=0;
        c:=1;
        while  w<(zdfha.Count-1) do
       //for w:=0 to jm.Count-1  do         //ȡ���������ڵ�˳��
        begin
          if c=1000 then
             break;
          if Length(Trim(s1))>1 then
             begin
               if LowerCase(Trim(s1))=LowerCase(Copy(Trim(zdfha.Strings[w]),1,length(Trim(s1))))  then
                 begin
                   if str<>'' then
                     begin
                      str:=str+IntToStr(w)+',' ;
                     end
                   else
                     begin
                       str:=IntToStr(w)+',';
                     end;
                   c:=c+1;
                 end;
             end
            else
              begin
                if LowerCase(Trim(s1))=LowerCase(Trim(zdfha.Strings[w]))  then
                 begin
                   if str<>'' then
                     begin
                       str:=str+IntToStr(w)+',';
                     end
                   else
                     begin
                       str:=IntToStr(w)+',';
                     end;
                    c:=c+1;
                 end;
              end;
            inc(w);
        end;
    end;
  str:=Trim(str);
  tint:=0;
  v:=1;
  if str<>'' then
    begin
      tint:=StrNum(str,',');
      if (tint>1) and (tint<1001) then
        begin
          while Length(str)>0 do   //���ݽ�������˳��ȡ������Ӧ������
            begin
              j:=StrToInt(Copy(str,1,FindStr(str,',')-1));
              if tstr<>'' then
                 begin
                   if Inputtype=0 then
                     begin
                       tstr:=tstr+' '+IntToStr(v)+' '+zdfhz.Strings[j];
                     end
                   else if Inputtype=1 then
                     begin
                       tstr:=tstr+'^ '+IntToStr(v)+'^ '+zdfhz.Strings[j];
                     end;
                   v:=v+1;
                 end
               else
                 begin
                   if Inputtype=0 then
                     begin
                       tstr:='1 '+zdfhz.Strings[j];
                     end
                   else if Inputtype=1 then
                     begin
                       tstr:='^1 '+zdfhz.Strings[j];
                     end;
                   v:=v+1;
                 end;
              str:=Copy(str,FindStr(str,',')+1,(length(str)-FindStr(str,',')));
           end;
        end
      else if tint=1 then
        begin
          if Inputtype=0 then
            begin
              tstr:=zdfhz.Strings[StrToInt(copy(str,1,length(str)-1))];
            end
          else if Inputtype=1 then
            begin
              tstr:=zdfhz.Strings[StrToInt(copy(str,1,length(str)-1))];
            end;
       end
      else if tint>1000 then Exit;
    end
  else Exit;
  end //=========================================================
  else
  begin
  if Trim(s1)<>'' then  //ȡ����ĸ���ڵ�˳��ȡ�����ֱ���
     begin
        w:=0;
        c:=1;
       for w:=1 to 25 do                            //�ҵ���һ����ĸ��������
          if s1[1] = zikusuoyin[w].en then   i:=w;
       for w:=zikusuoyin[i].shou to zikusuoyin[i].wei do // �����ҵ�����ĸ����λ��ȡ���������ĸ���ڽ�����˳��
        begin
          if c=1000 then // 20
             break;
          if Length(Trim(s1))>1 then
             begin
               if LowerCase(Trim(s1))=LowerCase(Copy(Trim(jm.Strings[w]),1,length(Trim(s1))))  then
                 begin
                   if str<>'' then
                     begin
                      str:=str+IntToStr(w)+',' ;
                     end
                   else
                     begin
                       str:=IntToStr(w)+',';
                     end;
                   c:=c+1;
                 end;
             end
            else
              begin
                if LowerCase(Trim(s1))=LowerCase(Trim(jm.Strings[w]))  then
                 begin
                   if str<>'' then
                     begin
                       str:=str+IntToStr(w)+',';
                     end
                   else
                     begin
                       str:=IntToStr(w)+',';
                     end;
                    c:=c+1;
                 end;
              end;
            //inc(w);
        end;
    end;
  str:=Trim(str);
  tint:=0;
  v:=1;
  if str<>'' then
    begin
      tint:=StrNum(str,',');
      if (tint>1) and (tint<1001) then
        begin
          while Length(str)>0 do   //���ݽ�������˳��ȡ������Ӧ���ִ�
            begin
              j:=StrToInt(Copy(str,1,FindStr(str,',')-1));
              if tstr<>'' then
                 begin
                   if Inputtype=0 then
                     begin
                       tstr:=tstr+' '+IntToStr(v)+' '+zw.Strings[j];
                     end
                   else if Inputtype=1 then
                     begin
                       tstr:=tstr+'^ '+IntToStr(v)+'^ '+zdfhz.Strings[j];
                     end;
                   v:=v+1;
                 end
               else
                 begin
                   if Inputtype=0 then
                     begin
                       tstr:='1 '+zw.Strings[j];
                     end
                   else if Inputtype=1 then
                     begin
                       tstr:='^1 '+zdfhz.Strings[j];
                     end;
                   v:=v+1;
                 end;
              str:=Copy(str,FindStr(str,',')+1,(length(str)-FindStr(str,',')));
           end;
        end
      else if tint=1 then
        begin
          if Inputtype=0 then
            begin
              tstr:=zw.Strings[StrToInt(copy(str,1,length(str)-1))];
            end
          else if Inputtype=1 then
            begin
              tstr:=zdfhz.Strings[StrToInt(copy(str,1,length(str)-1))];
            end;
       end
      else if tint>1000 then Exit;
    end
  else Exit;// ���ֱ�����ҽ���
  end;
    if tstr<>'' then
     s2:=Trim(tstr);

  if s2<>'' then
     t[1]:=s2
  else
     exit;

  if HasNum(s2) then
     begin
       if ((ord(s2[i])<48) or (ord(s2[i])>57)) then
           ok:=0;n:=0;
       for i:=1 to length(s2) do
        begin
          if s2[i]=' ' then
           begin
            ok:=1-ok;
            if ok=1 then
             begin
               n:=n+1; max:=n; t[n]:='';
             end;
           end;
           if (((ord(s2[i])<48) or (ord(s2[i])>57))) and (s2[i]<>' ') then
             begin
               tn:=n;
               try
                 t[n]:=t[n]+s2[i];
               except
               end;
             end;
        end;
       //messagebox(0,pchar(t[1]+t[2]+t[3]+t[4]),'��ʾ:',0);
     end;
  Label1.Text:='';
  if tint< 2 then
    begin
      if Inputtype=0 then
        begin
          Width:=301;
          Label1.Width:=283;
          StaticText1.Width:=143;
          RzBitBtn3.Left:=278;
          RzBitBtn4.Left:=278;
        end;
      Height:=72;
      label1.Lines.Add(s2);
      RzBitBtn3.Enabled:=False;
      RzBitBtn4.Enabled:=False;
    end
  else
    begin
      if tint>9 then
         begin
            for i:=1 to 9 do
                label1.Lines.Add(inttostr(i)+t[i]);
            label1.Height:=abs(label1.Font.Height-4)*(9+round(label1.Font.Size*0.15));//
            Height:=label1.Height;
         end
      else
         begin
            for i:=1 to tint do
                label1.Lines.Add(inttostr(i)+t[i]);
            label1.Height:=abs(label1.Font.Height-4)*(tint+round(label1.Font.Size*0.12)); //
            Height:=rzbitbtn1.Height+label1.Height; //
         end;
      //messagebox(0,pchar(s1),'��ʾ:',0); //������
      BitMap:= TBitMap.Create;
      try
        with BitMap.Canvas do
         begin
           X:=trunc(TextWidth(Label1.Text)*0.65);

         end;
      finally
        BitMap.Free; 
      end;
      if (label1.Width)<(X) then
         begin
           if Inputtype=0 then
              Width:=x+rzbitbtn3.Width
           else
              Width:=X+(RzBitBtn4.Width-8);
           StaticText1.Width:=StaticText1.Width+(X-Label1.Width+2);
           label1.Width:=X;
           RzBitBtn4.Left:=label1.Left+label1.Width-2;
           RzBitBtn3.Left:=label1.Left+label1.Width-2;
         end;
      RzBitBtn3.Enabled:=False;
      if tn>9 then
        RzBitBtn4.Enabled:=True
      else
        RzBitBtn4.Enabled:=False;
    end;
    if (label1.Lines.Count=1) and (cishu=4) then
    begin
      song(t[1]);
      statictext1.Caption:='��į����';
    end;
    //messagebox(0,pchar(inttostr(label1.Lines.count)),'��ʾ:',0); //������
end;
{$R+}

function Tinputfrm.CheckTask(ExeFileName: string): Boolean;  //�жϳ����Ƿ�������
const
   PROCESS_TERMINATE=$0001;
var
   ContinueLoop: BOOL;
   FSnapshotHandle: THandle;
   FProcessEntry32: TProcessEntry32;
begin 
   result := False;
   FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
   FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
   ContinueLoop := Process32First(FSnapshotHandle,FProcessEntry32);
   while integer(ContinueLoop) <> 0 do
      begin
        if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =UpperCase(ExeFileName))
          or (UpperCase(FProcessEntry32.szExeFile) =UpperCase(ExeFileName))) then
        result := True;
        ContinueLoop := Process32Next(FSnapshotHandle,FProcessEntry32);
      end;
end;
procedure Tinputfrm.Mymessage(var msg:Tmessage);
var
  k:Longint;   //ɨ����
  pos,pt:Tpoint;
  //t:string;// ,S,gStr
  dwCurrentThreadID:DWORD;
  FocusHandle: DWORD;
  CurrentPos: TPoint;
Begin
    if (msg.LParam shr 16)=8504 then
        Song(Trim(copys));
    if (msg.LParam shr 16)=285 then
       begin  //��ctrl���ƶ����ڵ����λ��
         //Getcursorpos(pos);
         //Top:=pos.y;
         if rzbitbtn1.Caption='���' then
            begin
                writememory(3,1);
                rzbitbtn1.Caption:='EN' ;
            end
        else
            begin
                rzbitbtn1.Caption:='���';
                writememory(3,0);
            end;
       end;
    if ((msg.lParam shr 16)=42) then      //or ((msg.lParam shr 16)=54)
       begin //������Shift�� �ƶ����ڵ����λ��
         SendMessage(f3, WM_IME_NOTIFY, IMN_CLOSECANDIDATE, 0);
         SendMessage(f3, WM_INPUTLANGCHANGEREQUEST,1, Longint(HKL($00090409)));
         SendMessage(f3, WM_INPUTLANGCHANGE,1, Longint(HKL($04090409)));
       end;
   k:=msg.wParam;
   //Height:=220;///---72
    //����ĸ��������չ��
   GetCursorPos(pt); //��ȡ����λ��
   f1 :=WindowFromPoint(pt);
   f2:=GetWindowThreadProcessId(f1,nil); //ȡ�ô����Ӧ�߳�ID
   dwCurrentThreadID:=GetCurrentThreadId; //��ȡ��ǰ�̶߳�Ӧ��ID
    if f2<>dwCurrentThreadID then
        begin
          if AttachThreadInput(dwCurrentThreadID,f2,True) then //�����߳����빲��
            begin
              f3:=getfocus;  //  ȡ�ù����
              AttachThreadInput(dwCurrentThreadID, f2, False);
            end
           else
             f3:=getfocus;
        end;
   FocusHandle :=f3;
   GetCaretPos(CurrentPos); //��ȡ����λ��
   Windows.ClientToScreen(FocusHandle, CurrentPos);
   Left:=CurrentPos.X+50;
   Top:=CurrentPos.Y+25;
   if f3 = 0 then   Exit;
      Duma(k);
end;

Procedure Tinputfrm.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);    //�����б߿��ޱ������Ĵ���
  if borderstyle=bsnone then
  with Params do
       style:=style or ws_border;
end;

procedure Tinputfrm.Destroy(Sender: TObject);
begin
  if fileM<>0 then  //ȡ���ڴ�ӳ��
    begin
      UnmapViewOfFile(nodepoint);
      CloseHandle(FileM);
    end;
  try
    jm.Destroy;
  except
  end;
  try
    zw.Destroy;
  except
  end;
  try
   zdfhz.Destroy;
  except
  end;
  try
    zdfha.Destroy;
  except
  end;
  Hookoff;  //�ͷż��̹���

end;

procedure Tinputfrm.ve(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  if (ssleft in Shift) then
    begin
      ReleaseCapture;
      //�ú����ӵ�ǰ�߳��еĴ����ͷ���겶�񣬲��ָ�ͨ����������봦��
      //�������Ĵ��ڽ������е�������루���۹���λ������������ǵ������ʱ������ȵ�����һ���̵߳Ĵ����С�
      Perform(WM_syscommand, $F012, 0);
      // ����Ϊ�����������ϷŴ����ϵĿؼ���
    end;
end;
procedure Tinputfrm.menuDefineWordClick(Sender: TObject);


begin
  s1:='';
  cishu:=0;
  StaticText1.Caption:='��į����';
  Label1.text:='';
  Hookoff;
  if not Assigned(Inputwayfrm) then               
     Inputwayfrm:=TInputwayfrm.Create(self);
      try
       with Inputwayfrm do
         begin
           Tag := self.Tag+1;
           Hint := self.Hint;
           Top :=self.Top;
           left :=self.Left+self.Width; 
           ShowModal;
         end;
      finally
        FreeAndNil(Inputwayfrm);
      end;
  Setforegroundwindow(f3);
  Hookon;
end;

procedure Tinputfrm.StaticText1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssleft in Shift) then
    begin
      ReleaseCapture;
      Perform(WM_syscommand, $F012, 0);
    end;
end;

procedure Tinputfrm.Button1Click(Sender: TObject);
begin
  Inputtype:=1;
  //Button1.Enabled:=False;
  //RzBitBtn1.Enabled:=True;
  fn:=9;
  Width:=350;
  Label1.Width:=331;
  StaticText1.Width:=191;
  RzBitBtn3.Left:=327;
  RzBitBtn4.Left:=327; 
  Setforegroundwindow(f3);
end;

procedure Tinputfrm.Button2Click(Sender: TObject);
begin
  Inputtype:=2;
  fn:=9;
  Button1.Enabled:=True;
  RzBitBtn1.Enabled:=True;
  Width:=440;
  Label1.Width:=421;
  StaticText1.Width:=281;
  RzBitBtn3.Left:=417;
  RzBitBtn4.Left:=417;
  Setforegroundwindow(f3);
end;

procedure Tinputfrm.menuDefineSymbolClick(Sender: TObject);
begin
  s1:='';
  cishu:=0;
  StaticText1.Caption:='��į����';
  Label1.text:='';
  Hookoff;
  if not Assigned(nounglozefrm) then
     nounglozefrm:=Tnounglozefrm.Create(self);
      try
       with nounglozefrm do
         begin
           Tag := self.Tag+1;
           Hint := self.Hint;
           Top :=self.Top;
           left :=self.Left+self.Width;
           ShowModal;
         end;
      finally
        FreeAndNil(nounglozefrm);
      end;
   Setforegroundwindow(f3);
   Hookon;
end;

procedure Tinputfrm.menuAboutClick(Sender: TObject);
begin
  s1:='';
  cishu:=0;
  StaticText1.Caption:='��į����';
  Label1.text:='';
  Hookoff;
   if not Assigned(selectfrm) then
      selectfrm:=Tselectfrm.Create(self);
      try
       with selectfrm do
         begin
           Tag := self.Tag+1;
           Hint := self.Hint;
           Top:=self.Top-self.Height;
           left:=self.Left;
           ShowModal;
         end;
      finally
        FreeAndNil(selectfrm);
      end;
   Setforegroundwindow(f3);
   Hookon;
end;

procedure Tinputfrm.RzBitBtn1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if (ssleft in Shift) then
    begin
      ReleaseCapture;
      Perform(WM_syscommand, $F012, 0);
    end;
end;

procedure Tinputfrm.RzBitBtn1Click(Sender: TObject);
begin
  Inputtype:=0;
  fn:=9;
  //Button1.Enabled:=True;
  //RzBitBtn1.Enabled:=False;
  Width:=301;
  Label1.Width:=283;
  StaticText1.Width:=141;
  RzBitBtn3.Left:=278;
  RzBitBtn4.Left:=278;
  Setforegroundwindow(f3);
  //====================== 
begin

  if rzbitbtn1.Caption='�� ��   ' then
  begin
    writememory(3,1);
    rzbitbtn1.Caption:='EN' ;
  end
  else
  begin
    rzbitbtn1.Caption:='�� ��   ';
    writememory(3,0);
end;
//image1.ShowHint(
  setforegroundwindow(f3);

end;
  //===============
end;

procedure Tinputfrm.Button1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if (ssleft in Shift) then
    begin
      ReleaseCapture;
      Perform(WM_syscommand, $F012, 0);
    end;
end;

procedure Tinputfrm.Button2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if (ssleft in Shift) then
    begin
      ReleaseCapture;
      Perform(WM_syscommand, $F012, 0);
    end;
end;

procedure Tinputfrm.RzBitBtn4Click(Sender: TObject);
var
  BitMap: TBitMap;
  i,X: Integer;
begin
  k:=0;  ;//----------------
  BitMap:= TBitMap.Create;
  if (fn<tn+1) and (tn>9) then
      begin
        if (t[fn+1]<>'') and (t[fn+9]<>'') then
          begin
            Label1.Lines.Text:='';
            for i:=fn+1 to fn+9 do
               begin
                    Label1.Lines.Add(inttostr(i-fn)+t[i]);
                    tarr[i-fn]:=Trim(t[i]);
               end;
            try
              with BitMap.Canvas do
                begin
                  X:=trunc(TextWidth(Label1.Text)*0.65);
                  //x:=Label1.GetTextLen;
                  //ShowMessage(IntToStr(TextWidth(Label1.Text) )+'|'+inttostr(x));
                end;
            finally
              BitMap.Free;
            end;
             if (label1.Width)<(X) then
                begin
                  Width:=X+(RzBitBtn4.Width-8);
                   //StaticText1.Width:=StaticText1.Width+(X-145+2);
                   //textout(getdc(0),106,402,pchar(IntToStr(x)),length(pchar(IntToStr(x))));
                  StaticText1.Width:=StaticText1.Width+(X-label1.Width+2);
                  label1.Width:=X;
                  RzBitBtn4.Left:=label1.Left+label1.Width-2;
                  RzBitBtn3.Left:=label1.Left+label1.Width-2;
                end
             else
                begin
                  if Inputtype=0 then
                    begin
                      Width:=301;
                      Label1.Width:=283;
                      StaticText1.Width:=143;
                      RzBitBtn3.Left:=278;
                      RzBitBtn4.Left:=278;
                    end
                  else if Inputtype=1 then
                    begin
                      Width:=350;
                      Label1.Width:=331;
                      StaticText1.Width:=191;
                      RzBitBtn3.Left:=327;
                      RzBitBtn4.Left:=327;
                    end
                  else if Inputtype=2 then
                    begin
                      Width:=440;
                      Label1.Width:=421;
                      StaticText1.Width:=281;
                      RzBitBtn3.Left:=417;
                      RzBitBtn4.Left:=417;
                    end;
                end;
            fn:=fn+9;
            fsign:=True;
            RzBitBtn3.Enabled:=True;
            if (fn>tn) or (fn=tn) then
               RzBitBtn4.Enabled:=False;
          end
        else  if (t[fn+1]<>'') and (t[fn+9]='') then
          begin
            for k:=fn+1 to fn+9 do
            begin
               if t[k]='' then break;
            end;
            Label1.Lines.Text:='';
            for i:=fn+1 to k-1 do
               begin
                    Label1.Lines.Add(inttostr(i-fn)+t[i]);
                    tarr[i-fn]:=Trim(t[i]);
               end;
            try
              with BitMap.Canvas do
                begin
                  X:=trunc(TextWidth(Label1.Text)*0.65);
                  
                end;
            finally
              BitMap.Free;
            end;

             if (label1.Width)<(X) then
                begin
                  Width:=X+(RzBitBtn4.Width-8);
                  //StaticText1.Width:=StaticText1.Width+(X-155+2);
                  StaticText1.Width:=StaticText1.Width+(X-label1.Width+2);
                  label1.Width:=X;
                  RzBitBtn4.Left:=label1.Left+label1.Width-2;
                  RzBitBtn3.Left:=label1.Left+label1.Width-2;
                end
             else
                begin
                  if Inputtype=0 then
                    begin
                      Width:=301;
                      Label1.Width:=283;
                      StaticText1.Width:=143;
                      RzBitBtn3.Left:=278;
                      RzBitBtn4.Left:=278;
                    end
                  else if Inputtype=1 then
                    begin
                      Width:=350;
                      Label1.Width:=331;
                      StaticText1.Width:=191;
                      RzBitBtn3.Left:=327;
                      RzBitBtn4.Left:=327;
                    end
                  else if Inputtype=2 then
                    begin
                      Width:=440;
                      Label1.Width:=421;
                      StaticText1.Width:=281;
                      RzBitBtn3.Left:=417;
                      RzBitBtn4.Left:=417;
                    end;
                end;
            fn:=fn+k-fn-1; 
            RzBitBtn4.Enabled:=False;
            RzBitBtn3.Enabled:=True;
          end;
      end;
   Setforegroundwindow(f3);// textout(getdc(0),106,402,pchar(inttostr(x)),length(pchar(inttostr(x))));
end;

procedure Tinputfrm.RzBitBtn3Click(Sender: TObject);
var
  BitMap: TBitMap;
  i,X: Integer;
begin
  if (fn>9) and (fn=tn) then
  begin
    fn:=fn-(fn mod 9);
  end;
  BitMap:=TBitMap.Create();
   if (fn<tn+9) and (tn>9) then
      begin
      if (t[fn-1]<>'') and (t[fn-9]<>'') then
         begin
           Label1.Lines.Text:='';
           if fn>=9 then
             begin

                  for i:=fn-1 downto fn-9 do
                      begin
                        Label1.Lines.Add(inttostr(fn-i)+t[(fn-9)+(fn-i)]);
                        tarr[fn-i]:=Trim(t[(fn-9)+(fn-i)]);
                     end;
               try
                 with BitMap.Canvas do
                  begin
                    X:=trunc(TextWidth(Label1.Text)*0.65);

                  end;
               finally
                 BitMap.Free;
               end;
                if (label1.Width)<(X) then
                  begin
                    Width:=X+(RzBitBtn4.Width-8);
                    StaticText1.Width:=StaticText1.Width+(X-155+2);
                    //StaticText1.Width:=StaticText1.Width+(X-label1.Width+2);
                    label1.Width:=X;
                    RzBitBtn4.Left:=label1.Left+label1.Width-2;
                    RzBitBtn3.Left:=label1.Left+label1.Width-2;
                  end
                else
                begin
                  if Inputtype=0 then
                    begin
                      Width:=301;
                      Label1.Width:=283;
                      StaticText1.Width:=143;
                      RzBitBtn3.Left:=278;
                      RzBitBtn4.Left:=278;
                    end
                  else if Inputtype=1 then
                    begin
                      Width:=350;
                      Label1.Width:=331;
                      StaticText1.Width:=191;
                      RzBitBtn3.Left:=327;
                      RzBitBtn4.Left:=327;
                    end
                  else if Inputtype=2 then
                    begin
                      Width:=440;
                      Label1.Width:=421;
                      StaticText1.Width:=281;
                      RzBitBtn3.Left:=417;
                      RzBitBtn4.Left:=417;
                    end;
                end;
               fn:=fn-9;
             end
           else if fn<9 then
             begin
               for i:=fn downto 0 do
                      begin
                          Label1.Lines.Add(inttostr(fn-i+1)+t[0+fn-i]);
                          tarr[fn-i+1]:=Trim(t[0+fn-i]);
                      end;
               try
                 with BitMap.Canvas do
                  begin
                    X:=trunc(TextWidth(Label1.Text)*0.65);

                  end;
               finally
                 BitMap.Free;
               end;
                if (label1.Width)<(X) then
                  begin
                    Width:=X+(RzBitBtn4.Width-8);
                    StaticText1.Width:=StaticText1.Width+(X-155+2);
                    //StaticText1.Width:=StaticText1.Width+(X-label1.Width+2);
                    label1.Width:=X;
                    RzBitBtn4.Left:=label1.Left+label1.Width-2;
                    RzBitBtn3.Left:=label1.Left+label1.Width-2;
                  end
                else
                begin
                  if Inputtype=0 then
                    begin
                      Width:=301;
                      Label1.Width:=283;
                      StaticText1.Width:=143;
                      RzBitBtn3.Left:=278;
                      RzBitBtn4.Left:=278;
                    end
                  else if Inputtype=1 then
                    begin
                      Width:=350;
                      Label1.Width:=331;
                      StaticText1.Width:=191;
                      RzBitBtn3.Left:=327;
                      RzBitBtn4.Left:=327;
                    end
                  else if Inputtype=2 then
                    begin
                      Width:=440;
                      Label1.Width:=421;
                      StaticText1.Width:=281;
                      RzBitBtn3.Left:=417;
                      RzBitBtn4.Left:=417;
                    end;
                end;
              fn:=0;
              RzBitBtn3.Enabled:=False;
             end;
           if fn<9 then
             begin
               fn:=0;
               RzBitBtn3.Enabled:=False;
             end;
           RzBitBtn4.Enabled:=True;
         end
      else if (t[fn-1]<>'') and (t[fn-9]='') then
         begin
           Label1.Lines.Text:='';
                  for k:=fn-1 to fn-9 do
                    begin
                      if t[k]='' then break;
                    end;
                  for i:=k-1 downto 1 do
                      begin
                        Label1.Lines.Add(inttostr(k-i)+t[1+K-I]);
                        tarr[k-i]:=Trim(t[1+K-I]);
                     end;
                  k:=0;
            try
              with BitMap.Canvas do
               begin
                 X:=trunc(TextWidth(Label1.Text)*0.65);
                 
               end;
            finally
              BitMap.Free;
            end;
           if (label1.Width)<(X) then
               begin
                 Width:=X+(RzBitBtn4.Width-8);
                 StaticText1.Width:=StaticText1.Width+(X-155+2);
                 //StaticText1.Width:=StaticText1.Width+(X-label1.Width+2);
                 label1.Width:=X;
                 RzBitBtn4.Left:=label1.Left+label1.Width-2;
                 RzBitBtn3.Left:=label1.Left+label1.Width-2;
               end
            else
                begin
                  if Inputtype=0 then
                    begin
                      Width:=301;
                      Label1.Width:=283;
                      StaticText1.Width:=143;
                      RzBitBtn3.Left:=278;
                      RzBitBtn4.Left:=278;
                    end
                  else if Inputtype=1 then
                    begin
                      Width:=350;
                      Label1.Width:=331;
                      StaticText1.Width:=191;
                      RzBitBtn3.Left:=327;
                      RzBitBtn4.Left:=327;
                    end
                  else if Inputtype=2 then
                    begin
                      Width:=440;
                      Label1.Width:=421;
                      StaticText1.Width:=281;
                      RzBitBtn3.Left:=417;
                      RzBitBtn4.Left:=417;
                    end;
                end;
           fn:=0;
           RzBitBtn3.Enabled:=False;
           RzBitBtn4.Enabled:=True;
         end;
      end;
    Setforegroundwindow(f3);
end;

procedure Tinputfrm.RzBitBtn2Click(Sender: TObject);
begin
  SendMessage(f3, WM_IME_NOTIFY, IMN_CLOSECANDIDATE, 0);
  SendMessage(f3, WM_INPUTLANGCHANGEREQUEST,1, Longint(HKL($00090409)));
  SendMessage(f3, WM_INPUTLANGCHANGE,1, Longint(HKL($04090409)));
  close;
end;

procedure Tinputfrm.FormCreate(Sender: TObject);
var
 i,j,suoyin:integer;
 pjm,pzw,pld,pzl,pathstr:String;
 my:Tstringlist;
begin
    textout(getdc(0),106,402,pchar('���ڳ�ʼ����������'),length(pchar('���ڳ�ʼ����������')));
    // �����ڴ�ӳ���ļ�
    fileM:=CreateFileMapping($FFFFFFFF,nil,PAGE_READWRITE,0,SizeOf(integer),'kdHook');
    //ӳ�䵽ָ��
    nodepoint:=MapViewOfFile(fileM,FILE_MAP_WRITE,0,0,0);
    //���˹��������Ϊ�����ھ��
    nodepoint^.h:=inputfrm.handle;
    nodepoint^.zt:=0;

    pathstr :=ReadFromRegS(ROOT_KEY, Format(SYS_KEY,['ccsoftware']), 'path');
    if DirectoryExists(pathstr) then
       begin
         pjm:=pathstr+'wubiziku.txt'; // jm.txt
         pzw:=pathstr+'zdfh.txt';
         pld:=pathstr+'ld.txt';
         pzl:=pathstr+'zl.txt';
       end else
       begin
         pjm:='wubiziku.txt'; // jm.txt
         pzw:='zdfh.txt';
         pld:='ld.txt';
         pzl:='zl.txt';
       end;
    zt:=0;
    fsign:=False;
    my:=Tstringlist.Create();
    jm:=Tstringlist.Create();
    zw:=Tstringlist.Create();
    zdfha:=TStringList.Create();
    zdfhz:=TStringList.Create();
    my.LoadFromFile(pjm);
    //-----------------�ѱ����뺺�ַֿ����ֱ��������������
    pjm:='';
    pld:='';
    pzl:=''; j:=0;suoyin:=1;
    for i:=3 to my.Count -1 do
    begin
       pjm:=my[i];
       CountChineseChars(pjm,pld,pzl);
       jm.Add(pld);
       zw.Add(pzl);
       if pld[1] in ['a'..'z','A'..'Z'] then  //***************************�������������ʼ
          if (length(pld)=1) then             //����25����ĸ(Z��ĸû��)������ڵ�����,��¼��λ�ð��������ĸ,�����ĸ�Ŀ�ʼλ�� ,
            begin                             //�Լ��������ĸΪ�׵�������ĸ��ϵĽ���λ�� .�������Լ��ٲ��ұ���λ��ʱ��ѭ������
                if (j=0) and (suoyin<26) then // �Լ���cpu������.
                  begin
                    zikusuoyin[suoyin].en:=pld[1];
                    zikusuoyin[suoyin].shou:=i-3;
                    if suoyin >1 then zikusuoyin[suoyin-1].wei:=i-3-1;
                    suoyin:=suoyin+1;
                    j:=j+1;
                  end ;
            end
          else
            begin
                j:=0;
            end;
         zikusuoyin[25].wei:=my.Count-1-3;
    end;                                      //****************************���������������
    my.LoadFromFile(pzw);
    pjm:='';pld:='';pzl:='';
    for i:=0 to my.Count -1 do
    begin
       pjm:=my[i];
       CountChineseChars(pjm,pld,pzl);
       zdfha.Add(pld);
       zdfhz.Add(pzl);
    end;
    try
      my.Destroy;
    except
    end;
    //-----------------����
    SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);

    //��������������ʾ��ť
    Hookon; //�Ҽ��̹���
    Inputtype:=0;
    Button1.Enabled:=True;
    fn:=9;
    Width:=301;
    Label1.Width:=283;
    StaticText1.Width:=141;
    RzBitBtn3.Left:=278;
    RzBitBtn4.Left:=278;
    Height:=self.RzBitBtn3.Height;
    RzBitBtn3.Enabled:=False;
    RzBitBtn4.Enabled:=False;
    fshow:=0;
    bdxh:=0;
    OldMessage:=Application.OnMessage;
    Application.OnMessage :=DoMessage;
end;

procedure Tinputfrm.Label122MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin

  {if (ssleft in Shift) then
    begin
      ReleaseCapture;
      Perform(WM_syscommand, $F012, 0);
    end; }

end;

procedure Tinputfrm.menuImportLibraryClick(Sender: TObject);
begin
  s1:='';
  cishu:=0;
  StaticText1.Caption:='��į����';
  Label1.text:='';
  Hookoff;
   if not Assigned(educefrm) then
      educefrm:=Teducefrm.Create(self);
      try
       with educefrm do
         begin
           Tag := self.Tag+1;
           Hint := self.Hint;
           Top:=self.Top-self.Height;
           left:=self.Left;
           ShowModal;
         end;
      finally
        FreeAndNil(educefrm);
      end;
   Setforegroundwindow(f3);
   Hookon;
end;

procedure Tinputfrm.Button3Click(Sender: TObject);
begin
   if button3.Caption ='�� ��   ' then
      begin
        bdxh:=1 ;
        button3.Caption:='ȫ ��   ';
      end
   else
      begin
        bdxh:=0 ;
        button3.Caption:='�� ��   ';
      end;
end;

procedure Tinputfrm.menuExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tinputfrm.menuExportLibraryClick(Sender: TObject);
var
  zikudaochu:tstringlist ;
  i:integer;
  saveDlg: TsaveDialog;
  strFileName,fname: string;
begin
   saveDlg := TsaveDialog.Create(nil);
  try
    saveDlg.Filter := '�ִʿ��ļ�(*.txt)|*.txt|ȫ���ļ�(*.*)|*.*';
    saveDlg.DefaultExt := '*.txt';
    saveDlg.FileName:='�ִʿⱸ��.txt';
    if saveDlg.Execute then
    begin
         strFileName := Trim(saveDlg.FileName);
         if strFileName <> '' then
            begin
              fname := strFileName;
            end
         else
            begin
             fname:='�ִʿⱸ��.txt';
            end;
        DateTimeToString(strFileName,'yyyy��mm��dd�� hʱmm��ss��',now());
        zikudaochu:=tstringlist.Create();
        for i:=0 to jm.Count-1 do
            begin
              zikudaochu.Add(jm[i]+' '+zw[i]);
            end;
        zikudaochu.Insert(0,'��������ֿ�V2.0�ִʿ⵼�����ڣ�'+strFileName);
        zikudaochu.Insert(1,'����:��Į����');
        zikudaochu.Insert(2,'������򣺱���(Сд��ĸ)��Сд�ո��ִ�');
        zikudaochu.SaveToFile(fname);
        try
          zikudaochu.Destroy;
        except
        end;
    end;
  finally
      FreeAndNil(saveDlg);
  end;
end;

procedure Tinputfrm.FormShow(Sender: TObject);
begin
   InvalidateRect(0, nil, true);
end;

procedure Tinputfrm.menuExportSymbolsClick(Sender: TObject);
var
  zikudaochu:tstringlist ;
  i:integer;
  saveDlg: TsaveDialog;
  strFileName,fname: string;
begin
   saveDlg := TsaveDialog.Create(nil);
  try
    saveDlg.Filter := '�����ļ�(*.txt)|*.txt|ȫ���ļ�(*.*)|*.*';
    saveDlg.DefaultExt := '*.txt';
    saveDlg.FileName:='���ſⱸ��.txt';
    if saveDlg.Execute then
    begin
         strFileName := Trim(saveDlg.FileName);
         if strFileName <> '' then
            begin
              fname := strFileName;
            end
         else
            begin
             fname:='���ſⱸ��.txt';
            end;
         zikudaochu:=tstringlist.Create();
        for i:=0 to zdfha.Count-1 do
            begin
                zikudaochu.Add(zdfha[i]+' '+zdfhz[i]);
            end;
        zikudaochu.SaveToFile(fname);
        try
          zikudaochu.Destroy;
        except
        end;
   end;
  finally
    FreeAndNil(saveDlg);
  end;
end;
procedure Tinputfrm.menuTextClick(Sender: TObject);
begin
  //s1:='';
  //cishu:=0;
  //StaticText1.Caption:='��į����';
  //Label1.text:='';
  Hookoff;
   if not Assigned(Visiblefrm) then
      Visiblefrm:=TVisiblefrm.Create(self);
      try
       with Visiblefrm do
         begin
           Tag := self.Tag+1;
           Hint := self.Hint;
           Top:=self.Top-self.Height;
           left:=self.Left;
           ShowModal;
         end;
      finally
        FreeAndNil(Visiblefrm);
      end;
   Setforegroundwindow(f3);
   Hookon;
end;

end.

