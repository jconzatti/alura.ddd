unit Escola.Aluno.Repositorio.Excecao;

interface

uses
   System.SysUtils,
   Escola.CPF;

type
   EAlunoNaoEncontrado = class(Exception)
   public
      constructor Create(pCPF : TCPF);
   end;

implementation

{ EAlunoNaoEncontrado }

constructor EAlunoNaoEncontrado.Create(pCPF: TCPF);
begin
   inherited Create(Format('Não encontrado aluno com CPF %s!', [pCPF.Valor]));
end;

end.
