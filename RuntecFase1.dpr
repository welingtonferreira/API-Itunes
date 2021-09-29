program RuntecFase1;

uses
  System.StartUpCopy,
  FMX.Forms,
  uConsultaMusicas in 'uConsultaMusicas.pas' {frmConsultaMusicas},
  uDM_Modulo in 'uDM_Modulo.pas' {dm_Modulo: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmConsultaMusicas, frmConsultaMusicas);
  Application.CreateForm(Tdm_Modulo, dm_Modulo);
  Application.Run;
end.
