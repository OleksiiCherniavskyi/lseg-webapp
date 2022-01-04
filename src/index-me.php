<?php
$ip = getenv('CONTAINER_IP');
echo "
<html>
  <head>
    <title>LSEG IP</title>
  </head>
  <body>
    <h2>Container IP: ".$ip."</h2>
  </body>
</html>";
?>
