program escola.ddd.linha.comando;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Classes,
  Escola.Aluno.Dado in 'escola\academico\dominio\aluno\Escola.Aluno.Dado.pas',
  Escola.Aluno in 'escola\academico\dominio\aluno\Escola.Aluno.pas',
  Escola.Email.Excecao in 'escola\academico\dominio\aluno\Escola.Email.Excecao.pas',
  Escola.Email in 'escola\academico\dominio\aluno\Escola.Email.pas',
  Escola.Telefone.Excecao in 'escola\academico\dominio\aluno\Escola.Telefone.Excecao.pas',
  Escola.Telefone in 'escola\academico\dominio\aluno\Escola.Telefone.pas',
  Escola.Indicacao in 'escola\academico\dominio\indicacao\Escola.Indicacao.pas',
  Escola.Aluno.Repositorio in 'escola\academico\dominio\aluno\Escola.Aluno.Repositorio.pas',
  Escola.Aluno.Repositorio.FireDAC in 'escola\academico\infra\aluno\Escola.Aluno.Repositorio.FireDAC.pas',
  Escola.Aluno.Repositorio.Excecao in 'escola\academico\dominio\aluno\Escola.Aluno.Repositorio.Excecao.pas',
  Escola.Aluno.Repositorio.Memoria in 'escola\academico\infra\aluno\Escola.Aluno.Repositorio.Memoria.pas',
  Escola.Senha.Cifrador in 'escola\academico\dominio\aluno\Escola.Senha.Cifrador.pas',
  Escola.Senha.Cifrador.SHA256.Indy in 'escola\academico\infra\aluno\Escola.Senha.Cifrador.SHA256.Indy.pas',
  Escola.Indicacao.Enviador.Email in 'escola\academico\aplicacao\indicacao\Escola.Indicacao.Enviador.Email.pas',
  Escola.Indicacao.Enviador.Email.SMTP.Indy in 'escola\academico\infra\indicacao\Escola.Indicacao.Enviador.Email.SMTP.Indy.pas',
  Escola.Aluno.Matriculador in 'escola\academico\aplicacao\aluno\Escola.Aluno.Matriculador.pas',
  Escola.Aluno.Excecao in 'escola\academico\dominio\aluno\Escola.Aluno.Excecao.pas',
  Escola.Selo in 'escola\gameficacao\dominio\selo\Escola.Selo.pas',
  Escola.Selo.Dado in 'escola\gameficacao\dominio\selo\Escola.Selo.Dado.pas',
  Escola.Selo.Repositorio in 'escola\gameficacao\dominio\selo\Escola.Selo.Repositorio.pas',
  Escola.Selo.Repositorio.Memoria in 'escola\gameficacao\infra\selo\Escola.Selo.Repositorio.Memoria.pas',
  Escola.Selo.Repositorio.Excecao in 'escola\gameficacao\dominio\selo\Escola.Selo.Repositorio.Excecao.pas',
  Escola.CPF.Excecao in 'escola\compartilhado\dominio\cpf\Escola.CPF.Excecao.pas',
  Escola.CPF in 'escola\compartilhado\dominio\cpf\Escola.CPF.pas',
  Escola.Evento in 'escola\compartilhado\dominio\evento\Escola.Evento.pas',
  Escola.Evento.Ouvinte in 'escola\compartilhado\dominio\evento\Escola.Evento.Ouvinte.pas',
  Escola.Evento.Publicador in 'escola\compartilhado\dominio\evento\Escola.Evento.Publicador.pas',
  Escola.Evento.AlunoMatriculado in 'escola\academico\aplicacao\aluno\Escola.Evento.AlunoMatriculado.pas',
  Escola.Evento.Ouvinte.AlunoMatriculado.Log in 'escola\academico\aplicacao\aluno\Escola.Evento.Ouvinte.AlunoMatriculado.Log.pas',
  Escola.Evento.Ouvinte.SeloAlunoNovato in 'escola\gameficacao\aplicacao\Escola.Evento.Ouvinte.SeloAlunoNovato.pas',
  Escola.Evento.Tipo in 'escola\compartilhado\dominio\evento\Escola.Evento.Tipo.pas',
  Escola.Aluno.Matriculador.Apresentacao.LinhaComando in 'escola\Escola.Aluno.Matriculador.Apresentacao.LinhaComando.pas';

var lAlunoMatriculadorApresentacaoLinhaComando : TAlunoMatriculadorApresentacaoLinhaComando;
begin
   try
      lAlunoMatriculadorApresentacaoLinhaComando := TAlunoMatriculadorApresentacaoLinhaComando.Create;
      try
         lAlunoMatriculadorApresentacaoLinhaComando.Matricular;
      finally
         lAlunoMatriculadorApresentacaoLinhaComando.Destroy;
      end;
   except
      on E: Exception do
         Writeln(E.ClassName, ': ', E.Message);
   end;
   Readln;
end.
