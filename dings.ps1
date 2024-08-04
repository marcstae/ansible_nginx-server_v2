# Function to get the size of a string in bytes
function Get-StringSizeInBytes {
    param (
        [string]$String
    )
    return [System.Text.Encoding]::UTF8.GetByteCount($String)
}

# Function to split a large .ics file into smaller files
function Split-ICSFile {
    param (
        [string]$InputFilePath,
        [string]$OutputFolder,
        [int]$MaxFileSizeInBytes = 1000000  # 1 MB
    )

    # Read the content of the .ics file
    $icsContent = Get-Content -Path $InputFilePath -Raw

    # Split the content into lines
    $icsLines = $icsContent -split "`n"

    # Find the header and footer
    $header = @()
    $footer = @()
    $events = @()
    $insideEvent = $false

    foreach ($line in $icsLines) {
        if ($line -match "^BEGIN:VEVENT") {
            $insideEvent = $true
        }

        if ($insideEvent) {
            $events += $line
        } else {
            $header += $line
        }

        if ($line -match "^END:VEVENT") {
            $insideEvent = $false
        }
    }

    # Footer is everything after the last event
    $footer = $icsLines[-1]

    # Split events into multiple files
    $fileIndex = 1
    $currentFileContent = $header + "BEGIN:VEVENT"
    foreach ($event in $events) {
        if ($event -match "^BEGIN:VEVENT") {
            $currentFileContent = $header + "BEGIN:VEVENT"
        }

        $currentFileContent += $event

        if ($event -match "^END:VEVENT") {
            $currentFileContent += $footer

            if (Get-StringSizeInBytes -String ($currentFileContent -join "`n") -lt $MaxFileSizeInBytes) {
                $outputFilePath = Join-Path -Path $OutputFolder -ChildPath ("$fileIndex.ics")
                $currentFileContent -join "`n" | Out-File -FilePath $outputFilePath -Encoding UTF8
                $fileIndex++
                $currentFileContent = $header + "BEGIN:VEVENT"
            }
        }
    }

    # Save the last chunk if not empty
    if ($currentFileContent.Count -gt 0) {
        $outputFilePath = Join-Path -Path $OutputFolder -ChildPath ("$fileIndex.ics")
        $currentFileContent -join "`n" | Out-File -FilePath $outputFilePath -Encoding UTF8
    }
}

# Main script
$inputFilePath = "path\to\your\large_calendar.ics"  # Specify the path to your large .ics file
$outputFolder = "path\to\output\folder"  # Specify the folder to save the split .ics files

# Ensure the output folder exists
if (-Not (Test-Path -Path $outputFolder)) {
    New-Item -ItemType Directory -Path $outputFolder
}

# Split the large .ics file
Split-ICSFile -InputFilePath $inputFilePath -OutputFolder $outputFolder