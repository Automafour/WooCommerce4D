unit WooCommerce4D.HttpClient.RestHttpClient;

interface

uses
  WooCommerce4D.HttpClient.Interfaces,
  WooCommerce4D.Model.DTO.Interfaces,
  REST.Types,
  REST.Client,
  REST.Authenticator.Basic,
  REST.Authenticator.OAuth,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  Data.DB,
  DataSet.Serialize,
  System.Generics.Collections,
  SysUtils, WooCommerce4D.Types;

type
  TRestHttpClient = class(TInterfacedObject, iHttpClient)
    private
      FRestClient: TRESTClient;
      FRestRequest: TRESTRequest;
      FRestResponse: TRESTResponse;
      FAuthenticator : TCustomAuthenticator;

      FListaParams : TDictionary<String,String>;
      FBody : String;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iHttpClient;
      function Authentication(aAuthType: TAuthType; aUserName, aPassword : String) : ihttpClient;
      function Get(Url : String) : ihttpClient;
      function GetAll(Url : String) : ihttpClient;
      function Post(Url : String) : ihttpClient;
      function Put(Url : String) : ihttpClient;
      function Delete(Url : String)  : ihttpClient;
      function Params(aKey: String; aValue : String) : ihttpClient;
      function Body(Value : iEntity) : ihttpClient;
      function DataSet(Value : TDataSet) : ihttpClient;
      function Content : String;
      function StatusCode: integer;
      function TotalPaginas: integer;
  end;

implementation

function TRestHttpClient.Authentication(aAuthType: TAuthType; aUserName, aPassword : String) : ihttpClient;
var
  LSignatureMethod: TOAuth1SignatureMethod;
begin
  Result := Self;
  case aAuthType of
    BASIC_AUTH:
      FAuthenticator := THTTPBasicAuthenticator.Create(aUserName, aPassword);
    OAUTH_1:
      begin
        FAuthenticator := TOAuth1Authenticator.Create(nil);
        TOAuth1Authenticator(FAuthenticator).ConsumerKey := aUserName;
        TOAuth1Authenticator(FAuthenticator).ConsumerSecret := aPassword;
      end;
  end;
end;

function TRestHttpClient.Body(Value: iEntity): ihttpClient;
begin
  Result := Self;
  FBody := Value.Content;
end;

function TRestHttpClient.Content: String;
begin
  Result := FRestResponse.Content;
end;

constructor TRestHttpClient.Create;
begin
  FListaParams := TDictionary<String,String>.Create;
end;

function TRestHttpClient.DataSet(Value: TDataSet): ihttpClient;
begin
  Result := Self;
  Value.LoadFromJSON(FRestResponse.Content);
end;

function TRestHttpClient.Delete(Url: String): ihttpClient;
begin
  Result := Self;
  FRestClient.BaseURL := url;
end;

destructor TRestHttpClient.Destroy;
begin
  FListaParams.Free;
  FRestRequest.Free;
  FRestResponse.Free;
  FRestClient.Free;
  FAuthenticator.Free;
  inherited;
end;

function TRestHttpClient.Get(Url: String): ihttpClient;
begin
  Result := self;
  FRestClient := TRESTClient.Create(Url);
  FRestClient.Accept :=
    'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestClient.AcceptEncoding := '';
  FRestClient.AutoCreateParams := true;
  FRestClient.Authenticator := FAuthenticator;
  FRestClient.AllowCookies := true;
  FRestClient.BaseURL := Url;
  FRestClient.ContentType := '';
  FRestClient.FallbackCharsetEncoding := 'utf-8';
  FRestClient.HandleRedirects := true;

  FRestResponse := TRESTResponse.Create(FRestClient);
  FRestResponse.ContentType := 'application/json';

  FRestRequest := TRESTRequest.Create(FRestClient);
  FRestRequest.Accept :=
    'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestRequest.AcceptEncoding := '';
  FRestRequest.AutoCreateParams := true;
  FRestRequest.Client := FRestClient;
  FRestRequest.Method := rmGET;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.Response := FRestResponse;

  FRestRequest.Execute;
end;

function TRestHttpClient.GetAll(Url: String): ihttpClient;
var
  key : String;
  I : integer;
