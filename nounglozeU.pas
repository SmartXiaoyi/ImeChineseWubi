unit nounglozeU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, ADODB;

type
  Tnounglozefrm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit3: TEdit;
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
     filepath:String;
  public
    { Public declarations }

  end;

var
  nounglozefrm: Tnounglozefrm;
  bmweizhi:integer;
implementation
uses InputU;
{$R *.dfm}


procedure Tnounglozefrm.Button1Click(Sender: TObject);
begin
   close;
end;

procedure Tnounglozefrm.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i,k,w:integer;
  key1:string;
begin
   memo1.Text:=''; k:=0;
   if ((key>=65) and (key<=90)) or (key=8) then
    begin
      key1:=chr(key);
      if (key1[1] in ['a'..'z','A'..'Z']) or (key=8)then
        begin
          key1:=edit1.Text;
          if (key1<>'')and (length(key1)<5) then
            begin
              for w:=0 to zdfha.Count-1 do
                  begin
                    if key1= zdfha[w] then
                       begin
                          memo1.Lines.Add(inttostr(k)+' | '+zdfha[w]+' | '+zdfhz[w]);
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
                showmessage('编码长度最多4个字符。');
                
             end;
             
          end;

        end;
    end
   else
   begin
     key1:=edit1.Text;
     if (key1<>'') and (key<>8) then delete(key1,length(key1),1);
     edit1.Text:=key1;
     edit1.SelStart:=length(key1);

     if key <>8 then showmessage('请输入编码a~y,长度4。');
   end;
  //showmessage('/'+inttostr(bmweizhi)+'/')
end;

procedure Tnounglozefrm.FormShow(Sender: TObject);
begin
   bmweizhi:=0;
end;

procedure Tnounglozefrm.Button2Click(Sender: TObject);
var
  i,j,suoyin:integer;
  str,str1:string;
begin
   if edit1.Text='' then begin showmessage('编码不能为空！！');exit;end;
   if edit2.Text='' then begin showmessage('字词不能为空！！');exit;end;
   if edit3.Text='' then begin showmessage('插入位置不能为空！！');exit;end;

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
    zdfha.Insert(bmweizhi+strtoint(edit3.Text),edit1.Text);
    zdfhz.Insert(bmweizhi+strtoint(edit3.Text),edit2.Text);
   end;
   end;

procedure Tnounglozefrm.Edit3KeyUp(Sender: TObject; var Key: Word;
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

procedure Tnounglozefrm.Memo1MouseDown(Sender: TObject;
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

procedure Tnounglozefrm.Button4Click(Sender: TObject);
var
  i,j,suoyin:integer;
  str,str1:string;
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
   zdfha.Delete(bmweizhi+strtoint(edit3.Text));
   zdfhz.Delete(bmweizhi+strtoint(edit3.Text));

end;

procedure Tnounglozefrm.Button3Click(Sender: TObject);
var
  zikudaochu:tstringlist ;
  i:integer;
begin
   zikudaochu:=tstringlist.Create();
   for i:=0 to zdfha.Count-1 do
   begin
     zikudaochu.Add(zdfha[i]+' '+zdfhz[i]);
   end;
   zikudaochu.SaveToFile('zdfh.txt');
   try
    zikudaochu.Destroy;
  except
  end;
   
end;




procedure Tnounglozefrm.GroupBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    if (ssleft in Shift) then
    begin
      ReleaseCapture;
      Perform(WM_syscommand, $F012, 0);
    end;
end;

end.
