unit WooCommerce4D.HttpClient.Interfaces;

interface

uses
  System.Generics.Collections,
  Data.DB,
  WooCommerce4D.Types, WooCommerce4D.Model.DTO.Interfaces;

type
  iHttpClient = interface
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
  end;

  iWooCommerce = interface
    function _Create(endpointBase : TEndpointBaseType) : iWooCommerce; overload;
    function _Create(endpointBase : String) : iWooCommerce; overload;
    function Get(endpointBase: TEndpointBaseType; Id: Integer): iWooCommerce; Overload;
    function Get(endpointBase: string; Id: Integer): iWooCommerce; Overload;
    function GetAll(endpointBase: TEndpointBaseType): iWooCommerce; Overload;
    function GetAll(endpointBase: string): iWooCommerce; Overload;
    function Update(endpointBase: TEndpointBaseType; Id: Integer): iWooCommerce; Overload;
    function Update(endpointBase: string; Id: Integer): iWooCommerce; Overload;
    function Delete(endpointBase: TEndpointBaseType; Id: Integer): iWooCommerce; Overload;
    function Delete(endpointBase: string; Id: Integer): iWooCommerce; Overload;
    function Batch(endpointBase : TEndpointBaseType) : iWooCommerce;
    function Params(aKey: String; aValue : String) : iWooCommerce;
    function Body(Value : iEntity) : iWooCommerce;
    function DataSet(Value : TDataSet) : iWooCommerce;
    function Content : String;
    function StatusCode: integer;
  end;

implementation

end.
