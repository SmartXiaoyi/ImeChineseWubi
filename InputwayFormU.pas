unit InputwayFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, ExtCtrls,DB, ADODB, ComCtrls;
type
  TInputwayfrm = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Memo1: TMemo;
    Label3: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit3: TEdit;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure GroupBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    FInjm,Fwzname:String;
  end;
var
  Inputwayfrm: TInputwayfrm;
  bmweizhi:integer;//编码位置
implementation

uses InputU;

{$R *.dfm}

procedure TInputwayfrm.Button1Click(Sender: TObject);
begin
   close;
end;

procedure TInputwayfrm.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i,k,w:integer;
  key1:string;
begin
   memo1.Text:=''; k:=0;
   if key=13 then exit;
   if ((key>=65) and (key<=90)) or (key=8) then
    begin
      key1:=chr(key);
      if (key1[1] in ['a'..'z','A'..'Z']) or (key=8)then
        begin
          key1:=edit1.Text;
          if (key1<>'')and (length(key1)<5) then
            begin
              for w:=1 to 25 do
              if key1[1] = zikusuoyin[w].en then   i:=w;
              for w:=zikusuoyin[i].shou to zikusuoyin[i].wei do
                  begin
                    if key1= jm[w] then
                       begin
                          memo1.Lines.Add(inttostr(k)+' | '+jm[w]+' | '+zw[w]);
                          if k=0 then bmweizhi:=w;
                          k:=k+1;
                       end;
                  end;
            end
          else
          begin
            if length(key1)>4 then
             begin
                key1:=edit1.Text;
                if key<>8 then delete(key1,length(key1),1);
                edit1.Text:=key1;
                edit1.SelStart:=length(key1);
             end;
             if key1<>'' then
             begin
                showmessage('编码长度4个字符。');
                Inputwayfrm.Edit1.OnKeyUp(Sender, Key,Shift);
             end;
          end;
        end;
    end    
   else
   begin
     if key=13 then
       begin
         Inputwayfrm.Edit1.OnKeyUp(Sender, Key,Shift);
       end
     else
     begin
        key1:=edit1.Text;
        if (key1<>'') and (key<>8) then delete(key1,length(key1),1);
        edit1.Text:=key1;
        edit1.SelStart:=length(key1);
        if key <>8 then showmessage('请输入编码a~y,长度4。');
     end;
   end;
  //showmessage('/'+inttostr(bmweizhi)+'/')
end;

procedure TInputwayfrm.FormShow(Sender: TObject);
begin
   bmweizhi:=0;
end;

procedure TInputwayfrm.Button2Click(Sender: TObject);
var
  i,j,suoyin:integer;
  str,str1:string;
