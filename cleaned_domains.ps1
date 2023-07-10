'$baseFilepath = "C:\temp\Fresh\domain_E\"
$files = Get-ChildItem -Path $baseFilepath -Filter "domain_cleaned*.txt" |
    Sort-Object LastWriteTime -Descending'
$maxFiles = 3

if ($files) {
    $nextFileNumber = ($files.Count % $maxFiles) + 1

    # Generate the filename
    $fileName = "domain_cleaned$nextFileNumber.txt"
    $filePath = Join-Path -Path $baseFilepath -ChildPath $fileName

    # Read the file content
    $fileContent = Get-Content -Path $files[0].FullName

    # Search for the line starting with "SMTP:" (case-insensitive)
    $smtpLine = $fileContent | Where-Object { $_ -clike "SMTP:*" }

    if ($smtpLine) {
        # Trim the line to remove leading/trailing spaces
        $trimmedLine = $smtpLine.Trim()

        # Output the trimmed line
        $trimmedLine

        # Save the trimmed line to the file
        $trimmedLine | Out-File -FilePath $filePath

        Write-Host "Output saved to file: $filePath"
    } else {
        Write-Host "No line starting with 'SMTP:' found in $files[0].FullName."
    }
} else {
    # Generate the filename for the first file
    $fileName = "domain_cleaned1.txt"
    $filePath = Join-Path -Path $baseFilepath -ChildPath $fileName

    Write-Host "No files found in the specified directory."
    Write-Host "Creating new file: $filePath"

    # Create the file
    $null | Out-File -FilePath $filePath
}
