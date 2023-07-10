unit ClientLauncherIPC;

interface

uses
  // Project units
  LauncherIPC;


type
  TClientLauncherIPC = class(TLauncherIPC)
  protected
    procedure HandleMessage(Message: String); override;
  end;


implementation

procedure TClientLauncherIPC.HandleMessage(Message: String);
begin
  HandleCommand(Message);
end;

end.
