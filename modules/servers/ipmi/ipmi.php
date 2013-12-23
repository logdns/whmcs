<?php
//save as [whmcs]/modules/servers/ipmi/ipmi.php
function ipmi_ClientArea($params) {
// Output can be returned like this, or defined via a clientarea.tpl ipmi file (see docs for more info)
$ipmiip = $params['customfields']["ipmiip"];
$ipmiuser = $params['customfields']["ipmiuser"];
$ipmipass = $params['customfields']["ipmipass"];
$cmd="ipmitool -H $ipmiip -U $ipmiuser -P $ipmipass -I lanplus power status";
$power=substr(exec($cmd),17);
$p="https://$ipmiip/";
$code = "机器电源状态: $power  用户名:$ipmiuser 密码:$ipmipass <a href=\"$p\" target=\"_blank\" style=\"color:#cc0000\">登陆到IPMI页面</a>";
return $code;
}
function ipmi_AdminLink($params) {
$ipmiip = $params['customfields']["ipmiip"];
$ipmiuser = $params['customfields']["ipmiuser"];
$ipmipass = $params['customfields']["ipmipass"];
$i=explode(".",$ipmiip);
$p="https://$ipmiip/";
$code = "<a href=\"$p\" target=\"_blank\" style=\"color:#cc0000\">登陆到IPMI页面</a>";
return $code;
}
function ipmi_reboot($params) {
$ipmiip = $params['customfields']["ipmiip"];
$ipmiuser = $params['customfields']["ipmiuser"];
$ipmipass = $params['customfields']["ipmipass"];
$cmd="ipmitool -H $ipmiip -U $ipmiuser -P $ipmipass -I lanplus power reset";
$return=exec($cmd);
if ($return=="") $return = "success";
return $return;
}
function ipmi_off($params) {
$ipmiip = $params['customfields']["ipmiip"];
$ipmiuser = $params['customfields']["ipmiuser"];
$ipmipass = $params['customfields']["ipmipass"];
$cmd="ipmitool -H $ipmiip -U $ipmiuser -P $ipmipass -I lanplus power off";
$return=exec($cmd);
if ($return=="") $return = "success";
return $return;
}
function ipmi_on($params) {
$ipmiip = $params['customfields']["ipmiip"];
$ipmiuser = $params['customfields']["ipmiuser"];
$ipmipass = $params['customfields']["ipmipass"];
$cmd="ipmitool -H $ipmiip -U $ipmiuser -P $ipmipass -I lanplus power on";
$return=exec($cmd);
if ($return=="") $return = "success";
return $return;
}
function ipmi_cycle($params) {
$ipmiip = $params['customfields']["ipmiip"];
$ipmiuser = $params['customfields']["ipmiuser"];
$ipmipass = $params['customfields']["ipmipass"];
$cmd="ipmitool -H $ipmiip -U user -P $pass -I lanplus power cycle";
$return=exec($cmd);
if ($return=="") $return = "success";
return $return;
}
function ipmi_ClientAreaCustomButtonArray() {
$buttonarray = array(
"重启RESET" => "reboot",
"电源重置POWER_CYCLE" => "cycle",
"电源关闭POWER_OFF" => "off",
"电源开启POWER_ON" => "on",
);
return $buttonarray;
}
function ipmi_AdminCustomButtonArray() {
$buttonarray = array(
"重启RESET" => "reboot",
"电源重置POWER_CYCLE" => "cycle",
"电源关闭POWER_OFF" => "off",
"电源开启POWER_ON" => "on",
);
return $buttonarray;
}
?>