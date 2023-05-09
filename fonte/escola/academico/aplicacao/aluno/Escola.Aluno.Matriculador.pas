unit Escola.Aluno.Matriculador;

interface

uses
   System.SysUtils,
   Escola.Aluno.Dado,
   Escola.Aluno.Repositorio,
   Escola.Aluno,
   Escola.Evento.AlunoMatriculado,
   Escola.Evento.Publicador;

type
   TAlunoMatriculador = class
   private
      FAlunoRepositorio : TAlunoRepositorio;
      FEventoPublicador : TEventoPublicador;
      procedure DispararEventoDeAlunoMatriculado(pAluno : TAluno);
   public
      constructor Create(pAlunoRepositorio : TAlunoRepositorio);
      procedure Matricular(pAlunoDado : TAlunoDado);
      property EventoPublicador: TEventoPublicador read FEventoPublicador write FEventoPublicador;
   end;

implementation

{ TAlunoMatriculador }

constructor TAlunoMatriculador.Create(pAlunoRepositorio: TAlunoRepositorio);
begin
   FAlunoRepositorio := pAlunoRepositorio;
end;

procedure TAlunoMatriculador.Matricular(pAlunoDado: TAlunoDado);
var lAluno : TAluno;
begin
   lAluno := TAluno.Create(pAlunoDado);
   try
      FAlunoRepositorio.Matricular(lAluno);
      DispararEventoDeAlunoMatriculado(lAluno);
   finally
      lAluno.Destroy;
   end;
end;

procedure TAlunoMatriculador.DispararEventoDeAlunoMatriculado(pAluno : TAluno);
var lEventoAlunoMatriculado : TEventoAlunoMatriculado;
begin
   if Assigned(FEventoPublicador) then
   begin
      lEventoAlunoMatriculado := TEventoAlunoMatriculado.Create(pAluno.CPF);
      try
         FEventoPublicador.Publicar(lEventoAlunoMatriculado);
      finally
         lEventoAlunoMatriculado.Destroy;
      end;
   end;
end;

end.
