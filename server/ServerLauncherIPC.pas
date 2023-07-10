unit ServerLauncherIPC;

interface

uses
  // Project units
  LauncherIPC;

type
  TServerLauncherIPC = class(TLauncherIPC)
  protected
    procedure HandleMessage(Message: String); override;
  end;


implementation

procedure TServerLauncherIPC.HandleMessage(Message: String);
begin
  HandleCommand(Message);
end;

end.
