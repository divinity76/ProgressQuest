unit Web;

interface

uses
  Windows, Messages, SysUtils, Classes, WinInet;

type
  EWebError = class(Exception);

function DownloadString(url: String): String;

var
  // Change to false to insist on no proxy
  ProxyOK: Boolean;

implementation

{
function OpenAuthUrl(net: HInternet; url, username, password: String): HInternet;
var
  connection: HInternet;
begin
  connection := InternetConnect(net, host, port, nil, nil,
                                INTERNET_SERVICE_HTTP, 0, 0);
  Result := HttpOpenRequest(Connection, "GET", path,
                            nil, nil, nil,
                            // INTERNET_FLAG_KEEP_CONNECTION or
                            INTERNET_FLAG_RELOAD or
                            INTERNET_FLAG_PRAGMA_NOCACHE or
                            INTERNET_FLAG_NO_UI, 0);
  InternetSetOption(result, INTERNET_OPTION_USERNAME,
                    PChar(username), len(username));
  InternetSetOption(result, INTERNET_OPTION_PASSWORD,
                    PChar(password), len(password));

  HttpSendRequest(result, nil, 0, nil, 0);
  //HttpQueryInfo(Resource, HTTP_QUERY_FLAG_NUMBER |
  //              HTTP_QUERY_STATUS_CODE, &dwStatus, &dwStatusSize, NULL);
end;
 }

function DownloadString(url: string): string;
var
  NetHandle: HINTERNET;
  UrlHandle: HINTERNET;
  Buffer: array[0..1024] of Char;
  BytesRead: dWord;
  conntype: DWORD;
begin
  Result := '';
  conntype := INTERNET_OPEN_TYPE_DIRECT;
  if proxyok then conntype := INTERNET_OPEN_TYPE_PRECONFIG;
  NetHandle := InternetOpen('PQ6.2', conntype, nil, nil, 0);
  if Assigned(NetHandle) then
  begin                                 {
    if Len(username + password) > 0 then
      UrlHandle := OpenAuthUrl(NetHandle, username, password)
    else                                 }
      UrlHandle := InternetOpenUrl(NetHandle, PChar(Url),
                                   nil, 0,  // headers[size]
                                   INTERNET_FLAG_KEEP_CONNECTION or
                                   INTERNET_FLAG_RELOAD or
                                   INTERNET_FLAG_PRAGMA_NOCACHE or
                                   INTERNET_FLAG_NO_UI,
                                   0);
    if Assigned(UrlHandle) then begin
      repeat
        InternetReadFile(UrlHandle, @Buffer, SizeOf(Buffer)-1, BytesRead);
        Buffer[BytesRead] := #0;
        Result := Result + Buffer;
      until BytesRead = 0;
      InternetCloseHandle(UrlHandle);
    end else begin
      raise EWebError.CreateFmt('Cannot open URL %s', [Url]);
    end;
    InternetCloseHandle(NetHandle);
  end else begin
    // NetHandle is not valid. Raise an exception
    raise EWebError.Create('Unable to initialize internet API');
  end;
end;


initialization
  ProxyOK := True;
end.
