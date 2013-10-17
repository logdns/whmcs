<?php
require_once("lib/alipay_service.class.php");
function alipay_config() {
    $configarray = array(
     "FriendlyName" => array("Type" => "System", "Value"=>"Alipay 支付宝全能接口 v1.0"),
     "T" => array("FriendlyName" => "接口模式", "Type" => "dropdown", "Options" => "1,2,3","Description" =>"支付宝接口模式:  即时到帐[1] 担保交易[2] 双功能 [3] ", ),
     "seller_email" => array("FriendlyName" => "卖家支付宝帐户", "Type" => "text", "Size" => "32","Description" => "需要申请支付宝商家集成", ),
     "partnerID" => array("FriendlyName" => "合作伙伴ID", "Type" => "text", "Size" => "18", ),
     "security_code" => array("FriendlyName" => "安全检验码", "Type" => "text", "Size" => "40", ),
     "auto_send" => array("FriendlyName" => "自动发货", "Type" => "yesno",  "Description" => "是否自动发货[需你服务器的PHP-SSL组件支持] ", ),
     "need_confirm" => array("FriendlyName" => "必须确认收货", "Type" => "yesno",  "Description" => "客户使用担保交易的话,是否确认收货才入帐 ", ),
     "logistics_fee" => array("FriendlyName" => "物流费用", "Type" => "text", "Size" => "5", "Description" => "即运费","Value"=>"0.00", ),
     "logistics_type"	=> array("FriendlyName" => "物流类型", "Type" => "dropdown", "Options" => "EXPRESS,POST,EMS", "Description" => "三个值可选：EXPRESS（快递）、POST（平邮）、EMS（EMS）",),
     "logistics_payment"	=> array("FriendlyName" => "物流支付方式", "Type" => "dropdown", "Options" => "SELLER_PAY,BUYER_PAY", "Description" => "两个值可选：SELLER_PAY（卖家承担运费）、BUYER_PAY（买家承担运费）",),
     "debug" => array("FriendlyName" => "调试模式", "Type" => "yesno", "Description" => "调试模式", ),
    );
	return $configarray;
}

function alipay_link($params) {
	#支付宝接口配置
	$need_confirm=$params['need_confirm'];
	$type=$params['T'];
	
	$alipay_config['input_charset']  = 'utf-8';
	$alipay_config['sign_type']      = "MD5";
	$alipay_config['transport']      = "http";
	$alipay_config['partner']      = $params['partnerID'];
	$alipay_config['key']          = $params['security_code'];
	$alipay_config['seller_email'] = $params['seller_email'];

	$logistics_fee		  = $params["logistics_fee"];				//物流费用，即运费。
	$logistics_type		  = $params["logistics_type"];			//物流类型，三个值可选：EXPRESS（快递）、POST（平邮）、EMS（EMS）
	$logistics_payment	= $params["logistics_payment"];	  //物流支付方式，两个值可选：SELLER_PAY（卖家承担运费）、BUYER_PAY（买家承担运费）
	$debug              = $params["debug"];

	#系统变量
	$invoiceid = $params['invoiceid'];
	$description = $params["description"];
  $amount = $params['amount']; # Format: ##.##
  $currency = $params['currency']; # Currency Code	
	$companyname = $params['companyname'];
	$systemurl = $params['systemurl'];
	$currency = $params['currency'];
	
	$alipay_config['return_url'] = $systemurl."/modules/gateways/callback/alipay_return.htm";
	$alipay_config['notify_url'] = $systemurl."/modules/gateways/callback/alipay_callback.php";
	switch ($type) {
    case "1":
        $service_name="create_direct_pay_by_user";
        break;
    case "2":
        $service_name="create_partner_trade_by_buyer";
        break;
    case "3":
        $service_name="trade_create_by_buyer";
        break;
    default:
    		return "支付宝接口配置有误";
	}
		
	
	$parameter = array(
		"service"				=> $service_name,
		"partner"			  => trim($alipay_config['partner']),
		"payment_type"	=> "1",		
		"_input_charset"=> trim(strtolower($alipay_config['input_charset'])),
    "seller_email"	=> trim($alipay_config['seller_email']),
    "return_url"		=> trim($alipay_config['return_url']),
    "notify_url"		=> trim($alipay_config['notify_url']),

		"subject"       => "$companyname 订单[ $invoiceid ]",        //商品名称，必填
		"body"          => $description,      //商品描述，必填
		"out_trade_no"  => $invoiceid,        //商品外部交易号，必填（保证唯一性）
		"price"			    => $amount,
		"quantity"		  => "1",
);
	if ($type <> "1"){
		$parameter["logistics_fee"]     =$logistics_fee;
		$parameter["logistics_type"]    =$logistics_type;
		$parameter["logistics_payment"] =$logistics_payment;
		if ($logistics_type == "POST") $parameter["t_b_rec_post"] = "3";
	}

	$alipayService = new AlipayService($alipay_config);
	$link = $alipayService->build_link($parameter);
	$img=$systemurl."/modules/gateways/lib/alipay.gif";
	$code=$link."<a href='#' onclick=\"document.forms['alipaysubmit'].submit();\"><img src='$img' alt='点击使用支付宝支付'> </a>";
	return $code;
}
?>