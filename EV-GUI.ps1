Add-Type -AssemblyName System.Windows.Forms
function function1{
$hashtable2=@(
"fgfgfg"
"fgfgfgfff"
"ffffff"
"ss"
)
return $hashtable2

}
# Define the arrays
$array1 = "Value1", "Value2", "Value3"
$array2 = "Option A", "Option B", "Option C"
$array3 = "Item 1", "Item 2", "Item 3"

# Create a new form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Array Selector"
$form.Size = New-Object System.Drawing.Size(600,400)

# Create three list boxes to display the array content
$listBox1 = New-Object System.Windows.Forms.ListBox
$listBox1.Location = New-Object System.Drawing.Point(10, 10)
$listBox1.Size = New-Object System.Drawing.Size(120, 200)
$listBox1.DataSource = $array1

$listBox2 = New-Object System.Windows.Forms.ListBox
$listBox2.Location = New-Object System.Drawing.Point(140, 10)
$listBox2.Size = New-Object System.Drawing.Size(120, 200)
$listBox2.DataSource = $array2

$listBox3 = New-Object System.Windows.Forms.ListBox
$listBox3.Location = New-Object System.Drawing.Point(270, 10)
$listBox3.Size = New-Object System.Drawing.Size(120, 200)
$listBox3.DataSource = $array3

# Create two buttons to run the selected functions
$button1 = New-Object System.Windows.Forms.Button
$button1.Location = New-Object System.Drawing.Point(50, 220)
$button1.Size = New-Object System.Drawing.Size(100, 30)
$button1.Text = "Function 1"
$button1.Add_Click({
    $param1 = $listBox1.SelectedItem
    $param2 = $listBox2.SelectedItem
    $param3 = $listBox3.SelectedItem
    # Replace function1 with the actual function name
    if ($param1 -and $param2 -and $param3) {
        $result = function1 $param1 $param2 $param3
        $listBox4.DataSource = $result
    } else {
        [System.Windows.Forms.MessageBox]::Show("Please select a value from each list.", "Error")
    }
})

$button2 = New-Object System.Windows.Forms.Button
$button2.Location = New-Object System.Drawing.Point(250, 220)
$button2.Size = New-Object System.Drawing.Size(100, 30)
$button2.Text = "Function 2"
$button2.Add_Click({
    $param1 = $listBox1.SelectedItem
    $param2 = $listBox2.SelectedItem
    $param3 = $listBox3.SelectedItem
    # Replace function2 with the actual function name
    if ($param1 -and $param2 -and $param3) {
        function2 $param1 $param2 $param3
    } else {
        [System.Windows.Forms.MessageBox]::Show("Please select a value from each list.", "Error")
    }
})

# Create a list box to display the results from function1
$listBox4 = New-Object System.Windows.Forms.ListBox
$listBox4.Location = New-Object System.Drawing.Point(400, 10)
$listBox4.Size = New-Object System.Drawing.Size(170, 200)

# Add controls to the form
$form.Controls.Add($listBox1)
$form.Controls.Add($listBox2)
$form.Controls.Add($listBox3)
$form.Controls.Add($button1)
$form.Controls.Add($button2)
$form.Controls.Add($listBox4)
$form.ShowDialog() | Out-Null
