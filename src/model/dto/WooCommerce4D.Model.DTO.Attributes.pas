unit WooCommerce4D.Model.DTO.Attributes;

interface

uses
  JSON,
  WooCommerce4D.Model.DTO.Interfaces;

type
  TModelAttributesDTO<T : IInterface> = class(TInterfacedObject, iModelAttributesDTO<T>)
    private
      [weak]
      FParent : T;
      FJSON : TJSONObject;
      FJSONArray : TJSONArray;
      FJSONPair : TJSONObject;
    public
      constructor Create(Parent: T; JSON : TJSONObject);
      destructor Destroy; override;
      class function New(Parent: T; JSON : TJSONObject) : iModelAttributesDTO<T>;
      function id(Value : Integer) : iModelAttributesDTO<T>;
      function Name(Value : String) : iModelAttributesDTO<T>;
      function Position(Value : integer) : iModelAttributesDTO<T>;
      function Visible(Value : Boolean = false) : iModelAttributesDTO<T>;
      function Variation(Value : Boolean = false) : iModelAttributesDTO<T>;
      function Options(Value : TArray<string>) : iModelAttributesDTO<T>;
      function Next: iModelAttributesDTO<T>;
      function &End : T;
  end;

implementation

function TModelAttributesDTO<T>.&End: T;
begin
  Result := FParent;
  FJSONArray.AddElement(FJSON);
  FJSONPair.AddPair('attributes',FJSONArray);
end;

constructor TModelAttributesDTO<T>.Create(Parent: T; JSON : TJSONObject);
begin
  FParent := Parent;
  FJSON := TJSONObject.Create;
  FJSONArray := TJSONArray.Create;
  FJSONPair := JSON;
end;

destructor TModelAttributesDTO<T>.Destroy;
begin
//  FJson.Free;
  inherited;
end;

function TModelAttributesDTO<T>.id(Value: Integer): iModelAttributesDTO<T>;
begin
  Result := Self;
  FJSON.AddPair('id',TJSONNumber.Create(value));
end;

function TModelAttributesDTO<T>.Name(Value: String): iModelAttributesDTO<T>;
begin
  Result := Self;
  FJSON.AddPair('name',value);
end;

class function TModelAttributesDTO<T>.New(Parent: T; JSON : TJSONObject) : iModelAttributesDTO<T>;
begin
  Result := Self.Create(Parent, JSON);
end;

function TModelAttributesDTO<T>.Next: iModelAttributesDTO<T>;
begin
  Result := Self;
  FJSONArray.AddElement(FJSON);
  FJSON := TJSONObject.Create;
end;

function TModelAttributesDTO<T>.Options(Value : TArray<string>): iModelAttributesDTO<T>;
var
  JSONArray: TJSONArray;
  Option: string;
begin
  Result := Self;
  JSONArray := TJSONArray.Create;
  // Preenchendo o JSONArray com as strings do array de Options
  for Option in Value do
    JSONArray.Add(Option);
  FJSON.AddPair('options',JSONArray);
end;

function TModelAttributesDTO<T>.Position(
  Value: integer): iModelAttributesDTO<T>;
begin
  Result := Self;
  FJSON.AddPair('position',TJSONNumber.Create(value));
end;

function TModelAttributesDTO<T>.Variation(
  Value: Boolean): iModelAttributesDTO<T>;
begin
  Result := Self;
  FJSON.AddPair('variation',TJSONBool.Create(value));
end;

function TModelAttributesDTO<T>.Visible(Value: Boolean): iModelAttributesDTO<T>;
begin
  Result := Self;
  FJSON.AddPair('visible',TJSONBool.Create(value));
end;

end.