begin
   if edit1.Text='' then begin showmessage('编码不能为空！！');exit;end;
   if edit2.Text='' then begin showmessage('字词不能为空！！');exit;end;
   if edit3.Text='' then begin showmessage('插入位置不能为空！！');exit;end;

   if messagebox(inputfrm.Handle,pchar('确定把编码为“'+edit1.text+'”字词为“'+edit2.text+'”'+#13+'添加到内存五笔字词库吗?'),'信息提示',MB_OKCANCEL+MB_ICONQUESTION)= IDOK THEN
   BEGIN
    if strtoint(edit3.Text)>=0 then
    begin
      for i:=strtoint(edit3.text) to memo1.Lines.Count do
        begin
          str1:='';
          str:=memo1.Lines[i];
          for j:=1 to length(str)do
              if str[j] in ['0'..'9'] then  str1:=str1+str[j];
          if str1<>'' then
            begin
              delete(str,1,length(str1));
              memo1.Lines[i]:=inttostr(strtoint(str1)+1)+ str;
            end;

        end;
      memo1.Lines.Insert(strtoint(edit3.Text),edit3.Text+' | '+edit1.Text+' | '+edit2.Text);
      jm.Insert(bmweizhi+strtoint(edit3.Text),edit1.Text);
      zw.Insert(bmweizhi+strtoint(edit3.Text),edit2.Text);
      j:=0;suoyin:=1; str:='';
      for i:=0 to jm.Count -1 do
      begin
        str:=jm[i];
        if str[1] in ['a'..'z','A'..'Z'] then
            if (length(str)=1) then
              begin
                  if (j=0) and (suoyin<26) then
                    begin
                      zikusuoyin[suoyin].en:=str[1];
                      zikusuoyin[suoyin].shou:=i;
                      if suoyin >1 then zikusuoyin[suoyin-1].wei:=i-1;
                      suoyin:=suoyin+1;
                      j:=j+1;
                    end ;
              end
           else
              begin
                  j:=0;
              end;
          zikusuoyin[25].wei:=jm.Count-1;
      end;
    end;
  END;
end;

procedure TInputwayfrm.Edit3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  lin,i,k,w:integer;
  key1:string;
begin
   if ((key>=48) and (key<=57)) or ((key>=96) and (key<=105))then
    begin
       with memo1 do
          begin
            //lin:=perform(EM_LINEFROMCHAR,strtoint(edit3.Text),0);
            SelStart:=perform(EM_LINEINDEX,strtoint(edit3.Text),0);
            memo1.SelLength:=length(memo1.Lines[lin]);
            //edit3.Text:=inttostr(memo1.CaretPos.y);
            memo1.SetFocus;
          end;
    end    //  showmessage('/'+key1+'/')
   else
   begin
     key1:=edit3.Text;
     if (key1<>'') and (key<>8) then delete(key1,length(key1),1);
     edit3.Text:=key1;
     edit3.SelStart:=length(key1);
     showmessage('位置只能是数字');
   end;
end;

procedure TInputwayfrm.Memo1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  lin:integer;
begin
   //showmessage(inttostr(memo1.CaretPos.y));
  with memo1 do
  begin
   lin:=perform(EM_LINEFROMCHAR,selstart,0);
   SelStart:=perform(EM_LINEINDEX,lin,0);
   memo1.SelLength:=length(memo1.Lines[lin]);
   edit3.Text:=inttostr(memo1.CaretPos.y);
   //memo1.SetFocus;
  end;
end;

procedure TInputwayfrm.Button4Click(Sender: TObject);
var
  i,j,suoyin:integer;
  str,str1:string;
begin
   if messagebox(inputfrm.Handle,pchar('确定把编码和字词为“'+memo1.Lines[memo1.CaretPos.y]+'”'+#13+'从内存五笔字词库内删除吗?'),'信息提示',MB_OKCANCEL+MB_ICONQUESTION)= IDOK THEN
   begin
      for i:=strtoint(edit3.text) to memo1.Lines.Count do
          begin
            str1:='';
            str:=memo1.Lines[i];
            for j:=1 to length(str)do
                if str[j] in ['0'..'9'] then  str1:=str1+str[j];
            if str1<>''then
              begin
                  delete(str,1,length(str1));
                  if memo1.Lines.count>0then memo1.Lines[i]:=inttostr(strtoint(str1)-1)+ str;
              end;
          end;
        memo1.Lines.Delete(strtoint(edit3.Text));
        jm.Delete(bmweizhi+strtoint(edit3.Text));
        zw.Delete(bmweizhi+strtoint(edit3.Text));
        j:=0;suoyin:=1; str:='';
        for i:=0 to jm.Count -1 do
        begin
          str:=jm[i];
          if str[1] in ['a'..'z','A'..'Z'] then
              if (length(str)=1) then
                begin
                    if (j=0) and (suoyin<26) then
                      begin
                        zikusuoyin[suoyin].en:=str[1];
                        zikusuoyin[suoyin].shou:=i;
                        if suoyin >1 then zikusuoyin[suoyin-1].wei:=i-1;
                        suoyin:=suoyin+1;
                        j:=j+1;
                      end ;
                end
              else
                begin
                    j:=0;
                end;
            zikusuoyin[25].wei:=jm.Count-1;
        end;
   end;
end;

procedure TInputwayfrm.Button3Click(Sender: TObject);
var
  zikudaochu:tstringlist ;
  i:integer;
begin
   zikudaochu:=tstringlist.Create();
   for i:=0 to jm.Count-1 do
   begin
     zikudaochu.Add(jm[i]+' '+zw[i]);
   end;   
   zikudaochu.Insert(0,'自制五笔字库V2.0');
   zikudaochu.Insert(1,'制作:落漠惊梦');
   zikudaochu.Insert(2,'编码规则：编码(小写字母)＋小写空格＋字词');
   zikudaochu.SaveToFile('wubiziku.txt');
   try
    showmessage('保存成功！');
    zikudaochu.Destroy;
  except
    showmessage('保存失败！');
  end;
   
end;

procedure TInputwayfrm.GroupBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssleft in Shift) then
    begin
      ReleaseCapture;
      Perform(WM_syscommand, $F012, 0);
    end;
end;

end.
