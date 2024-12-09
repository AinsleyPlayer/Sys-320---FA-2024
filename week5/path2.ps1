.(Join-Path $PSScriptRoot .\i.ps1)

$return = gatherClasses

$returns = daysTranslator $return

$returns

