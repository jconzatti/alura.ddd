unit Escola.Aluno.Matriculador.Apresentacao.LinhaComando;

interface

uses
   Escola.Aluno.Repositorio,
   Escola.Aluno.Matriculador,
   Escola.Aluno.Dado;

type
   TAlunoMatriculadorApresentacaoLinhaComando = class
   private
      FAlunoRepositorio : TAlunoRepositorio;
   public
      constructor Create(pAlunoRepositorio : TAlunoRepositorio);
      procedure Matricular;
   end;

implementation

{ TAlunoMatriculadorApresentacaoLinhaComando }

constructor TAlunoMatriculadorApresentacaoLinhaComando.Create(
  pAlunoRepositorio: TAlunoRepositorio);
begin
   FAlunoRepositorio := pAlunoRepositorio;
end;

procedure TAlunoMatriculadorApresentacaoLinhaComando.Matricular;
var lAlunoDado : TAlunoDado;
    lAlunoMatriculador : TAlunoMatriculador;
begin
   Writeln('MATRÍCULA DE ALUNO');
   lAlunoMatriculador := TAlunoMatriculador.Create(FAlunoRepositorio);
   try
      Write('Nome: ');
      Readln(lAlunoDado.Nome);
      Write('CPF: ');
      Readln(lAlunoDado.CPF);
      Write('e-mail: ');
      Readln(lAlunoDado.Email);
      lAlunoMatriculador.Matricular(lAlunoDado);
   finally
      lAlunoMatriculador.Destroy;
   end;
   Writeln(lAlunoDado.Nome + ' matriculado com sucesso!');
end;

end.
