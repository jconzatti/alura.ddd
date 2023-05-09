unit Escola.Aluno.Repositorio.Excecao;

interface

uses
   System.SysUtils,
   Escola.CPF;

type
   EAlunoNaoEncontradoPorCPF = class(Exception)
   public
      constructor Create(pCPF : TCPF); reintroduce;
   end;

implementation

{ EAlunoNaoEncontradoPorCPF }

constructor EAlunoNaoEncontradoPorCPF.Create(pCPF: TCPF);
begin
   inherited Create(Format('Não encontrado aluno com CPF %s!', [pCPF.Valor]));
end;

end.
