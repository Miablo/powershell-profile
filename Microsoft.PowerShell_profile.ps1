# Miablo Powershell Profile Configuration

<#
.Summary
    Custom prompt and settings for Microsoft Powershell
#>

$host.ui.RawUI.WindowTitle = "With Great Power Comes... Badass Power - El Miablo"

# Get our current path
$CurrentPath = (Get-Item -Path ".\" -Verbose).Name

Write-Host "            #@@@@.       &@@@@(           "
Write-Host "          @@@@@@@@@@   @@@@@@@@@@         "
Write-Host "         @@@@@@@@@@@@.@@@@@@@@@@@@         "
Write-Host "        ,@@@@@@@@@@@@@@@@@@@@@@@@@.       "
Write-Host "        .@@@@@@@@@@@@@@@@@@@@@@@@@         "
Write-Host "         @@@@@@@@@@@@@@@@@@@@@@@@@         "
Write-Host "          @@@@@@@@@@@@@@@@@@@@@@@         "
Write-Host "           @@@@@@@@@@@@@@@@@@@@&           "
Write-Host "             @@@@@@@@@@@@@@@@@             "
Write-Host "   *#         (@@@@@@@@@@@@@/        /@*   "
Write-Host "  ,@@@@&        *@@@@@@@@@,        @@@@@, "
Write-Host "   @@@@@@&        ,@@@@@,        @@@@@@@   "
Write-Host "  @@@@@@@@@@@#       %      .@@@@@@@@@@@@ "
Write-Host " @@@@@&.%@@@@@@@@@      ,@@@@@@@@@&,(@@@@& "
Write-Host "             ,@@@@@@@@@@@@@@@             "
Write-Host "                 (@@@@@@@.                 "
Write-Host "              @@@@@@@%@@@@@@@             "
Write-Host "           @@@@@@@*      @@@@@@@           "
Write-Host "     (@@@@@@@@@*           .@@@@@@@@@%.   "
Write-Host " /@@@@@@@@@@@                 @@@@@@@@@@@/ "
Write-Host " @@@@@@@@@@                     @@@@@@@@@% "
Write-Host "     @@@@@                      (@@@@.  Tokidoki$([char]8482) 2017"
Write-Host "                                                         "

# Function to Get Custom Directory path
Function Get-CustomDirectory
{
    [CmdletBinding()]
    [Alias("CDir")]
    [OutputType([String])]
    Param
    (
        [Parameter(ValueFromPipeline=$true,Position=0)]
        $Path = $PWD.Path
    )
    
    Begin
    {
        #Custom directories as a HashTable
        $CustomDirectories = @{

            $env:TEMP                                   ='Temp'
            $env:APPDATA                                ='AppData'
            "$HOME\Desktop"                             ='Desktop'
            "$HOME\Documents"                           ='MyDocuments'
            "$HOME\Downloads"                           ='Downloads'
            "C:\Users"                                  ='Users'
            "C:\"                                       ='Root'
            "$HOME"                                     ='Home'
        } 
    }
    Process
    {
        Foreach($Item in $Path)
        {
            $Match = ($CustomDirectories.GetEnumerator().name | ?{$Item -eq "$_" -or $Item -like "$_*"} |`
            select @{n='Directory';e={$_}},@{n='Length';e={$_.length}} |sort Length -Descending |select -First 1).directory
            If($Match)
            {
                [String]($Item -replace [regex]::Escape($Match),$CustomDirectories[$Match])            
            }
            ElseIf($pwd.Path -ne $Item)
            {
                $Item
            }
            Else
            {
                $pwd.Path
            }
        }
    }
    End
    {
    }
}

# Set the prompt customizations
Function Prompt
{
    Write-Host("  << ") -nonewline -foregroundcolor white
    Write-Host((Get-Date).ToShortTimeString()) -nonewline -ForegroundColor DarkCyan
    Write-Host(" >> ") -nonewline -foregroundcolor white; Write-Host "$ENV:USERNAME " -nonewline -ForegroundColor DarkRed; Write-Host "$([char]8226) " -ForegroundColor DarkBlue -nonewline; Write-Host "$env:COMPUTERNAME " -ForegroundColor black;
    Write-Host "  I " -NoNewline -ForegroundColor black; Write-Host "$([char]9829) " -ForegroundColor Red -NoNewline;
    Write-Host $(Get-CustomDirectory) -ForegroundColor Magenta  -NoNewline  
    Write-Host " >_" -NoNewline -ForegroundColor DarkRed
    return " "
}
# Functions that Alias
function home {set-location -Path $HOME}

# Standard Aliases

