unit uConecta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  System.ImageList, Vcl.ImgList, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFmConexao = class(TForm)
    StaticText1: TStaticText;
    Image1: TImage;
    ImageList1: TImageList;
    SpeedButton1: TSpeedButton;
    Timer1: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmConexao: TFmConexao;

implementation

{$R *.dfm}

procedure TFmConexao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action :=cafree;
fmconexao := nil;
end;



procedure TFmConexao.Timer1Timer(Sender: TObject);
begin
self.AlphaBlend := true;
self.AlphaBlendValue := self.AlphaBlendValue-2;
if self.AlphaBlendValue <= 10 then close;

end;

end.
