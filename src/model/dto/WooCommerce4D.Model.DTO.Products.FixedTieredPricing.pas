unit WooCommerce4D.Model.DTO.Products.FixedTieredPricing;

interface

uses
  WooCommerce4D.Model.DTO.Interfaces,
  System.JSON;

type
  TModelFixedTieredPriceDTO<T: IInterface> = class(TInterfacedObject,
    iModelFixedTieredPriceDTO<T>)
  private
    [weak]
    FParent: T;
    FJSON: TJSONObject;
    FJSONPair: TJSONObject;
  public
    constructor Create(Parent: T; JSON: TJSONObject);
    destructor Destroy; override;
    class function New(Parent: T; JSON: TJSONObject)
      : iModelFixedTieredPriceDTO<T>;
    function Rule(Quantity: Integer; Value: Currency)
      : iModelFixedTieredPriceDTO<T>;
    function &End: T;
  end;

implementation

uses
  System.SysUtils;

{ TModelFixedTieredPriceDTO<T> }

constructor TModelFixedTieredPriceDTO<T>.Create(Parent: T; JSON: TJSONObject);
begin
  FParent := Parent;
  FJSON := TJSONObject.Create;
  FJSONPair := JSON;
end;

destructor TModelFixedTieredPriceDTO<T>.Destroy;
begin

  inherited;
end;

function TModelFixedTieredPriceDTO<T>.&End: T;
begin
  Result := FParent;
  FJSONPair.AddPair('tiered_pricing_fixed_rules',FJSON);
end;

class function TModelFixedTieredPriceDTO<T>.New(Parent: T;
  JSON: TJSONObject): iModelFixedTieredPriceDTO<T>;
begin
  Result := Self.Create(Parent, JSON);
end;

function TModelFixedTieredPriceDTO<T>.Rule(Quantity: Integer;
  Value: Currency): iModelFixedTieredPriceDTO<T>;
begin
  Result := Self;
  FJSON.AddPair(IntToStr(Quantity), TJSONNumber.Create(Value));
end;

end.
