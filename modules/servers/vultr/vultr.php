<?php
function vultr_ConfigOptions( )
{
	return $configarray;
}

function vultr_CreateAccount( $params )
{
$apikey= $params["serverpassword"];
    {
    	$ch=curl_init();
	$serviceid = $params["serviceid"];
	$DCID=$params['configoptions']['Datacenter'];
	$VPSPLANID=$params['configoptions']['Resource Plan'];
	$OS=$params['configoptions']['OS'];
	$SNAPSHOTID=$params['configoptions']['Snapshot'];
       curl_setopt( $ch, CURLOPT_URL, "https://api.vultr.com/v1/server/create?api_key=".$apikey );
       curl_setopt( $ch, CURLOPT_POST, 1 );
       curl_setopt( $ch, CURLOPT_POSTFIELDS, "DCID=$DCID&VPSPLANID=$VPSPLANID&OSID=$OS&SNAPSHOTID=$SNAPSHOTID&label=$serviceid&enable_ipv6=yes");
       curl_setopt( $ch, CURLOPT_TIMEOUT, 30 );
       curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
	$response =json_decode(curl_exec($ch),1);
	$http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        if ( $http_status == "200" )
        {
            $successful = true;
	     $server_id = $response[SUBID];
        }
        else
        {
            $errorinfo = "API error. ".$http_status;
        }
	 curl_close( $ch );
    }

    if ( $successful )
    {
	 sleep( 60 );	 //wait 60 secondes let vultr to install and then get server details
	 $var1= (int)get_query_val( "tblcustomfields", "id", array( "fieldname" => 'server_id', "relid" => $params['packageid'] ) );
        update_query( "tblcustomfieldsvalues", array( "value" => $server_id ), array( "fieldid" => $var1, "relid" => $params['serviceid'] ) );
	     $ch=curl_init();
            curl_setopt( $ch, CURLOPT_URL, "https://api.vultr.com/v1/server/list?api_key=".$apikey );
            curl_setopt( $ch, CURLOPT_TIMEOUT, 30 );
            curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
            $response2 =json_decode(curl_exec($ch),1);
            $http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
            if ( $http_status == "200" )
            {
		  $server_ip = $response2[$server_id]['main_ip'];
		  $server_passwd = $response2[$server_id]['default_password'];
              $command = "encryptpassword";
 		$adminuser = $params["serverusername"];
 		$values["password2"] = $server_passwd;
              $server_passwd_entd_arry = localAPI($command,$values,$adminuser);
		$server_passwd_entd =$server_passwd_entd_arry[password];
            }
	     curl_close( $ch );
        if ( empty( $server_ip ) )
        {
            $result = "success";
            $server_ip = "See client area";
            $server_password = "See client area";
        }
        else
        {
            $result = "success";
        }
        update_query( "tblhosting", array( "dedicatedip" => $server_ip, "username" => "root/administrator", "password" => "$server_passwd_entd" ), array( "id" => $params['serviceid'] ) );
    }
    else
    {
        $result = "Something has gone wrong. Please manually check and/or create the droplet. Info: ".$errorinfo;
    }
    return $result;
}



function vultr_TerminateAccount( $params )
{
$apikey= $params["serverpassword"];
    $var2=$params['customfields']['server_id'];
    $ch=curl_init();
    curl_setopt( $ch, CURLOPT_URL, "https://api.vultr.com/v1/server/destroy?api_key=".$apikey );
    curl_setopt( $ch, CURLOPT_POST, 1 );
    curl_setopt( $ch, CURLOPT_POSTFIELDS, "SUBID=".$var2 );
    curl_setopt( $ch, CURLOPT_TIMEOUT, 30 );
    curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
    $response2 =json_decode(curl_exec($ch),1);
    $http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    if ( $http_status == "200" )
    {
        $successful = true;
    }
    if ( $successful )
    {
        update_query( "tblhosting", array( "dedicatedip" => "" ), array( "id" => $params['serviceid'] ) );
        $result = "success";
    }
    else
    {
        $result = "ERROR! Could not destroy the server  (".$http_status." ".$data.").";
    }
    curl_close( $ch );
    return $result;
}

function vultr_SuspendAccount( $params )
{
$apikey= $params["serverpassword"];
    $var2=$params['customfields']['server_id'];
    $ch=curl_init();
    curl_setopt( $ch, CURLOPT_URL, "https://api.vultr.com/v1/server/halt?api_key=".$apikey );
    curl_setopt( $ch, CURLOPT_POST, 1 );
    curl_setopt( $ch, CURLOPT_POSTFIELDS, "SUBID=".$var2 );
    curl_setopt( $ch, CURLOPT_TIMEOUT, 30 );
    curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
    $response2 =json_decode(curl_exec($ch),1);
    $http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    if ( $http_status == "200" )
    {
        $successful = true;
    }
    if ( $successful )
    {
        $result = "success";
    }
    else
    {
        $result = "Could not suspend server (".$http_status." ".$data.").";
    }
    curl_close( $ch );
    return $result;

}

