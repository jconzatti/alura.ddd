unit Escola.Indicacao.Enviador.Email.SMTP.Indy;

interface

uses
   Escola.Aluno,
   Escola.Indicacao.Enviador.Email,
   IdSMTP,
   IdMessage,
   IdExplicitTLSClientServerBase,
   IdSSLOpenSSL;

type
   TIndicacaoEnviadorEmailSMTPIndy = class(TIndicacaoEnviadorEmail)
   private
      FIdSMTP: TIdSMTP;
      FIdMessage: TIdMessage;
   public
      constructor Create;
      destructor Destroy; override;
      procedure EnviarPara(pAluno: TAluno); override;
   end;

implementation

{ TIndicacaoEnviadorEmailSMTPIndy }

constructor TIndicacaoEnviadorEmailSMTPIndy.Create;
begin
   FIdSMTP    := TIdSMTP.Create(nil);
   FIdMessage := TIdMessage.Create(nil);
end;

destructor TIndicacaoEnviadorEmailSMTPIndy.Destroy;
begin
   FIdMessage.Destroy;
   FIdSMTP.Destroy;
   inherited;
end;

procedure TIndicacaoEnviadorEmailSMTPIndy.EnviarPara(pAluno: TAluno);
begin
   inherited;
   try
      FIdSMTP.Host           := 'smtp.gmail.com';
      FIdSMTP.Port           := 465;
      FIdSMTP.Username       := 'jhoni.conzatti@gmail.com';
      FIdSMTP.Password       := 'minha-senha';
      FIdSMTP.ConnectTimeout := 30000;
      FIdSMTP.ReadTimeout    := 30000;

      FIdSMTP.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
      TIdSSLIOHandlerSocketOpenSSL(FIdSMTP.IOHandler).SSLOptions.Method := sslvTLSv1_2;
      TIdSSLIOHandlerSocketOpenSSL(FIdSMTP.IOHandler).SSLOptions.Mode   := sslmUnassigned;

      FIdSMTP.UseTLS := utUseImplicitTLS;

      FIdMessage.From.Address := 'jhoni.conzatti@gmail.com';
      FIdMessage.Recipients.Add.Address := pAluno.Email.Valor;
      FIdMessage.Subject      := pAluno.Nome+ ', você foi indicado!';
      FIdMessage.Body.Text    := 'Olá '+pAluno.Nome+', você foi indicado na nossa escola! Matricule-se e garanta sua vaga! Confira condições imperdíveis!';

      FIdSMTP.Connect;
      FIdSMTP.Send(FIdMessage);
   finally
      FIdSMTP.Disconnect;
   end;
end;

end.
