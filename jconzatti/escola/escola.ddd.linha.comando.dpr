program escola.ddd.linha.comando;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Classes,
  Escola.Aluno.Dado in 'fonte\dominio\aluno\Escola.Aluno.Dado.pas',
  Escola.Aluno in 'fonte\dominio\aluno\Escola.Aluno.pas',
  Escola.CPF.Excecao in 'fonte\dominio\aluno\Escola.CPF.Excecao.pas',
  Escola.CPF in 'fonte\dominio\aluno\Escola.CPF.pas',
  Escola.Email.Excecao in 'fonte\dominio\aluno\Escola.Email.Excecao.pas',
  Escola.Email in 'fonte\dominio\aluno\Escola.Email.pas',
  Escola.Telefone.Excecao in 'fonte\dominio\aluno\Escola.Telefone.Excecao.pas',
  Escola.Telefone in 'fonte\dominio\aluno\Escola.Telefone.pas',
  Escola.Indicacao in 'fonte\dominio\indicacao\Escola.Indicacao.pas',
  Escola.Aluno.Repositorio in 'fonte\dominio\aluno\Escola.Aluno.Repositorio.pas',
  Escola.Aluno.Repositorio.FireDAC in 'fonte\infra\aluno\Escola.Aluno.Repositorio.FireDAC.pas',
  Escola.Aluno.Repositorio.Excecao in 'fonte\dominio\aluno\Escola.Aluno.Repositorio.Excecao.pas',
  Escola.Aluno.Repositorio.Memoria in 'fonte\infra\aluno\Escola.Aluno.Repositorio.Memoria.pas',
  Escola.Senha.Cifrador in 'fonte\dominio\aluno\Escola.Senha.Cifrador.pas',
  Escola.Senha.Cifrador.SHA256.Indy in 'fonte\infra\aluno\Escola.Senha.Cifrador.SHA256.Indy.pas',
  Escola.Indicacao.Enviador.Email in 'fonte\aplicacao\indicacao\Escola.Indicacao.Enviador.Email.pas',
  Escola.Indicacao.Enviador.Email.SMTP.Indy in 'fonte\infra\indicacao\Escola.Indicacao.Enviador.Email.SMTP.Indy.pas',
  Escola.Aluno.Matriculador in 'fonte\aplicacao\aluno\Escola.Aluno.Matriculador.pas',
  Escola.Aluno.Matriculador.Apresentacao.LinhaComando in 'fonte\infra\aluno\Escola.Aluno.Matriculador.Apresentacao.LinhaComando.pas',
  Escola.Aluno.Excecao in 'fonte\dominio\aluno\Escola.Aluno.Excecao.pas';

var lAlunoRepositorioMemoria : TAlunoRepositorioMemoria;
    lAlunoMatriculadorApresentacaoLinhaComando : TAlunoMatriculadorApresentacaoLinhaComando;
begin
   try
      lAlunoRepositorioMemoria := TAlunoRepositorioMemoria.Create;
      try
         lAlunoMatriculadorApresentacaoLinhaComando := TAlunoMatriculadorApresentacaoLinhaComando.Create(lAlunoRepositorioMemoria);
         try
            lAlunoMatriculadorApresentacaoLinhaComando.Matricular;
         finally
            lAlunoMatriculadorApresentacaoLinhaComando.Destroy;
         end;
      finally
         lAlunoRepositorioMemoria.Destroy;
      end;
   except
      on E: Exception do
         Writeln(E.ClassName, ': ', E.Message);
   end;
   Readln;
end.
