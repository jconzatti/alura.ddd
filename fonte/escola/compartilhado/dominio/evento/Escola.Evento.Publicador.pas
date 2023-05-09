unit Escola.Evento.Publicador;

interface

uses
   System.Generics.Collections,
   Escola.Evento,
   Escola.Evento.Ouvinte;

type
   TEventoPublicador = class abstract
   protected
      FListaOuvinte : TList<TEventoOuvinte>;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Adicionar(pOuvinte : TEventoOuvinte);
      procedure Publicar(pEvento : TEvento);
   end;

implementation

{ TEventoPublicador }

constructor TEventoPublicador.Create;
begin
   FListaOuvinte := TList<TEventoOuvinte>.Create;
end;

destructor TEventoPublicador.Destroy;
begin
   FListaOuvinte.Destroy;
   inherited;
end;

procedure TEventoPublicador.Adicionar(pOuvinte: TEventoOuvinte);
begin
   FListaOuvinte.Add(pOuvinte)
end;

procedure TEventoPublicador.Publicar(pEvento: TEvento);
var lOuvinte: TEventoOuvinte;
begin
   for lOuvinte in FListaOuvinte do
      lOuvinte.Processar(pEvento);
end;

end.
