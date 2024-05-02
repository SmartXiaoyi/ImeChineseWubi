unit DllU1;

interface
  uses Windows, SysUtils;

const
  WM_hookKEY =$450;    //钩子消息          WM_hookKEY = WM_USER + $1200;

  procedure HookOn;stdcall;
  procedure HookOff;stdcall;
  
implementation
type
  node=record
   h:longint; //窗口句柄
   cs:integer;//上屏标志
   bd:integer;// 标点状态
   zt:integer;//中西状态
   end;

var
  HookH:HHook;    //钩子句柄
  fileM:THandle;  //内存映射文件句柄
  cs:integer;   //记录按键次数
  pnode:^node;  //映射到主程序记录变量

function keyhook(Code:Integer;wParam:WPARAM;lParam:LPARAM):LRESULT;stdcall;
var
  j:integer;
  tj1,tj2,tj3,tj4,tj5:Boolean;
  s3:string;
const
  _KeyPressMask = $80000000;
begin
    j:=wparam;
    //textout(getdc(0),106,402,pchar(IntToStr(wparam)),length(pchar(IntToStr(wparam))));
    tj1:= (j>=65) and (j <=90);
    tj3:= (j=189) or (j=187) or (j=220);
    tj2:= (j=32) or (j=46);
    tj4:= (j>=48) and (j<=57);
    tj5:= (j>=112) and (j<=123);
    
    if  ((lParam  and  _KeyPressMask) = 0)  and     //判断是否组合键
         ( ((GetKeyState(vk_Control)  < 0)  and  (tj1=True)) or
           ((GetKeyState(vk_Control)  < 0)  and  (tj5=True)) or
           ((GetKeyState(VK_TAB)   <  0)    and  (GetKeyState(VK_MENU)<0)) or
           ((GetKeyState(VK_MENU)  <  0)    and  (tj5=True)) or
           ((GetKeyState(VK_MENU)  <  0)    and  (tj1=True))) then
      begin
        Result :=CallNextHookEx(HookH,code,Wparam,lParam);
        Exit;
      end;
    if wparam in [37,39,187,189,220] then
      begin
        Result :=CallNextHookEx(HookH,code,Wparam,lParam);
        Exit;
      end;

  if Code=HC_ACTION then
    begin
      FileM:=OpenFileMapping(FILE_MAP_READ,False,'kdHook');//打开内存映射文件
                    
      if (FileM<>0) and (((LParam shr 31)and 1)=0) then   //打开成功  and  按下消息
      begin
        pnode:=MapViewOfFile(FileM,FILE_MAP_READ,0,0,0);
        //接受4字已上屏的消息
        s3:=inttohex(pnode^.h,2);
        if pnode^.cs=0 then cs:=0;
        if (j=191) or (j=190) or (j=188) or (j=186) or (j=222) or (j=33) or (j=34) then
         begin
           if  (cs = 0) and ((j=33) or (j=34)) then
                Result:=CallNextHookEx(HookH,code,Wparam,lParam)
           else
            Begin
               result:=1;  sendMessage(pnode^.h,WM_HookKEY,wParam,lParam);
            End;
            exit;
         end;

         if (j=13) then
            begin
               if cs=0 then
                          begin
                            result:=0;exit;
                          end
               else
                  begin
                      result:=1;
                      sendMessage(pnode^.h,WM_HookKEY,wParam,lParam);
                      exit;
                  end;
            end;

        if (lparam shr 16)=8504 then
           begin    //按下右alt键
             result:=0;
             SendMessage(pnode^.h,WM_HookKEY,wParam,lParam);
             exit;
           end;
        if  (lparam shr 16)=285 then
           begin    //按下右ctrl键
             result:=1;
             SendMessage(pnode^.h,WM_HookKEY,wParam,lParam);
             exit;
           end;
        if  (lparam shr 16)=54 then
           begin    //按下右shift键
             result:=0;
             SendMessage(pnode^.h,WM_HookKEY,wParam,lParam);
             exit;
           end;
        if (lparam shr 16)=42 then
           begin    //按下左shift键
             result:=0;
             SendMessage(pnode^.h,WM_HookKEY,wParam,lParam);
             exit;
           end;
       if  pnode^.zt =1 then
           begin //读拦截状态
             result:=0;
             exit;
           end;
        if not (tj1 or (j=220)) and (cs=0)  then //当按下编码字符后开始拦截
           begin
             result:=0;
             exit;
           end
        else result:=1;

       if tj4 or tj2 then
          cs:=0; // 空格，esc ，数字键
       if (j=8) and (cs>0) then
          cs:=cs-1;   //bakespace
       if tj1 or tj3 then
          cs:=cs+1;              //编码字符

        begin //如果Ctrl、shift、Alt键没有按下则发送按键
            if (HiWord(GetKeystate(vk_control))=0)and(HiWord(getKeystate(vk_shift))=0)and( HiWord(GetKeystate(vk_cancel))=0) then
               begin
                 sendMessage(pnode^.h,WM_HookKEY,wParam,lParam);//把键发给主程序
               end
            else//如果Ctrl、shift、Alt按下则把消息给下一个按收者。
                begin
                 Result:=CallNextHookEx(HookH,code,Wparam,lParam);
                end;
        end;
        UnmapViewOfFile(Pnode);  //取消映射
        CloseHandle(FileM);   //关闭内存映射文件

      end;
  end
  else
     Result:=CallNextHookEx(HookH,code,Wparam,lParam);

end;
procedure HookOn;
begin
  HooKH:=SetWindowsHookEx(WH_KEYBOARD,KeyHook,HInstance,0);
end;
procedure HookOff;
begin
  UnHookWindowsHookEx(HookH);
end;

end.
