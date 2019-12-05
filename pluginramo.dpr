library pluginramo;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  vcl.forms,
  vcl.dialogs,
  System.Classes,
  uConecta in 'uConecta.pas' {FmConexao},
  uDialogo in 'uDialogo.pas' {Form1},
  uAjustes in 'uAjustes.pas';

var xFormAnterior : TForm;

{$R *.res}
var
xyz : integer;

procedure IniciarMensagemConexao(FormAnterior : TForm; msgConexao : string);
begin
//showmessage('handell: '+FloatToStr(app.Handle)+#13+FloatToStr(application.Handle));
  try
if Application.Handle <> FormAnterior.Handle then
 application.Handle := FormAnterior.Handle;
     except
     raise Exception.Create('FormAnterior não foi criado ainda, procedure no lugar errado');
     end;
  try
//if  application.Handle <> app.Handle then
//if app.HandleMessage<>0 then
//

if xFormAnterior<>nil then
if FormAnterior = xFormAnterior then xFormAnterior.Enabled := true;

xFormAnterior := FormAnterior;

if xFormAnterior<>nil then
if xFormAnterior.Active then
xFormAnterior.Enabled := false;
if FmConexao = nil then Application.CreateForm(TFmConexao, FmConexao);
  Application.CreateForm(TForm1, Form1);
  FmConexao.StaticText1.Caption := msgConexao;
FmConexao.Show;
Application.ProcessMessages;
  except
  showmessage('Falha ao Iniciar Mensagem');
  end;
  exit;

 end;
exports
IniciarMensagemConexao;

procedure FinalizaMensagemConexao();
begin

  try
Application.ProcessMessages;
if xFormAnterior<>nil then
  xFormAnterior.Enabled := true;  except end;
//  FmConexao.Close;
try
  freeandnil(FmConexao);
  except
  showmessage('fallha na .dll ao finalizar');
  end;

end;
exports
  FinalizaMensagemConexao;

  //#############################################################################
FUNCTION CriptografarString(aTexto : string;criptografando : boolean):string;
const cript : array[1..58] of string = ('ü','Ü','ä','Ä','ë','Ë','ï','Ï','ö','Ö',
                                        'ã','Ã','õ','Õ','á','Á','à','À','é','É',
                                        'è','È','í','Í','ó','Ó','ò','Ò','x','X',
                                        'y','Y','t','T','z','Z','j','J','a','A',
                                        'f','F','h','H','c','C','n','N',
                                        ':','|','§','^','ç','"','+','$','¬','~');

   DesCript : array[1..58] of string = ('a','A','b','B','c','C','d','D','e','E',
                                        'f','F','g','G','h','H','i','I','j','J',
                                        'l','L','k','K','m','M','n','N','o','O',
                                        'p','P','q','Q','r','R','s','S','t','T',
                                        'w','W','x','X','y','Y','z','Z',
                                        '0','1','2','3','4','5','6','7','8','9');
function localizaCharEmArray(Arraym : array of string;Charm : String):integer;
var i : integer;
begin
 for I := 0 to 58 do begin
 if arraym[i]= charm then begin
                          Result := i;// showmessage(inttostr(i+1));
                          break;
                          end;
                          Result := -1;
                     end;
end;
var s,Linha : string;i, a: integer;list: TStringlist;
begin //nao funcioa com   especiais


  List := TStringlist.Create;
  for I := 1 to length(atexto) do
    List.Add(aTexto[i]);

  for i := 0 to list.Count-1 do
 begin
  if criptografando then
   a := localizaCharEmArray(descript,List[i])//DesList.IndexOf(List[i])
   else a := localizaCharEmArray(cript,List[i]);//CrList.IndexOf(List[i]);

   if a>=0 then
   if criptografando then
  Linha:=Linha+ StringReplace(aTexto[i+1], DesCript[a+1], Cript[a+1], [rfreplaceall])
  else Linha:=Linha+ StringReplace(aTexto[i+1], Cript[a+1], DesCript[a+1], [rfreplaceall])
  else Linha := linha+List[i];

 end;

  Result := linha;

end;
exports
CriptografarString;
function Sistemalicenciado(nomeAplicativo : string): boolean;
begin
  if date>strtodate('30/10/2020') then
  begin
  result := false;
  Application.MessageBox('Licença do Sistema vencida, contate o suporte','Não Licenciado',16);
  Application.Terminate;
  end else Result := true;

end;
exports
Sistemalicenciado;
procedure Informar(msg : string; FormAnterior : TForm);
begin
IniciarMensagemConexao(FormAnterior,msg);
FmConexao.Timer1.Enabled := true;
end;
exports
 Informar;


 exports
messageConfirmaBtn;

end.

