$python = "C:\Users\Dongjin\.espressif\python_env\idf5.5_py3.14_env\Scripts\python.exe"
$esptool = "C:\Users\dongjin\esp\esp-idf\components\esptool_py\esptool\esptool.py"
$build = "C:\Users\dongjin\esp\xiaozhi-esp32\build"
$port = "COM6"

Write-Host "=== Flashing MAIN BRANCH firmware (no verbose changes) ===" -ForegroundColor Cyan

& $python $esptool --chip esp32s3 --port $port --baud 460800 --before default_reset --after hard_reset write_flash --flash_mode dio --flash_freq 80m --flash_size 16MB 0x0 "$build\bootloader\bootloader.bin" 0x8000 "$build\partition_table\partition-table.bin" 0xd000 "$build\ota_data_initial.bin" 0x20000 "$build\xiaozhi.bin" 0x800000 "$build\generated_assets.bin"

if ($LASTEXITCODE -eq 0) {
    Write-Host "Flash SUCCESS!" -ForegroundColor Green
} else {
    Write-Host "Flash FAILED, exit code: $LASTEXITCODE" -ForegroundColor Red
}