begin
  result := Self;
  FRestClient := TRESTClient.Create(Url);
  FRestClient.Accept :=
    'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestClient.AcceptEncoding := '';
  FRestClient.AutoCreateParams := true;
  FRestClient.AllowCookies := true;
  FRestClient.Authenticator := FAuthenticator;
  FRestClient.BaseURL := Url;
  FRestClient.ContentType := '';
  FRestClient.FallbackCharsetEncoding := 'utf-8';
  FRestClient.HandleRedirects := true;

  FRestResponse := TRESTResponse.Create(FRestClient);
  FRestResponse.ContentType := 'application/json';

  FRestRequest := TRESTRequest.Create(FRestClient);
  FRestRequest.Accept :=
    'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestRequest.AcceptEncoding := '';
  FRestRequest.AutoCreateParams := true;
  FRestRequest.Client := FRestClient;
  FRestRequest.Method := rmGET;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.Response := FRestResponse;
  for Key in FListaParams.Keys do
    FRestRequest.Params.AddItem(key,FListaParams.Items[key]);

  FRestRequest.Execute;
end;

class function TRestHttpClient.New : iHttpClient;
begin
  Result := Self.Create;
end;

function TRestHttpClient.Params(aKey: String; aValue : String) : ihttpClient;
begin
  result:=self;
  FListaParams.Add(akey, aValue);
end;

function TRestHttpClient.Post(Url: String): ihttpClient;
begin
  result :=self;
  FRestClient := TRESTClient.Create(Url);
  FRestClient.Accept :=
    'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestClient.AcceptEncoding := '';
  FRestClient.AutoCreateParams := true;
  FRestClient.AllowCookies := true;
  FRestClient.Authenticator := FAuthenticator;
  FRestClient.BaseURL := Url;
  FRestClient.ContentType := '';
  FRestClient.FallbackCharsetEncoding := 'utf-8';
  FRestClient.HandleRedirects := true;

  FRestResponse := TRESTResponse.Create(FRestClient);
  FRestResponse.ContentType := 'application/json';

  FRestRequest := TRESTRequest.Create(FRestClient);
  FRestRequest.Accept :=
    'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestRequest.AcceptEncoding := '';
  FRestRequest.AutoCreateParams := true;
  FRestRequest.Client := FRestClient;
  FRestRequest.Method := rmPOST;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.Response := FRestResponse;

  FRestRequest.Params.Add;
  FRestRequest.Params[0].ContentType := ctAPPLICATION_JSON;
  FRestRequest.Params[0].Kind := pkREQUESTBODY;
  FRestRequest.Params[0].Name := 'body';
  FRestRequest.Params[0].Value := FBody;
  FRestRequest.Params[0].Options := [poDoNotEncode];

  FRestRequest.Execute;
end;

function TRestHttpClient.Put(Url: String): ihttpClient;
begin
  result :=self;
  FRestClient := TRESTClient.Create(Url);
  FRestClient.Accept :=
    'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestClient.AcceptEncoding := '';
  FRestClient.AutoCreateParams := true;
  FRestClient.AllowCookies := true;
  FRestClient.Authenticator := FAuthenticator;
  FRestClient.BaseURL := Url;
  FRestClient.ContentType := '';
  FRestClient.FallbackCharsetEncoding := 'utf-8';
  FRestClient.HandleRedirects := true;

  FRestResponse := TRESTResponse.Create(FRestClient);
  FRestResponse.ContentType := 'application/json';

  FRestRequest := TRESTRequest.Create(FRestClient);
  FRestRequest.Accept :=
    'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestRequest.AcceptEncoding := '';
  FRestRequest.AutoCreateParams := true;
  FRestRequest.Client := FRestClient;
  FRestRequest.Method := rmPUT;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.Response := FRestResponse;

  FRestRequest.Params.Add;
  FRestRequest.Params[0].ContentType := ctAPPLICATION_JSON;
  FRestRequest.Params[0].Kind := pkREQUESTBODY;
  FRestRequest.Params[0].Name := 'body';
  FRestRequest.Params[0].Value := FBody;
  FRestRequest.Params[0].Options := [poDoNotEncode];

  FRestRequest.Execute;
end;

function TRestHttpClient.StatusCode: integer;
begin
  Result := FRestResponse.StatusCode;
end;

function TRestHttpClient.TotalPaginas: integer;
var
  i: integer;
  LHeader: string;
begin
  Result := 1;
  for I := 0 to Pred(FRestResponse.Headers.Count) do
    if Lowercase(FRestResponse.Headers.KeyNames[i]) = 'x-wp-totalpages' then
    begin
      Result := StrToIntDef(FRestResponse.Headers.ValueFromIndex[i],0);
      Exit;
    end;
end;

end.
