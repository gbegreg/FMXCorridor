program FMXCorridor;

uses
  System.StartUpCopy,
  FMX.Forms,
  principale in 'principale.pas' {fPrincipale},
  uNiveau in 'uNiveau.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfPrincipale, fPrincipale);
  Application.Run;
end.
