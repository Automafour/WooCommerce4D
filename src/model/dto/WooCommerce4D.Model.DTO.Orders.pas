unit WooCommerce4D.Model.DTO.Orders;

interface

uses
  JSON,
  WooCommerce4D.Model.DTO.Interfaces,
  WooCommerce4D.Types,
  WooCommerce4D.Model.DTO.Billing,
  WooCommerce4D.Model.DTO.MetaData,
  WooCommerce4D.Model.DTO.Shipping,
  WooCommerce4D.Model.DTO.CouponsLines,
  WooCommerce4D.Model.DTO.FreeLines,
  WooCommerce4D.Model.DTO.LinesItems,
  WooCommerce4D.Model.DTO.ShippingLines;

type
  TModelOrdersDTO = class(TInterfacedObject, iModelOrdersDTO)
    private
      [weak]
      FParent : iEntity;
      FJson : TJSONObject;
    public
      constructor Create(Parent : iEntity);
      destructor Destroy; override;
      class function New(Parent : iEntity): iModelOrdersDTO;
      function ParentId(Value: Integer): iModelOrdersDTO;
      function Status(Value: TStatusType = PENDING): iModelOrdersDTO; Overload; // Default pending
      function Status(Value: string): iModelOrdersDTO; Overload;// Default pending
      function Currency(Value: TOrderCurrency = USD): iModelOrdersDTO; // Default USD
      function CustomerId(Value: Integer): iModelOrdersDTO;
      function CustomerNote(Value: String): iModelOrdersDTO;
      function Billing: iModelBillingDTO<iModelOrdersDTO>;
      function Shipping: iModelShippingDTO<iModelOrdersDTO>;
      function PaymentMethod(Value: String): iModelOrdersDTO;
      function PaymentMethodTitle(Value: String): iModelOrdersDTO;
      function TransactionId(Value: String): iModelOrdersDTO;
      function CorreiosTrackingCode(Value: string): iModelOrdersDTO;
      function CarryingName(Value : String) : iModelOrdersDTO; //Custom field proprio
      function TrackingURL(Value : String) : iModelOrdersDTO; //Custom field proprio
      function MetaData: iModelMetaDataDTO<iModelOrdersDTO>;
      function LineItems: iModelLinesItemsDTO<iModelOrdersDTO>;
      function ShippingLines: iModelShippingLinesDTO<iModelOrdersDTO>;
      function FreeLines: iModelFreeLinesDTO<iModelOrdersDTO>;
      function CouponLines: iModelCouponsLinesDTO<iModelOrdersDTO>;
      function &End : iEntity;
  end;

implementation

function TModelOrdersDTO.Billing: iModelBillingDTO<iModelOrdersDTO>;
begin
  Result := TModelBillingDTO<iModelOrdersDTO>.New(Self);
end;

function TModelOrdersDTO.CarryingName(Value: String): iModelOrdersDTO;
begin
  Result := Self;
  FJson.AddPair('carrying_name',Value);
end;

function TModelOrdersDTO.CorreiosTrackingCode(Value: string): iModelOrdersDTO;
begin
  Result := Self;
  FJson.AddPair('correios_tracking_code',Value);
end;

function TModelOrdersDTO.CouponLines: iModelCouponsLinesDTO<iModelOrdersDTO>;
begin
  Result := TModelCouponsLines<iModelOrdersDTO>.New(Self);
end;

function TModelOrdersDTO.&End: iEntity;
begin
  Result := FParent.Content(FJSON.ToJSON);
end;

constructor TModelOrdersDTO.Create(Parent : iEntity);
begin
  FJson := TJSONObject.Create;
  FParent := Parent;
end;

function TModelOrdersDTO.Currency(Value: TOrderCurrency): iModelOrdersDTO;
begin
  Result := Self;
  FJson.AddPair('currency',Value.GetValue);
end;

function TModelOrdersDTO.CustomerId(Value: Integer): iModelOrdersDTO;
begin
  Result := Self;
  FJson.AddPair('customer_id',TJSONNumber.Create(Value));
end;

function TModelOrdersDTO.CustomerNote(Value: String): iModelOrdersDTO;
begin
  Result := Self;
  FJson.AddPair('customer_note',Value);
end;

destructor TModelOrdersDTO.Destroy;
begin
  FJson.Free;
  inherited;
end;

function TModelOrdersDTO.FreeLines: iModelFreeLinesDTO<iModelOrdersDTO>;
begin
  Result := TModelFreeLinesDTO<iModelOrdersDTO>.New(Self);
end;

function TModelOrdersDTO.LineItems: iModelLinesItemsDTO<iModelOrdersDTO>;
begin
  Result := TModelLinesItemsDTO<iModelOrdersDTO>.New(Self);
end;

function TModelOrdersDTO.MetaData: iModelMetaDataDTO<iModelOrdersDTO>;
begin
  Result := TModelMetaDataDTO<iModelOrdersDTO>.New(Self);
end;

class function TModelOrdersDTO.New (Parent : iEntity): iModelOrdersDTO;
begin
  Result := Self.Create(Parent);
end;

function TModelOrdersDTO.ParentId(Value: Integer): iModelOrdersDTO;
begin
  Result := Self;
  FJson.AddPair('parent_id',TJSONNumber.Create(Value));
end;

function TModelOrdersDTO.PaymentMethod(Value: String): iModelOrdersDTO;
begin
  Result := Self;
  FJson.AddPair('payment_method',Value);
end;

function TModelOrdersDTO.PaymentMethodTitle(Value: String): iModelOrdersDTO;
begin
  Result := Self;
  FJson.AddPair('payment_method_title',Value);
end;

function TModelOrdersDTO.Shipping: iModelShippingDTO<iModelOrdersDTO>;
begin
  Result := TModelShippingDTO<iModelOrdersDTO>.New(Self);
end;

function TModelOrdersDTO.ShippingLines: iModelShippingLinesDTO<iModelOrdersDTO>;
begin
  Result := TModelShippingLinesDTO<iModelOrdersDTO>.New(Self);
end;

function TModelOrdersDTO.Status(Value: string): iModelOrdersDTO;
begin
  Result := Self;
  FJson.AddPair('status',Value);
end;

function TModelOrdersDTO.Status(Value: TStatusType): iModelOrdersDTO;
begin
  Result := Self;
  FJson.AddPair('status',Value.GetValue);
end;

function TModelOrdersDTO.TrackingURL(Value: String): iModelOrdersDTO;
begin
  Result := Self;
  FJson.AddPair('tracking_url',Value);
end;

function TModelOrdersDTO.TransactionId(Value: String): iModelOrdersDTO;
begin
  Result := Self;
  FJson.AddPair('transaction_id',Value);
end;

end.
