unit Escola.Indicacao;

interface

uses
   System.SysUtils,
   Escola.Aluno;

type
   TInicacao = class
   private
      FIndicado  : TAluno;
      FIndicante : TAluno;
      FData:      TDate;
   public
      constructor Create(pIndicado, pIndicante: TAluno);
      property Indicado: TAluno read FIndicado;
      property Indicante: TAluno read FIndicante;
      property Data: TDate read FData;
   end;

implementation

{ TInicacao }

constructor TInicacao.Create(pIndicado, pIndicante: TAluno);
begin
   FIndicado  := pIndicado;
   FIndicante := pIndicante;
   FData      := Date;
end;

end.
