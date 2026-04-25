$env:IDF_PATH = 'C:\Users\Dongjin\esp\esp-idf'
$env:ESP_IDF_VERSION = '5.5'
$env:IDF_PYTHON_ENV_PATH = 'C:\Users\Dongjin\.espressif\python_env\idf5.5_py3.14_env'
$env:ESP_ROM_ELF_DIR = 'C:\Users\Dongjin\.espressif\tools\esp-rom-elfs\20241011\'
$env:IDF_CCACHE_ENABLE = '0'
$newPath = 'C:\Users\dongjin\esp\esp-idf\components\espcoredump;C:\Users\dongjin\esp\esp-idf\components\partition_table;C:\Users\dongjin\esp\esp-idf\components\app_update;C:\Users\Dongjin\.espressif\tools\cmake\3.30.2\bin;C:\Users\Dongjin\.espressif\tools\ninja\1.12.1;C:\Users\Dongjin\.espressif\python_env\idf5.5_py3.14_env\Scripts;C:\Users\dongjin\esp\esp-idf\tools'
$env:PATH = $newPath + ';' + $env:PATH

Set-Location 'C:\Users\dongjin\esp\xiaozhi-esp32'
Write-Host 'Building main branch (ccache disabled)...' -ForegroundColor Cyan

$python = 'C:\Users\Dongjin\.espressif\python_env\idf5.5_py3.14_env\Scripts\python.exe'
& $python "$env:IDF_PATH\tools\idf.py" build
