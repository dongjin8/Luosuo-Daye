# 用 ESP-IDF 专用 Python（绝对路径，不会被系统 Python 干扰）
$esptool_py = "C:\Users\Dongjin\.espressif\python_env\idf5.5_py3.14_env\Scripts\python.exe"

$project_dir = "C:\Users\dongjin\esp\xiaozhi-esp32"
$build_dir = "$project_dir\build"

Write-Host "=== 烧录 xiaozhi-esp32 verbose-mode 固件 ===" -ForegroundColor Cyan
Write-Host "ESP-IDF Python: $esptool_py"

if (-not (Test-Path $esptool_py)) {
    Write-Host "ESP-IDF Python 不存在，尝试备用路径..." -ForegroundColor Yellow
    $esptool_py = "python"
}

# 检查串口
$ports = [System.IO.Ports.SerialPort]::GetPortNames()
if ($ports.Count -eq 0) {
    Write-Host "未找到串口！请检查USB连接" -ForegroundColor Red
    exit 1
}
Write-Host "可用串口: $($ports -join ', ')"
$port = $ports[0]
Write-Host "将烧录到: $port" -ForegroundColor Yellow

$confirm = Read-Host "确认烧录到 $port 吗？(y/n)"
if ($confirm -ne "y") {
    Write-Host "取消烧录"
    exit 0
}

# 五件套烧录
& $esptool_py `
    "$project_dir\components\esptool_py\esptool\esptool.py" `
    --chip esp32s3 `
    --port $port `
    --baud 460800 `
    --before default_reset `
    --after hard_reset `
    write_flash `
    --flash_mode dio `
    --flash_freq 80m `
    --flash_size 16MB `
    0x0         "$build_dir\bootloader\bootloader.bin" `
    0x8000      "$build_dir\partition_table\partition-table.bin" `
    0xd000      "$build_dir\ota_data_initial.bin" `
    0x20000     "$build_dir\xiaozhi.bin" `
    0x800000    "$build_dir\generated_assets.bin"

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n烧录成功！查看串口日志..." -ForegroundColor Green
    Start-Sleep 2
    python "$project_dir\components\esptool_py\esptool\esptool.py" --chip esp32s3 --port $port --baud 115200 monitor
} else {
    Write-Host "`n烧录失败！错误码: $LASTEXITCODE" -ForegroundColor Red
}
