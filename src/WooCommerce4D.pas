unit WooCommerce4D;

interface

uses
  WooCommerce4D.oAuth.oAuthConfig,
  WooCommerce4D.oAuth.Interfaces;

type
  iWooCommerce4D = interface
    function Config : iOAuthConfig;
  end;

  TWooCommerce4D = class(TInterfacedObject, iWooCommerce4D)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iWooCommerce4D;
      function Config : iOAuthConfig;
  end;

implementation

function TWooCommerce4D.Config: iOAuthConfig;
begin
  Result := ToAuthConfig.New;
end;

constructor TWooCommerce4D.Create;
begin

end;

destructor TWooCommerce4D.Destroy;
begin

  inherited;
end;

class function TWooCommerce4D.New : iWooCommerce4D;
begin
  Result := Self.Create;
end;

end.
