<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

// if (!$link->set_charset("utf8")) {
    // printf("Error loading character set utf8: %s\n", $link->error);
    // exit();
	// }

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
			
		$idSeller   = $_GET['idSeller'];
		$nameSeller = $_GET['nameSeller'];
		$name    	= $_GET['name'];
		$price      = $_GET['price'];
		$detail     = $_GET['detail'];		
		$images 	= $_GET['images'];
		
							
		//$sql = "INSERT INTO `user`(`id`, `name`, `user`, `password`) VALUES (Null,'$name','$user','$password')";
		
		//$sql = "INSERT INTO `nhongshoppingmall1`.`user` (`name`, `type`, `address`, `phone`, `user`, `password`, `avatar`, `lat`, `lng`) ";
		//$sql = $sql . "VALUES ('$name', '$type', '$address', '$phone', '$user', '$password', '$avatar', '$lat', '$lng') ";
		
		$sql = "INSERT INTO `nhongshoppingmall1`.`product` (`idSeller`, `nameSeller`, `name`, `price`, `detail`, `images`) ";
		$sql = $sql . "VALUES ('$idSeller', '$nameSeller', '$name', '$price', '$detail', '$images');";

		// $result = mysqli_query($link, $sql);
		$result = mysql_query($sql) or die("error : $sql");

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	// mysqli_close($link);
?>