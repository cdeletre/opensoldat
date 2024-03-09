{*************************************************************}
{                                                             }
{       ScriptGlobal Unit for OpenSoldat                      }
{                                                             }
{       Copyright (c) 2014      Tomasz Kolosowski             }
{       Copyright (c) 2014      Umut Karakas                  }
{       Copyright (c) 2020-2023 OpenSoldat contributors       }
{                                                             }
{*************************************************************}

// Unit for stuff that is not only used by this specific script.
// TODO: Documentation.
unit ScriptGlobal;

{$IFDEF FPC}{$mode delphi}{$ENDIF}

interface

uses
  // System units
  Classes,
  SysUtils,

  // Project units
  PascalCompiler,
  PascalExec,
  Script,
  ScriptCore3Api;


type
  TScriptGlobal = class(TObject)
  private
    function  GetDateSeparator: Char;
    procedure SetDateSeparator(Separator: Char);
    function  GetShortDateFormat: string;
    procedure SetShortDateFormat(Format: string);
  public
    property ScriptDateSeparator: Char read GetDateSeparator write SetDateSeparator;
    property ScriptShortDateFormat: string read GetShortDateFormat write SetShortDateFormat;
  end;

  TScriptGlobalAPI = class(TScriptCore3API)
  private
    FGlobal: TScriptGlobal;
  public
    constructor Create(Script: TScript);
    destructor Destroy; override;
    procedure CompilerRegister(Compiler: TPascalCompiler); override;
    procedure RuntimeRegisterApi(Exec: TPascalExec); override;
    procedure RuntimeRegisterVariables(Exec: TPascalExec); override;
  end;


implementation


function TScriptGlobal.GetDateSeparator: Char;
begin
  Result := DefaultFormatSettings.DateSeparator;
end;

procedure TScriptGlobal.SetDateSeparator(Separator: Char);
begin
  DefaultFormatSettings.DateSeparator := Separator;
end;

function TScriptGlobal.GetShortDateFormat: string;
begin
  Result := DefaultFormatSettings.ShortDateFormat;
end;

procedure TScriptGlobal.SetShortDateFormat(Format: string);
begin
  DefaultFormatSettings.ShortDateFormat := Format;
end;


constructor TScriptGlobalAPI.Create(Script: TScript);
begin
  inherited Create(Script);
  Self.FGlobal := TScriptGlobal.Create;
end;

destructor TScriptGlobalAPI.Destroy;
begin
  FreeAndNil(Self.FGlobal);
  inherited;
end;

procedure TScriptGlobalAPI.CompilerRegister(Compiler: TPascalCompiler);
var
  ScriptClass: TPascalCompiletimeClass;
begin
  ScriptClass := Compiler.AddClass(nil, 'TGlobal');
  with ScriptClass do
  begin
    RegisterProperty('DateSeparator', 'Char', iptRW);
    RegisterProperty('ShortDateFormat', 'string', iptRW);
  end;

  Compiler.AddPtrVariable('Global', ScriptClass.aType);
end;


procedure DateSeparatorReadHelper(Self: TScriptGlobal; var Result: Char);
begin
  Result := Self.ScriptDateSeparator;
end;

procedure DateSeparatorWriteHelper(Self: TScriptGlobal; const Result: Char);
begin
  Self.ScriptDateSeparator := Result;
end;

procedure ShortDateFormatReadHelper(Self: TScriptGlobal; var Result: string);
begin
  Result := Self.ScriptShortDateFormat;
end;

procedure ShortDateFormatWriteHelper(Self: TScriptGlobal; const Result: string);
begin
  Self.ScriptShortDateFormat := Result;
end;


procedure TScriptGlobalAPI.RuntimeRegisterApi(Exec: TPascalExec);
begin
  with Exec.AddClass(TScriptGlobal, 'TGlobal') do
  begin
    RegisterPropertyHelper(@DateSeparatorReadHelper,
      @DateSeparatorWriteHelper, 'DateSeparator');
    RegisterPropertyHelper(@ShortDateFormatReadHelper,
      @ShortDateFormatWriteHelper, 'ShortDateFormat');
  end;
end;

procedure TScriptGlobalAPI.RuntimeRegisterVariables(Exec: TPascalExec);
begin
  Exec.SetPointerToData('Global', @Self.FGlobal, Exec.FindType(btClass));
end;

end.
