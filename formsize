Add-Type -AssemblyName System.Windows.Forms

# Create a new form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Movable and Resizable ListBox"
$form.Size = New-Object System.Drawing.Size(400, 400)

# Create a list box and make it movable and resizable
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10, 10)
$listBox.Size = New-Object System.Drawing.Size(200, 200)
$listBox.AllowDrop = $true
$listBox.Add_MouseDown({
    if ($_.Button -eq [System.Windows.Forms.MouseButtons]::Left) {
        $this.Capture = $true
        $this.BackColor = [System.Drawing.Color]::Gray
        $global:mouseDownLocation = $_.Location
        $global:mouseDownSize = $_.Size
    }
})
$listBox.Add_MouseMove({
    if ($this.Capture) {
        $deltaX = $_.X - $global:mouseDownLocation.X
        $deltaY = $_.Y - $global:mouseDownLocation.Y
        $newX = $this.Location.X + $deltaX
        $newY = $this.Location.Y + $deltaY
        $this.Location = New-Object System.Drawing.Point($newX, $newY)
    }
})
$listBox.Add_MouseUp({
    $this.Capture = $false
    $this.BackColor = [System.Drawing.Color]::FromArgb(240,240,240)
})
$listBox.Add_Resize({
    if ($this.Capture) {
        $deltaX = $_.Size.Width - $global:mouseDownSize.Width
        $deltaY = $_.Size.Height - $global:mouseDownSize.Height
        $newWidth = $this.Size.Width + $deltaX
        $newHeight = $this.Size.Height + $deltaY
        $this.Size = New-Object System.Drawing.Size($newWidth, $newHeight)
    }
})

# Create a button to display the code with the new position and size of the list box
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(10, 220)
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Text = "Show Code"
$button.Add_Click({
    Write-Host "`$listBox.Location = New-Object System.Drawing.Point($($listBox.Location.X), $($listBox.Location.Y))"
    Write-Host "`$listBox.Size = New-Object System.Drawing.Size($($listBox.Size.Width), $($listBox.Size.Height))"
})

# Add the list box and button to the form
$form.Controls.Add($listBox)
$form.Controls.Add($button)

# Show the form
$form.ShowDialog() | Out-Null