function vultr_UnsuspendAccount( $params )
{
$apikey= $params["serverpassword"];
    $var2=$params['customfields']['server_id'];
    $ch=curl_init();
    curl_setopt( $ch, CURLOPT_URL, "https://api.vultr.com/v1/server/start?api_key=".$apikey );
    curl_setopt( $ch, CURLOPT_POST, 1 );
    curl_setopt( $ch, CURLOPT_POSTFIELDS, "SUBID=".$var2 );
    curl_setopt( $ch, CURLOPT_TIMEOUT, 30 );
    curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
    $response2 =json_decode(curl_exec($ch),1);
    $http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    if ( $http_status == "200" )
    {
        $successful = true;
    }
    if ( $successful )
    {
        $result = "success";
    }
    else
    {
        $result = "Could not unsuspend server  (".$http_status." ".$data.").";
    }
    curl_close( $ch );
    return $result;
}


function vultr_ClientArea( $params )
{
    $code = "<br>";
    {
	 $apikey= $params["serverpassword"];
	 $server_id=$params['customfields']['server_id'];
        $ch=curl_init();
        curl_setopt( $ch, CURLOPT_URL, "https://api.vultr.com/v1/server/list?api_key=".$apikey );
        curl_setopt( $ch, CURLOPT_TIMEOUT, 30 );
        curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
	$response2 =json_decode(curl_exec($ch),1);
	$server_details=$response2[$server_id];
	$http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        if ( $http_status == "200" )
        {
           return array( "templatefile" => "clientarea", "vars" => array( "server_details" => $server_details, "ip_details" =>$server_details['ip_details'], "rdns" => $rdns ) );
        }
    }
    curl_close( $ch );
    $code .= "<h1 style=\"color:red;\">WARNING:</h1>Please contact support.</p><br>";
    return $code;
}

function vultr_reboot( $params )
{
$apikey= $params["serverpassword"];
    $var2=$params['customfields']['server_id'];
    $ch=curl_init();
    curl_setopt( $ch, CURLOPT_URL, "https://api.vultr.com/v1/server/reboot?api_key=".$apikey );
    curl_setopt( $ch, CURLOPT_POST, 1 );
    curl_setopt( $ch, CURLOPT_POSTFIELDS, "SUBID=".$var2 );
    curl_setopt( $ch, CURLOPT_TIMEOUT, 30 );
    curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
    $url="https://api.vultr.com/v1/server/reboot?api_key=".$apikey;
    $response =json_decode(curl_exec($ch),1);
    $http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    if ( $http_status == "200" )
    {
        $successful = true;
    }
    if ( $successful )
    {
        $result = "success";
    }
    else
    {
        $result = "Could not reboot server (".$http_status." ".$data.") ".$url.".";
    }
    curl_close( $ch );
    return $result;
}

function vultr_start( $params )
{
$apikey= $params["serverpassword"];
    $var2=$params['customfields']['server_id'];
    $ch=curl_init();
    curl_setopt( $ch, CURLOPT_URL, "https://api.vultr.com/v1/server/start?api_key=".$apikey );
    curl_setopt( $ch, CURLOPT_POST, 1 );
    curl_setopt( $ch, CURLOPT_POSTFIELDS, "SUBID=".$var2 );
    curl_setopt( $ch, CURLOPT_TIMEOUT, 30 );
    curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
    $response2 =json_decode(curl_exec($ch),1);
    $http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    if ( $http_status == "200" )
    {
        $successful = true;
    }
    if ( $successful )
    {
        $result = "success";
    }
    else
    {
        $result = "Could not power on server  (".$http_status." ".$data.").";
    }
    curl_close( $ch );
    return $result;
}


function vultr_halt( $params )
{
$apikey= $params["serverpassword"];
    $var2=$params['customfields']['server_id'];
    $ch=curl_init();
    curl_setopt( $ch, CURLOPT_URL, "https://api.vultr.com/v1/server/halt?api_key=".$apikey );
    curl_setopt( $ch, CURLOPT_POST, 1 );
    curl_setopt( $ch, CURLOPT_POSTFIELDS, "SUBID=".$var2 );
    curl_setopt( $ch, CURLOPT_TIMEOUT, 30 );
    curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
    $response2 =json_decode(curl_exec($ch),1);
    $http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    if ( $http_status == "200" )
    {
        $successful = true;
    }
    if ( $successful )
    {
        $result = "success";
    }
    else
    {
        $result = "Could not power off server (".$http_status." ".$data.").";
    }
    curl_close( $ch );
    return $result;
}

