unit Escola.Evento.Ouvinte;

interface

uses
   Escola.Evento;

type
   TEventoOuvinte = class abstract
   protected
      procedure ReagirAo(pEvento : TEvento); virtual; abstract;
      function DeveProcessar(pEvento : TEvento): Boolean; virtual; abstract;
   public
      procedure Processar(pEvento : TEvento);
   end;

implementation

{ TEventoOuvinte }

procedure TEventoOuvinte.Processar(pEvento: TEvento);
begin
   if DeveProcessar(pEvento) then
      ReagirAo(pEvento);
end;

end.
