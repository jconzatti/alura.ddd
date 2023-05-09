unit Escola.Indicacao.Enviador.Email;

interface

uses
   Escola.Aluno;

type
   TIndicacaoEnviadorEmail = class abstract
   public
      procedure EnviarPara(pAluno: TAluno); virtual; abstract;
   end;

implementation

end.
