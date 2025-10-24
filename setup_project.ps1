# PowerShell script to run Cursor rule for Flutter project setup
# This script collects inputs and calls the existing Cursor rule

Write-Host "Flutter Project Setup Runner"
Write-Host "==========================="
Write-Host ""

# Check if the rule exists
$ruleFilePath = ".cursor\rules\set_project_setting.mdc"
if (-not (Test-Path $ruleFilePath)) {
    Write-Host "Error: Rule file not found at $ruleFilePath"
    Write-Host "Please make sure the rule exists before running this script."
    exit 1
}

# Prompt for project name
do {
    $project_name = Read-Host "Enter project name (lowercase with underscores, e.g. my_project)"
    $valid_name = $project_name -match "^[a-z][a-z0-9_]*$"
    if (-not $valid_name) {
        Write-Host "Error: Project name must be lowercase with underscores only."
    }
} while (-not $valid_name)

# Prompt for application ID
do {
    $application_id = Read-Host "Enter application ID (e.g. com.company.appname)"
    $valid_id = $application_id -match "^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$"
    if (-not $valid_id) {
        Write-Host "Error: Application ID must follow reverse domain notation (e.g., com.company.appname)."
    }
} while (-not $valid_id)

# Prompt for Firebase integration
do {
    $enable_firebase = Read-Host "Enable Firebase? (yes/no)"
    $valid_firebase = $enable_firebase -match "^(yes|no)$"
    if (-not $valid_firebase) {
        Write-Host "Error: Please enter 'yes' or 'no' for Firebase integration."
    }
} while (-not $valid_firebase)

# Display summary
Write-Host ""
Write-Host "Summary of settings:"
Write-Host "Project name: $project_name"
Write-Host "Application ID: $application_id"
Write-Host "Enable Firebase: $enable_firebase"
Write-Host ""

# Confirm settings
$confirm = Read-Host "Are these settings correct? (yes/no)"
if ($confirm -ne "yes") {
    Write-Host "Setup cancelled."
    exit 0
}

# Run the Cursor rule
Write-Host "Running Cursor rule with collected settings..."
Write-Host ""
Write-Host "Command to execute in Cursor command palette:"
Write-Host "@set_project_setting.mdc\nproject name `"$project_name`"\napplication id `"$application_id`"\nenable firebase `"$enable_firebase`""
Write-Host ""
Write-Host "Please copy this command and run it in the Cursor command palette."
Write-Host "Setup process complete!"