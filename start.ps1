Write-Host "Building and starting containers in detached mode..."
docker-compose up --build --detach

Write-Host "`nContainers are running in the background. To check status use:"
Write-Host "docker-compose ps"
Write-Host "`nTo view logs use:"
Write-Host "docker-compose logs -f"
Write-Host "`nTo stop containers use:"
Write-Host "docker-compose down"
