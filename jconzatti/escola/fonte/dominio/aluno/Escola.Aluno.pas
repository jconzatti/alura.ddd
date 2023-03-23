unit Escola.Aluno;

interface

uses
   System.Generics.Collections,
   Escola.Email,
   Escola.CPF,
   Escola.Telefone,
   Escola.Aluno.Dado,
   Escola.Aluno.Excecao;

type
   TAluno = class
   private
      FCPF: TCPF;
      FNome: String;
      FEmail: TEmail;
      FListaTelefone: TObjectList<TTelefone>;
      FSenha: String;
   public
      constructor Create(pDado : TAlunoDado); reintroduce;
      destructor Destroy; override;
      procedure AdicionarTelefone(pDDD, pNumero : String);
      property CPF: TCPF read FCPF;
      property Nome: String read FNome;
      property Email: TEmail read FEmail;
      property ListaTelefone : TObjectList<TTelefone> read FListaTelefone;
      property Senha: String read FSenha write FSenha;
   end;

implementation

{ TAluno }

constructor TAluno.Create(pDado : TAlunoDado);
begin
   FCPF := TCPF.Create(pDado.CPF);
   FEmail := TEmail.Create(pDado.Email);
   FListaTelefone := TObjectList<TTelefone>.Create;
   FNome := pDado.Nome;
end;

destructor TAluno.Destroy;
begin
   if Assigned(FListaTelefone) then
      FListaTelefone.Destroy;

   if Assigned(FEmail) then
      FEmail.Destroy;

   if Assigned(FCPF) then
      FCPF.Destroy;

   inherited;
end;

procedure TAluno.AdicionarTelefone(pDDD, pNumero: String);
begin
   if FListaTelefone.Count >= 2 then
      raise EAlunoQuantidadeTelefoneExcedido.Create('Aluno não pode ter mais que 2 telefones!');
   FListaTelefone.Add(TTelefone.Create(pDDD, pNumero));
end;

end.
