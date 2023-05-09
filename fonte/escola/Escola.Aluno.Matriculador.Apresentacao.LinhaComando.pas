unit Escola.Aluno.Matriculador.Apresentacao.LinhaComando;

interface

uses
   System.SysUtils,
   Escola.Aluno.Repositorio,
   Escola.Aluno.Matriculador,
   Escola.Aluno.Dado,
   Escola.Aluno.Repositorio.Memoria,
   Escola.Selo.Repositorio.Memoria,
   Escola.Evento.Ouvinte.AlunoMatriculado.Log,
   Escola.Evento.Ouvinte.SeloAlunoNovato,
   Escola.Evento.Publicador;

type
   TAlunoMatriculadorApresentacaoLinhaComando = class
   public
      procedure Matricular;
   end;

implementation

{ TAlunoMatriculadorApresentacaoLinhaComando }

procedure TAlunoMatriculadorApresentacaoLinhaComando.Matricular;
var lAlunoDado : TAlunoDado;
    lAlunoMatriculador : TAlunoMatriculador;
    lEventoOuvinteAlunoMatriculadoLog : TEventoOuvinteAlunoMatriculadoLog;
    lEventoOuvinteSeloAlunoNovato : TEventoOuvinteSeloAlunoNovato;
    lEventoPublicador : TEventoPublicador;
    lRespostaUsuario : String;
    lDesejaRealizarUmaMatrucula : Boolean;
    lAlunoRepositorioMemoria : TAlunoRepositorioMemoria;
    lSeloRepositorioMemoria : TSeloRepositorioMemoria;
begin
   Writeln('MATRÍCULA DE ALUNOS');
   lAlunoRepositorioMemoria := TAlunoRepositorioMemoria.Create;
   lSeloRepositorioMemoria := TSeloRepositorioMemoria.Create;
   try
      lAlunoMatriculador := TAlunoMatriculador.Create(lAlunoRepositorioMemoria);
      lEventoPublicador := TEventoPublicador.Create;
      lEventoOuvinteAlunoMatriculadoLog := TEventoOuvinteAlunoMatriculadoLog.Create;
      lEventoOuvinteSeloAlunoNovato := TEventoOuvinteSeloAlunoNovato.Create(lSeloRepositorioMemoria);
      try
         lEventoPublicador.Adicionar(lEventoOuvinteAlunoMatriculadoLog);
         lEventoPublicador.Adicionar(lEventoOuvinteSeloAlunoNovato);
         lAlunoMatriculador.EventoPublicador := lEventoPublicador;
         repeat
            Write('Deseja matricular um aluno? [s/n] ');
            Readln(lRespostaUsuario);
            lDesejaRealizarUmaMatrucula := (lRespostaUsuario.ToUpper = 'S')
                                        or (lRespostaUsuario.ToUpper = 'SIM');
            if lDesejaRealizarUmaMatrucula then
            begin
               Write('Nome: ');
               Readln(lAlunoDado.Nome);
               Write('CPF: ');
               Readln(lAlunoDado.CPF);
               Write('e-mail: ');
               Readln(lAlunoDado.Email);
               lAlunoMatriculador.Matricular(lAlunoDado);
            end;
         until not lDesejaRealizarUmaMatrucula;


         Writeln('FIM DA MATRÍCULA DE ALUNOS');
      finally
         lEventoOuvinteAlunoMatriculadoLog.Destroy;
         lEventoPublicador.Destroy;
         lAlunoMatriculador.Destroy;
      end;
   finally
      lSeloRepositorioMemoria.Destroy;
      lAlunoRepositorioMemoria.Destroy;
   end;
end;

end.
