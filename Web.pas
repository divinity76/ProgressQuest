unit Web;

interface

uses
  Windows, Messages, SysUtils, Classes, WinInet;

type
  EWebError = class(Exception);

function DownloadString(const Url: string): string;

implementation

function DownloadString(const Url: string): string;
var
  NetHandle: HINTERNET;
  UrlHandle: HINTERNET;
  Buffer: array[0..1024] of Char;
  BytesRead: dWord;
begin
  Result := '';
  NetHandle := InternetOpen('PQ6.2', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if Assigned(NetHandle) then
  begin
    UrlHandle := InternetOpenUrl(NetHandle, PChar(Url),
                                 nil, 0,  // headers
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

end.
