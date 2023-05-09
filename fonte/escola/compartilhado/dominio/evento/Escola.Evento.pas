unit Escola.Evento;

interface

uses
   System.Generics.Collections,
   Escola.Evento.Tipo;

type
   TEvento = class abstract
   public
      function Momento: TDateTime; virtual; abstract;
      function Tipo: TEventoTipo; virtual; abstract;
      function MapaInformacao: TDictionary<String, String>; virtual; abstract;
   end;

implementation

end.
