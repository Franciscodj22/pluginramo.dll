unit uDialogo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    Btn1: TSpeedButton;
    Btn2: TSpeedButton;
    Image0: TImage;
    Timer1: TTimer;
    ShMsg: TShape;
    Shape1: TShape;
    StaticText1: TStaticText;
    Shape2: TShape;
    Image2: TImage;
    Image1: TImage;
   // function messageConfirmaBtn(mPrompt : string;cptBtn1, cptBtn2 : string;imgIcon : integer;tmpEsperaSeg : integer = 0):integer;
    procedure Btn1Click(Sender: TObject);
    procedure Btn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Shape1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

   function messageConfirmaBtn(handle : THandle;mPrompt, cptBtn1, cptBtn2: string; imgIcon,
  tmpEsperaSeg: integer): integer;
  //function PegaResult(i : integer): integer;

var
  Form1: TForm1;
  tempo : integer = 30;
  cptBtnPadrao : string;

implementation

{$R *.dfm}

uses uAjustes;

{ TForm1 }


 function messageConfirmaBtn(handle : THandle;mPrompt, cptBtn1, cptBtn2: string; imgIcon, tmpEsperaSeg: integer): integer;
 var
 i : integer; //linhaMax = 25
 ls : TStringList;
begin
application.Handle := handle;

if form1 = nil then
Application.CreateForm(TForm1, Form1);

with form1 do begin
tempo := tmpEsperaSeg;
  if tempo<=0 then tempo := 30;
   try
  case imgIcon of
  1:begin image0.Visible := false; image1.visible := true;image1.Top := 8; image1.Left := 274; end;
  2:begin image0.Visible := false; image2.visible := true;image2.Top := 8; image2.Left := 274; end;
  end;
   except on e:exception do showmessage('MessageBTN - DLL'+#13+e.Message); end;
 ls := TStringList.Create;
 ls.Text := stringreplace(mPrompt,' ',#13,[rfReplaceAll]);

  Btn1.Caption := cptBtn1+' - 1';
  Btn2.Caption := cptBtn2+' - 2';
  cptBtnPadrao := btn1.Caption;

 form1.Canvas.brush.Color := clnone;
 Form1.Canvas.Font.Color := clblack;
Form1.Canvas.Font.Size := 12;
Form1.Canvas.Font.Style:= [fsBold];
  Form1.Canvas.TextOut(Shape2.Left+55,Shape2.Top+40,cptBtn2);


  StaticText1.Caption := '';
  if tmpEsperaSeg > 0 then tempo := tmpEsperaSeg;


  if length(mPrompt)>25 then
    for I := 0 to ls.Count-1 do
    if length(StaticText1.Caption +' '+ ls[i]) mod 25=0 then
       StaticText1.Caption := StaticText1.Caption+ls[i]+#13
         else StaticText1.Caption := StaticText1.Caption+ls[i]+' '
         else StaticText1.Caption := mPrompt;

         // showmessage(ls.Text);
    freeandnil(ls);
    tag := 10;
    timer1.Enabled := true;
    ShowModal;
     Result := resultMessage ;

              end;
end;
procedure TForm1.Btn1Click(Sender: TObject);
begin
resultMessage := 1;
close;
end;

procedure TForm1.Btn2Click(Sender: TObject);
begin
resultMessage := 2;
close;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action := cafree;
form1 := nil;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
case key of
'1': Btn1Click(sender);
'2': Btn2Click(sender);
end;
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  altura, coluna: Word;
begin
  (*
  altura := (ClientHeight + 255) div 256;
  for coluna := 0 to 255 do
    with Canvas do
    begin
     Brush.Color := RGB(coluna, 50, 250); { Modifique para obter cores diferentes }
      FillRect(Rect(0, coluna * altura, ClientWidth, (coluna + 1) * altura)) ;
    end;   *)

end;

procedure TForm1.Shape1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Btn1Click(sender);
end;

procedure TForm1.Shape2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Btn2Click(sender);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
try
tempo := tempo-1;
btn1.Caption := cptBtnPadrao+' ('+inttostr(tempo)+')';
if tempo<=0 then Btn1Click(sender);
timer1.Enabled :=  tag=10;
   except end;
{  try
   Form1.Canvas.TextOut(Shape1.Left+50,Shape1.Top+35,btn1.Caption);
   Form1.Canvas.TextOut(Shape2.Left+50,Shape2.Top+35,btn2.Caption);
   except end;  }
end;

end.
