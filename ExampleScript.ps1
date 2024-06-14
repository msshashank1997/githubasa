# Set the GitHub PAT
$token = "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"

# Set the repository details
$owner = "msshashank1997"
$repo = "https://github.com/msshashank1997/githubasa.git"

# Set the file path and content 
$file = "path/to/file.txt"
$content = "Hello, world!"

# Create a new file in the repository
$base64Content = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($content))
$body = @{
    message = "Create new file"
    content = $base64Content
} | ConvertTo-Json

$uri = "https://api.github.com/repos/$owner/$repo/contents/$file"
$headers = @{
    Authorization = "Bearer $token"
    Accept = "application/vnd.github.v3+json"
}

$response = Invoke-RestMethod -Uri $uri -Method Put -Headers $headers -Body $body

if ($response.content.sha) {
    Write-Host "File created successfully."
} else {
    Write-Host "Failed to create file."
}
