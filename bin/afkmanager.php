<?php
// afkmanager.php
// A fairly simple program to remove AFK users from my teamspeak server
// preserved here for posterity.

//Declare variables
	$server = '127.0.0.1';
	$port = '10011';
	$previous_response = 'none yet';
	
	$serversocket = fsockopen($server, $port, $errno, $errstr, 10);
	
	//Error handling for opening the socket
	if (!$serversocket)
	{
		echo "Error connecting to server: $errstr ($errno)<br>\n";
	}
	
	//Start actual conversation process
	$previous_response = fgets($serversocket);
	$previous_response = fgets($serversocket);
	
	fwrite($serversocket, 'login serveradmin VXDLmHXN' . "\r\n");
	$previous_response = fgets($serversocket);
	
	fwrite($serversocket, 'use 1' . "\r\n");
	$previous_response = fgets($serversocket);
	
	fwrite($serversocket, 'clientlist -times' . "\r\n");
	afk_manage(parse_input(fgets($serversocket)), $serversocket);
	
	//Functions
	//Parse the data and return it as an array
	function parse_input($rawdata)
	{
		return explode('|', $rawdata);
	}
	
	function afk_manage($clients, $socket)
	{
		foreach($clients as $client)
		{
			$subclient = explode(' ', $client);
			if(substr($subclient[5], 18) > 120000)
			{
				echo $subclient[3] . " is AFK! TAKING ACTION!\n";
				fwrite($socket, 'clientmove ' . $subclient[0] . ' cid=2' . "\r\n");
				echo str_replace('\\s', ' ', fgets($socket));
			}
		}
	}

	//Terminate Telnet session
	fwrite($serversocket, 'quit' . "\r\n");
	
	//Close the socket
	if(!fclose($serversocket))
	{
		echo "Error closing server socket!";
	}
?>
