unit uDM_Modulo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef,
  FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Phys.SQLite;

type
  Tdm_Modulo = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    qryGeral: TFDQuery;
    fdTransaction: TFDTransaction;
    qryGeraltrackId: TWideStringField;
    qryGeralcollectionId: TWideStringField;
    qryGeralartistId: TWideStringField;
    qryGeralwrapperType: TWideStringField;
    qryGeralkind: TWideStringField;
    qryGeralartistName: TWideStringField;
    qryGeralcollectionName: TWideStringField;
    qryGeraltrackName: TWideStringField;
    qryGeralartistViewUrl: TWideStringField;
    qryGeralcollectionViewUrl: TWideStringField;
    qryGeraltrackViewUrl: TWideStringField;
    qryGeraltrackTimeMillis: TWideStringField;
    qryGeralpreviewUrl: TWideStringField;
    qryGeral2: TFDQuery;
    qryGeral2trackId: TWideStringField;
    qryGeral2collectionId: TWideStringField;
    qryGeral2artistId: TWideStringField;
    qryGeral2wrapperType: TWideStringField;
    qryGeral2kind: TWideStringField;
    qryGeral2artistName: TWideStringField;
    qryGeral2collectionName: TWideStringField;
    qryGeral2trackName: TWideStringField;
    qryGeral2artistViewUrl: TWideStringField;
    qryGeral2collectionViewUrl: TWideStringField;
    qryGeral2trackViewUrl: TWideStringField;
    qryGeral2trackTimeMillis: TWideStringField;
    qryGeral2previewUrl: TWideStringField;
    qryGeralnotaMusical: TBCDField;
    qryGeral2notaMusical: TBCDField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm_Modulo: Tdm_Modulo;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
