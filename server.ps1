$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8080/")
$listener.Start()
Write-Host "Server running at http://localhost:8080/"
while ($listener.IsListening) {
    try {
        $context = $listener.GetContext()
        $response = $context.Response
        $htmlBytes = [System.IO.File]::ReadAllBytes("c:\web\lab01\index.html")
        $response.ContentType = "text/html; charset=utf-8"
        $response.ContentLength64 = $htmlBytes.Length
        $response.OutputStream.Write($htmlBytes, 0, $htmlBytes.Length)
        $response.Close()
    } catch {
        # ignore abort/close
    }
}
