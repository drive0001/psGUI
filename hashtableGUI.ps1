# Load the Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Create a form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Hashtable GUI Example'
$form.Width = 300
$form.Height = 200

# Create a hashtable
$myHashtable = [ordered]@{
    Key1 = 'Value1'
    Key2 = 'Value2'
    Key3 = 'Value3'
}

# Create a ListBox to display the keys and values
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Left = 10
$listBox.Top = 10
$listBox.Width = 250
$listBox.Height = 150
$form.Controls.Add($listBox)

# Populate the ListBox with keys and values
foreach ($key in $myHashtable.Keys) {
    $value = $myHashtable[$key]
    $listBox.Items.Add("$key = $value")
}

# Create a TextBox to display the selected value
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Left = 10
$textBox.Top = 170
$textBox.Width = 250
$textBox.ReadOnly = $true
$form.Controls.Add($textBox)

# Add an event handler for the ListBox selection change event
$listBox.Add_SelectedIndexChanged({
    $selectedItem = $listBox.SelectedItem
    $selectedKey = $selectedItem -replace ' = .*', ''
    $selectedValue = $selectedItem -replace '.* = ', ''
    $textBox.Text = $selectedValue
})

# Create an OK button to update the selected value
$button = New-Object System.Windows.Forms.Button
$button.Text = 'OK'
$button.Left = 110
$button.Top = 130
$button.Width = 80
$button.Add_Click({
    $selectedItem = $listBox.SelectedItem
    $selectedKey = $selectedItem -replace ' = .*', ''
    $newValue = $textBox.Text
    $myHashtable[$selectedKey] = $newValue
    $listBox.Items[$listBox.SelectedIndex] = "$selectedKey = $newValue"
})
$form.Controls.Add($button)

# Show the form
$form.ShowDialog()

# Access updated values from the hashtable
Write-Host "Updated value for Key1: $($myHashtable['Key1'])"
Write-Host "Updated value for Key2: $($myHashtable['Key2'])"
Write-Host "Updated value for Key3: $($myHashtable['Key3'])"

