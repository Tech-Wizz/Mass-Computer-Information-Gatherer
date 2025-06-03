Add-Type -AssemblyName System.Windows.Forms

$form = New-Object Windows.Forms.Form
$form.Text = 'Enter First 3 Octets of IP'
$form.Size = New-Object Drawing.Size(300,150)
$form.StartPosition = 'CenterScreen'

$t1 = New-Object Windows.Forms.TextBox
$t1.Location = New-Object Drawing.Point(10,20)
$t1.Width = 70

$t2 = New-Object Windows.Forms.TextBox
$t2.Location = New-Object Drawing.Point(100,20)
$t2.Width = 70

$t3 = New-Object Windows.Forms.TextBox
$t3.Location = New-Object Drawing.Point(190,20)
$t3.Width = 70

$btn = New-Object Windows.Forms.Button
$btn.Text = 'OK'
$btn.Location = New-Object Drawing.Point(100,60)
$btn.Add_Click({
    $form.Tag = "$($t1.Text),$($t2.Text),$($t3.Text)"
    $form.Close()
})

$form.Controls.AddRange(@($t1,$t2,$t3,$btn))
$form.ShowDialog() | Out-Null

if ($form.Tag) {
    Write-Output $form.Tag
}
