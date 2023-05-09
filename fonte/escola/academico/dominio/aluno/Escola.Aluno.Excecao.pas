unit Escola.Aluno.Excecao;

interface

uses
   System.SysUtils;

type
   EAlunoQuantidadeTelefoneExcedido = class(EArgumentException)
   public
      constructor Create(pQtdMaximaTelefone : Integer); reintroduce;
   end;

implementation

{ EAlunoQuantidadeTelefoneExcedido }

constructor EAlunoQuantidadeTelefoneExcedido.Create(pQtdMaximaTelefone : Integer);
begin
   inherited Create(Format('Aluno não pode ter mais que %d telefones!', [pQtdMaximaTelefone]));
end;

end.
