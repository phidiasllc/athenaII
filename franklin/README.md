<h1>Updating Franklin</h1>
<ol>
<li>Download each of the deb packages in the list above by clicking on them and then clicking the Download button in the page that opens.</li>
<li>Copy the files to the root folder of a USB thumb drive that contains no other deb packages, i.e., no files having a deb file extension can be in the root folder of the thumb drive.</li>
<li>Insert the thumb drive into the USB socket on the Orange Pi Zero.</li>
<li>Use a secure shell (ssh) client to login to the Orange Pi Zero:
<li><ul>
<li>Address: 192.168.76.2. User name: debian. Password: reprap</li>
<li>Versions of Windows other than the latest update of 10 require <a href="https://www.chiark.greenend.org.uk/~sgtatham/putty/" target="_blank">PuTTY</a>. Download, install and follow instructions in the codumentation provided at the PuTTY page to connect to the Orange Pi Zero.</li>
<li>The latest update of Windows 10 has a native ssh client accessible from the command line.</li>
<li> Mac and Linux both have a native ssh client.</li>
<li>To open a command line in Windows 10, type 'cmd' into the search bar.</li>
<li>At the command prompt, type ssh debian@192.168.76.2</li>
<li>The ssh client will (including PuTTY) will open at another command prompt.</li>
</ul></li>
<li> All following commands in quotes should be entered <strong>without</strong> the quotations</li>
<li>At the ssh command prompt, type "sudo dmesg" and press enter. If prompted, enter the password (above) and press enter.</li>
<li> At the end of many lines of text should be the id assigned to the thumb drive. It will likely be 'sda1' or similar.</li>
<li>Type "sudo mount /dev/sda1 /media" and press enter.</li>
<li>Type "cd /media" and press enter.</li>
<li>Type "sudo dpkg -i *.deb" and press enter. The packages will be installed. When complete, the command prompt will be displayed.</li>
<li>Type "cd ~" and press enter.</li>
<li>Type "sudo umount /media" and press enter</li>
<li>Remove the thumb drive from the Orange Pi Zero,</li>
<li>Open the Athena main page in a browser (192.168.76.2) and restart Franklin.</li>
<li>Terminate the ssh session by clicking ctrl-d.</li> 
</ol>
