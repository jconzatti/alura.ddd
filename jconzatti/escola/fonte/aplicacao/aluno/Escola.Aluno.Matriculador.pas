unit Escola.Aluno.Matriculador;

interface

uses
   Escola.Aluno.Dado,
   Escola.Aluno.Repositorio,
   Escola.Aluno;

type
   TAlunoMatriculador = class
   private
      FAlunoRepositorio : TAlunoRepositorio;
   public
      constructor Create(pAlunoRepositorio : TAlunoRepositorio);
      procedure Matricular(pAlunoDado : TAlunoDado);
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
   finally
      lAluno.Destroy;
   end;
end;

end.
