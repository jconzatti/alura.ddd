unit Escola.Evento.Ouvinte.SeloAlunoNovato;

interface

uses
   System.Generics.Collections,
   Escola.Evento.Ouvinte,
   Escola.Evento,
   Escola.Evento.Tipo,
   Escola.Selo,
   Escola.Selo.Dado,
   Escola.Selo.Repositorio;

type
   TEventoOuvinteSeloAlunoNovato = class(TEventoOuvinte)
   private
      FSeloRepositorio : TSeloRepositorio;
   protected
      procedure ReagirAo(pEvento : TEvento); override;
      function DeveProcessar(pEvento : TEvento): Boolean; override;
   public
      constructor Create(pSeloRepositorio : TSeloRepositorio); reintroduce;
   end;

implementation

{ TEventoOuvinteSeloAlunoNovato }

constructor TEventoOuvinteSeloAlunoNovato.Create(pSeloRepositorio: TSeloRepositorio);
begin
   FSeloRepositorio := pSeloRepositorio;
end;

procedure TEventoOuvinteSeloAlunoNovato.ReagirAo(pEvento: TEvento);
var lMapaInformacao : TDictionary<String,String>;
    lSeloDado : TSeloDado;
    lSelo : TSelo;
begin
   inherited;
   lMapaInformacao := pEvento.MapaInformacao;
   try
      lSeloDado.CPFAluno := lMapaInformacao.Items['aluno.cpf'];
      lSeloDado.Titulo   := 'Aluno novato';
      lSeloDado.Descricao:= 'Novo aluno matriculado';
      lSelo := TSelo.Create(lSeloDado);
      try
         FSeloRepositorio.Adicionar(lSelo);
      finally
         lSelo.Destroy;
      end;
   finally
      lMapaInformacao.Destroy;
   end;
end;

function TEventoOuvinteSeloAlunoNovato.DeveProcessar(pEvento: TEvento): Boolean;
begin
   Result := pEvento.Tipo = etAlunoMatriculado;
end;

end.
