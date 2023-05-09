unit Escola.Selo.Repositorio.Excecao;

interface

uses
   System.SysUtils;

type
   ESeloNaoEncontradoPorTitulo = class(Exception)
   public
      constructor Create(pTitulo : String); reintroduce;
   end;

implementation

{ ESeloNaoEncontradoPorTitulo }

constructor ESeloNaoEncontradoPorTitulo.Create(pTitulo: String);
begin
   inherited Create(Format('Não encontrado selo com título %s!', [pTitulo]));
end;

end.
