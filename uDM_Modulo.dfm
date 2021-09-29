object dm_Modulo: Tdm_Modulo
  OldCreateOrder = False
  Height = 238
  Width = 337
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Runtec - Fase1\Banco de dados\runtecMusic.db'
      'DriverID=SQLite')
    UpdateOptions.AssignedValues = [uvEUpdate, uvRefreshMode, uvAutoCommitUpdates]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.AutoCommitUpdates = True
    Connected = True
    LoginPrompt = False
    Transaction = fdTransaction
    Left = 40
    Top = 88
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 112
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 200
    Top = 24
  end
  object qryGeral: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Transaction = fdTransaction
    SQL.Strings = (
      'SELECT trackId,'
      '       collectionId,'
      '       artistId,'
      '       wrapperType,'
      '       kind,'
      '       artistName,'
      '       collectionName,'
      '       trackName,'
      '       artistViewUrl,'
      '       collectionViewUrl,'
      '       trackViewUrl,'
      '       trackTimeMillis,'
      '       previewUrl,'
      '       notaMusical'
      '  FROM jsonItunesAPI;')
    Left = 232
    Top = 96
    object qryGeraltrackId: TWideStringField
      FieldName = 'trackId'
      Origin = 'trackId'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 32767
    end
    object qryGeralcollectionId: TWideStringField
      FieldName = 'collectionId'
      Origin = 'collectionId'
      Size = 32767
    end
    object qryGeralartistId: TWideStringField
      FieldName = 'artistId'
      Origin = 'artistId'
      Size = 32767
    end
    object qryGeralwrapperType: TWideStringField
      FieldName = 'wrapperType'
      Origin = 'wrapperType'
      Size = 32767
    end
    object qryGeralkind: TWideStringField
      FieldName = 'kind'
      Origin = 'kind'
      Size = 32767
    end
    object qryGeralartistName: TWideStringField
      FieldName = 'artistName'
      Origin = 'artistName'
      Size = 32767
    end
    object qryGeralcollectionName: TWideStringField
      FieldName = 'collectionName'
      Origin = 'collectionName'
      Size = 32767
    end
    object qryGeraltrackName: TWideStringField
      FieldName = 'trackName'
      Origin = 'trackName'
      Size = 32767
    end
    object qryGeralartistViewUrl: TWideStringField
      FieldName = 'artistViewUrl'
      Origin = 'artistViewUrl'
      Size = 32767
    end
    object qryGeralcollectionViewUrl: TWideStringField
      FieldName = 'collectionViewUrl'
      Origin = 'collectionViewUrl'
      Size = 32767
    end
    object qryGeraltrackViewUrl: TWideStringField
      FieldName = 'trackViewUrl'
      Origin = 'trackViewUrl'
      Size = 32767
    end
    object qryGeraltrackTimeMillis: TWideStringField
      FieldName = 'trackTimeMillis'
      Origin = 'trackTimeMillis'
      Size = 32767
    end
    object qryGeralpreviewUrl: TWideStringField
      FieldName = 'previewUrl'
      Origin = 'previewUrl'
      Size = 32767
    end
    object qryGeralnotaMusical: TBCDField
      FieldName = 'notaMusical'
      Origin = 'notaMusical'
      Precision = 1
      Size = 1
    end
  end
  object fdTransaction: TFDTransaction
    Connection = FDConnection1
    Left = 152
    Top = 88
  end
  object qryGeral2: TFDQuery
    Connection = FDConnection1
    Transaction = fdTransaction
    SQL.Strings = (
      'select * from jsonItunesAPI')
    Left = 248
    Top = 144
    object qryGeral2trackId: TWideStringField
      FieldName = 'trackId'
      Origin = 'trackId'
      Size = 32767
    end
    object qryGeral2collectionId: TWideStringField
      FieldName = 'collectionId'
      Origin = 'collectionId'
      Size = 32767
    end
    object qryGeral2artistId: TWideStringField
      FieldName = 'artistId'
      Origin = 'artistId'
      Size = 32767
    end
    object qryGeral2wrapperType: TWideStringField
      FieldName = 'wrapperType'
      Origin = 'wrapperType'
      Size = 32767
    end
    object qryGeral2kind: TWideStringField
      FieldName = 'kind'
      Origin = 'kind'
      Size = 32767
    end
    object qryGeral2artistName: TWideStringField
      FieldName = 'artistName'
      Origin = 'artistName'
      Size = 32767
    end
    object qryGeral2collectionName: TWideStringField
      FieldName = 'collectionName'
      Origin = 'collectionName'
      Size = 32767
    end
    object qryGeral2trackName: TWideStringField
      FieldName = 'trackName'
      Origin = 'trackName'
      Size = 32767
    end
    object qryGeral2artistViewUrl: TWideStringField
      FieldName = 'artistViewUrl'
      Origin = 'artistViewUrl'
      Size = 32767
    end
    object qryGeral2collectionViewUrl: TWideStringField
      FieldName = 'collectionViewUrl'
      Origin = 'collectionViewUrl'
      Size = 32767
    end
    object qryGeral2trackViewUrl: TWideStringField
      FieldName = 'trackViewUrl'
      Origin = 'trackViewUrl'
      Size = 32767
    end
    object qryGeral2trackTimeMillis: TWideStringField
      FieldName = 'trackTimeMillis'
      Origin = 'trackTimeMillis'
      Size = 32767
    end
    object qryGeral2previewUrl: TWideStringField
      FieldName = 'previewUrl'
      Origin = 'previewUrl'
      Size = 32767
    end
    object qryGeral2notaMusical: TBCDField
      FieldName = 'notaMusical'
      Origin = 'notaMusical'
      Precision = 1
      Size = 1
    end
  end
end