function vultr_reinstall( $params )
{
$apikey= $params["serverpassword"];
    $var2=$params['customfields']['server_id'];
    $ch=curl_init();
    curl_setopt( $ch, CURLOPT_URL, "https://api.vultr.com/v1/server/reinstall?api_key=".$apikey );
    curl_setopt( $ch, CURLOPT_POST, 1 );
    curl_setopt( $ch, CURLOPT_POSTFIELDS, "SUBID=".$var2 );
    curl_setopt( $ch, CURLOPT_TIMEOUT, 30 );
    curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
    $response2 =json_decode(curl_exec($ch),1);
    $http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    if ( $http_status == "200" )
    {
        $successful = true;
    }
    if ( $successful )
    {
        $result = "success";
    }
    else
    {
        $result = "Could not reinstall server (".$http_status." ".$data.").";
    }
    $response =json_decode(curl_exec($ch),1);
    curl_close( $ch );
    return $result;
}

function vultr_updatevminfomanully( $params )
{
$apikey= $params["serverpassword"];
		$ch=curl_init();
		$server_id=$params['customfields']['server_id'];
              curl_setopt( $ch, CURLOPT_URL, "https://api.vultr.com/v1/server/list?api_key=".$apikey );
              curl_setopt( $ch, CURLOPT_TIMEOUT, 30 );
              curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
		$response2 =json_decode(curl_exec($ch),1);
              $http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
              if ( $http_status == "200" )
              {
	       $server_ip = $response2[$server_id]['main_ip'];
		$server_passwd =  $response2[$server_id]['default_password'];
 		$command = "encryptpassword";
 		$adminuser = $params["serverusername"];
 		$values["password2"] = $server_passwd;
              $server_passwd_entd_arry = localAPI($command,$values,$adminuser);
		$server_passwd_entd =$server_passwd_entd_arry[password];
                 	if ( !empty( $server_ip) )
                	{
			update_query( "tblhosting", array( "dedicatedip" => $server_ip, "username" => "root/administrator" , "password" => "$server_passwd_entd" ), array( "id" => $params['serviceid'] ) );
              	$result = "success";
		 	}
			else
			{
			$result ="No server with this ID";
			}
	       }
                else
                {
                $result = "Could not update server information (".$http_status." ".$data.").";
                }
                curl_close( $ch );

	 return $result;
}

function vultr_AdminServicesTabFields($params)
{
$apikey= $params["serverpassword"];
		$ch=curl_init();
		$server_id=$params['customfields']['server_id'];
              curl_setopt( $ch, CURLOPT_URL, "https://api.vultr.com/v1/server/list?api_key=".$apikey );
              curl_setopt( $ch, CURLOPT_TIMEOUT, 30 );
              curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
		$response2 =json_decode(curl_exec($ch),1);
              $http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);

		if ( $http_status == "200" )
		{
		 $server_ip = $response2[$server_id]['main_ip'];
		 $server_passwd = $response2[$server_id]['default_password'];
		 $server_passwd =  $response2[$server_id]['default_password'];
	        $ram = $response2[$server_id]['ram'];
	        $location = $response2[$server_id]['location'];
	        $date_created = $response2[$server_id]['date_created'];
	        $status = $response2[$server_id]['status'];
	        $power_status = $response2[$server_id]['power_status'];
	        $kvm_url = $response2[$server_id]['kvm_url'];
 		}
		curl_close( $ch );

  	  $fieldsarray = array(
	       'server_ip' => $server_ip,
	       'server_passwd'=> $server_passwd ,
	       'ram'=> $ram,
	       'location'=> $location,
	       'date_created'=> $date_created,
	       'status'=> $status,
	       'power_status'=> $power_status,
	       'kvm_url'=> '<a href="'.$kvm_url.'" target="_blank">Open VNC</a>',
    	  );
   	 return $fieldsarray;

}


function vultr_ClientAreaCustomButtonArray( )
{
    $buttonarray = array( "Reboot" => "reboot", "Start Up" => "start", "Shut Down" => "halt", "ReInstall the System" => "reinstall");
    return $buttonarray;
}

function vultr_AdminCustomButtonArray( )
{
    $buttonarray = array( "Reboot" => "reboot", "Start Up" => "start", "Shut Down" => "halt" , "ReInstall the System" => "reinstall", "Update VPS Messages Manually" => "updatevminfomanully" );
    return $buttonarray;
}

?>
