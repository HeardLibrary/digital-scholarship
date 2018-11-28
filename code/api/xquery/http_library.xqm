xquery version "3.1";
module namespace vudsscapi = 'https://github.com/HeardLibrary/digital-scholarship/tree/master/code/api';

(: performs generic HTTP GET :)
declare function vudsscapi:httpGet
  ( $uri as xs:string ,
    $acceptMime as xs:string )  
   as item()+
    
{
  let $mimeType :=
    if ($acceptMime = '')
    then '*.*'
    else $acceptMime
  
  let $request := <http:request href='{$uri}' method='get'><http:header name='Accept' value='{$mimeType}'/></http:request>
  let $responseXml := http:send-request($request)
  let $statusCode := string($responseXml[1]/@status)
  let $responseBody := $responseXml[2]
  return ($statusCode, $responseBody)
};