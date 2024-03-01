{*************************************************************}
{                                                             }
{       OpenSoldat Client                                     }
{                                                             }
{       Copyright (c) 2001      Michal Marcinkowski           }
{       Copyright (c) 2020-2023 OpenSoldat contributors       }
{                                                             }
{*************************************************************}

program opensoldat;

{$IFDEF DARWIN}
{$linklib freetype}
{$linklib stb}
{$linklib physfs}
{$linklib GameNetworkingSockets}
{$ENDIF}

uses
  {$IFDEF UNIX}
  cthreads,
  cwstring,
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  SysUtils,
  {$IFDEF AUTOUPDATER}
  AutoUpdater,
  {$ENDIF}
  Client in 'Client.pas';

{$IFDEF MSWINDOWS}
const
  {$IFNDEF DEBUG}
    IMAGE_DLLCHARACTERISTICS_NX_COMPAT = $0100;
    {$SetPEOptFlags IMAGE_DLLCHARACTERISTICS_NX_COMPAT}

    IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE = $0040;
    {$SetPEOptFlags IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE}

    {$IFDEF CPU64}
      IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA = $0020;
      {$SetPEOptFlags IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA}
    {$ENDIF}
  {$ENDIF}
  IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE = $8000;
  {$SetPEOptFlags IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE}
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}
{$R *.res}
{$ENDIF}

begin
  {$IFDEF AUTOUPDATER}
  StartAutoUpdater;
  {$ENDIF}

  DefaultSystemCodePage := CP_UTF8;

  StartGame;
end.
