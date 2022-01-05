<?php
$env = getenv('ENV');
$app = getenv('APP');
echo "
<html>
  <head>
    <title>$app Status</title>
  </head>
  <body>
    <h2>OK ".$env."</h2>
  </body>
</html>";
?>
