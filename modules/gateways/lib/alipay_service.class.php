<?php

class AlipayService {
	var $alipay_config;
	var $alipay_gateway_new = 'https://mapi.alipay.com/gateway.do?';
	var $debug;
	function __construct($alipay_config){
		$this->alipay_config = $alipay_config;
	}

  function AlipayService($alipay_config) {
   	$this->__construct($alipay_config);
  }

	function build_link($para_temp) {
		$button_name = "确认";
		$alipaySubmit = new AlipaySubmit();
		$html_text = $alipaySubmit->buildForm($para_temp, $this->alipay_gateway_new, "get", $button_name,$this->alipay_config);
		return $html_text;
	}

	function send_goods_confirm_by_platform($para_temp) {
		$alipaySubmit = new AlipaySubmit();
		$html_text = $alipaySubmit->sendPostInfo($para_temp, $this->alipay_gateway_new, $this->alipay_config);
		return $html_text;
	}
	
	function query_timestamp() {
		$url = $this->alipay_gateway_new."service=query_timestamp&partner=".trim($this->alipay_config['partner']);
		$encrypt_key = "";
		$doc = new DOMDocument();
		$doc->load($url);
		$itemEncrypt_key = $doc->getElementsByTagName( "encrypt_key" );
		$encrypt_key = $itemEncrypt_key->item(0)->nodeValue;
		return $encrypt_key;
	}
	
	function alipay_interface($para_temp) {
		$alipaySubmit = new AlipaySubmit();
		$html_text = "";
		//请根据不同的接口特性，选择一种请求方式
		//1.构造表单提交HTML数据:（$method可赋值为get或post）
		//$alipaySubmit->buildForm($para_temp, $this->alipay_gateway, "get", $button_name,$this->alipay_config);
		//2.构造模拟远程HTTP的POST请求，获取支付宝的返回XML处理结果:
		//注意：若要使用远程HTTP获取数据，必须开通SSL服务，该服务请找到php.ini配置文件设置开启，建议与您的网络管理员联系解决。
		//$alipaySubmit->sendPostInfo($para_temp, $this->alipay_gateway, $this->alipay_config);
		return $html_text;
	}
}

class AlipayNotify {
    /**
     * HTTPS形式消息验证地址
     */
	var $https_verify_url = 'https://mapi.alipay.com/gateway.do?service=notify_verify&';
	/**
     * HTTP形式消息验证地址
     */
	var $http_verify_url = 'http://notify.alipay.com/trade/notify_query.do?';
	var $alipay_config;

	function __construct($alipay_config){
		$this->alipay_config = $alipay_config;
	}
    function AlipayNotify($alipay_config) {
    	$this->__construct($alipay_config);
    }
    /**
     * 针对notify_url验证消息是否是支付宝发出的合法消息
     * @return 验证结果
     */
	function verifyNotify(){
		if(empty($_POST)) {//判断POST来的数组是否为空
			return false;
		}
		else {
			//logResult("a   ".$_POST["notify_id"]);
			//生成签名结果
			$mysign = $this->getMysign($_POST);
			//获取支付宝远程服务器ATN结果（验证是否是支付宝发来的消息）
			$responseTxt = 'true';
			if (! empty($_POST["notify_id"])) {$responseTxt = $this->getResponse($_POST["notify_id"]);}
			
			//写日志记录
			//$log_text = "responseTxt=".$responseTxt."\n notify_url_log:sign=".$_POST["sign"]."&mysign=".$mysign.",";
			//$log_text = $log_text.createLinkString($_POST);
			//logResult($log_text);
			
			//验证
			//$responsetTxt的结果不是true，与服务器设置问题、合作身份者ID、notify_id一分钟失效有关
			//mysign与sign不等，与安全校验码、请求时的参数格式（如：带自定义参数等）、编码格式有关
			if (preg_match("/true$/i",$responseTxt) && $mysign == $_POST["sign"]) {
				return true;
			} else {
				return false;
			}
		}
	}
	
    /**
     * 针对return_url验证消息是否是支付宝发出的合法消息
     * @return 验证结果
     */
	function verifyReturn(){
		if(empty($_GET)) {//判断POST来的数组是否为空
			return false;
		}
		else {
			//生成签名结果
			$mysign = $this->getMysign($_GET);
			//获取支付宝远程服务器ATN结果（验证是否是支付宝发来的消息）
			$responseTxt = 'true';
			if (! empty($_GET["notify_id"])) {$responseTxt = $this->getResponse($_GET["notify_id"]);}
			
			//写日志记录
			//$log_text = "responseTxt=".$responseTxt."\n notify_url_log:sign=".$_GET["sign"]."&mysign=".$mysign.",";
			//$log_text = $log_text.createLinkString($_GET);
			//logResult($log_text);
			
			//验证
			//$responsetTxt的结果不是true，与服务器设置问题、合作身份者ID、notify_id一分钟失效有关
			//mysign与sign不等，与安全校验码、请求时的参数格式（如：带自定义参数等）、编码格式有关
			if (preg_match("/true$/i",$responseTxt) && $mysign == $_GET["sign"]) {
				return true;
			} else {
				return false;
			}
		}
	}
	
    /**
     * 根据反馈回来的信息，生成签名结果
     * @param $para_temp 通知返回来的参数数组
     * @return 生成的签名结果
     */
	function getMysign($para_temp) {
		//除去待签名参数数组中的空值和签名参数
		$para_filter = paraFilter($para_temp);
		
		//对待签名参数数组排序
		$para_sort = argSort($para_filter);
		
		//生成签名结果
		$mysign = buildMysign($para_sort, trim($this->alipay_config['key']), strtoupper(trim($this->alipay_config['sign_type'])));
		
		return $mysign;
	}

    /**
     * 获取远程服务器ATN结果,验证返回URL
     * @param $notify_id 通知校验ID
     * @return 服务器ATN结果
     * 验证结果集：
     * invalid命令参数不对 出现这个错误，请检测返回处理中partner和key是否为空 
     * true 返回正确信息
     * false 请检查防火墙或者是服务器阻止端口问题以及验证时间是否超过一分钟
     */
	function getResponse($notify_id) {
		$transport = strtolower(trim($this->alipay_config['transport']));
		$partner = trim($this->alipay_config['partner']);
		$veryfy_url = '';
		if($transport == 'https') {
			$veryfy_url = $this->https_verify_url;
		}
		else {
			$veryfy_url = $this->http_verify_url;
		}
		$veryfy_url = $veryfy_url."partner=" . $partner . "&notify_id=" . $notify_id;
		$responseTxt = getHttpResponse($veryfy_url);
		
		return $responseTxt;
	}
}

class AlipaySubmit {
	function buildRequestPara($para_temp,$alipay_config) {
		$para_filter = paraFilter($para_temp);
		$para_sort = argSort($para_filter);
		$mysign = buildMysign($para_sort, trim($alipay_config['key']), strtoupper(trim($alipay_config['sign_type'])));
		$para_sort['sign'] = $mysign;
		$para_sort['sign_type'] = strtoupper(trim($alipay_config['sign_type']));
		return $para_sort;
	}

	function buildRequestParaToString($para_temp,$alipay_config) {
		$para = $this->buildRequestPara($para_temp,$alipay_config);
		$request_data = createLinkstringUrlencode($para);
		return $request_data;
	}

	function buildForm($para_temp, $gateway, $method, $button_name, $alipay_config) {
		$para = $this->buildRequestPara($para_temp,$alipay_config);
		$sHtml = "<form id='alipaysubmit' name='alipaysubmit' action='".$gateway."_input_charset=".trim(strtolower($alipay_config['input_charset']))."' method='".$method."'>";
		while (list ($key, $val) = each ($para)) {
            $sHtml.= "<input type='hidden' name='".$key."' value='".$val."'/>";
        }
  //$sHtml = $sHtml."<input type='submit' value='".$button_name."'></form>";
	//$sHtml = $sHtml."<script>document.forms['alipaysubmit'].submit();</script>";
		return $sHtml;
	}
	
	function sendPostInfo($para_temp, $gateway, $alipay_config) {
		$xml_str = '';
		$request_data = $this->buildRequestParaToString($para_temp,$alipay_config);
		$url = $gateway . $request_data;
		$xml_data = getHttpResponse($url,trim(strtolower($alipay_config['input_charset'])));
		$doc = new DOMDocument();
		$doc->loadXML($xml_data);
		return $doc;
	}
}

function buildMysign($sort_para,$key,$sign_type = "MD5") {
	//把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
	$prestr = createLinkstring($sort_para);
	//把拼接后的字符串再与安全校验码直接连接起来
	$prestr = $prestr.$key;
	//把最终的字符串签名，获得签名结果
	$mysgin = sign($prestr,$sign_type);
	return $mysgin;
}

function createLinkstring($para) {
	$arg  = "";
	while (list ($key, $val) = each ($para)) {
		$arg.=$key."=".$val."&";
	}
	//去掉最后一个&字符
	$arg = substr($arg,0,count($arg)-2);
	
	//如果存在转义字符，那么去掉转义
	if(get_magic_quotes_gpc()){$arg = stripslashes($arg);}
	
	return $arg;
}

function createLinkstringUrlencode($para) {
	$arg  = "";
	while (list ($key, $val) = each ($para)) {
		$arg.=$key."=".urlencode($val)."&";
	}
	//去掉最后一个&字符
	$arg = substr($arg,0,count($arg)-2);
	
	//如果存在转义字符，那么去掉转义
	if(get_magic_quotes_gpc()){$arg = stripslashes($arg);}
	
	return $arg;
}

function paraFilter($para) {
	$para_filter = array();
	while (list ($key, $val) = each ($para)) {
		if($key == "sign" || $key == "sign_type" || $val == "")continue;
		else	$para_filter[$key] = $para[$key];
	}
	return $para_filter;
}

function argSort($para) {
	ksort($para);
	reset($para);
	return $para;
}

function sign($prestr,$sign_type='MD5') {
	$sign='';
	if($sign_type == 'MD5') {
		$sign = md5($prestr);
	}elseif($sign_type =='DSA') {
		//DSA 签名方法待后续开发
		die("DSA 签名方法待后续开发，请先使用MD5签名方式");
	}else {
		die("支付宝暂不支持".$sign_type."类型的签名方式");
	}
	return $sign;
}

function logResult($word='') {
	$fp = fopen("log.txt","a");
	flock($fp, LOCK_EX) ;
	fwrite($fp,"执行日期：".strftime("%Y%m%d%H%M%S",time())."\n".$word."\n");
	flock($fp, LOCK_UN);
	fclose($fp);
}

function getHttpResponse($url, $input_charset = '', $time_out = "60") {
	//logResult($url);
	$urlarr     = parse_url($url);
	$errno      = "";
	$errstr     = "";
	$transports = "";
	$responseText = "";
	if($urlarr["scheme"] == "https") {
		$transports = "ssl://";
		$urlarr["port"] = "443";
	} else {
		$transports = "tcp://";
		$urlarr["port"] = "80";
	}
	$fp=@fsockopen($transports . $urlarr['host'],$urlarr['port'],$errno,$errstr,$time_out);
	if(!$fp) {
		//logResult("ERROR: $errno - $errstr<br />\n");
		die("ERROR: $errno - $errstr<br />\n");
	} else {
		if (trim($input_charset) == '') {
			fputs($fp, "POST ".$urlarr["path"]." HTTP/1.1\r\n");
		}
		else {
			fputs($fp, "POST ".$urlarr["path"].'?_input_charset='.$input_charset." HTTP/1.1\r\n");
		}
		fputs($fp, "Host: ".$urlarr["host"]."\r\n");
		fputs($fp, "Content-type: application/x-www-form-urlencoded\r\n");
		fputs($fp, "Content-length: ".strlen($urlarr["query"])."\r\n");
		fputs($fp, "Connection: close\r\n\r\n");
		fputs($fp, $urlarr["query"] . "\r\n\r\n");
		while(!feof($fp)) {
			$responseText .= @fgets($fp, 1024);
		}
		fclose($fp);
		$responseText = trim(stristr($responseText,"\r\n\r\n"),"\r\n");
		//logResult($responseText);
		return $responseText;
	}
}

function charsetEncode($input,$_output_charset ,$_input_charset) {
	$output = "";
	if(!isset($_output_charset) )$_output_charset  = $_input_charset;
	if($_input_charset == $_output_charset || $input ==null ) {
		$output = $input;
	} elseif (function_exists("mb_convert_encoding")) {
		$output = mb_convert_encoding($input,$_output_charset,$_input_charset);
	} elseif(function_exists("iconv")) {
		$output = iconv($_input_charset,$_output_charset,$input);
	} else die("sorry, you have no libs support for charset change.");
	return $output;
}

function charsetDecode($input,$_input_charset ,$_output_charset) {
	$output = "";
	if(!isset($_input_charset) )$_input_charset  = $_input_charset ;
	if($_input_charset == $_output_charset || $input ==null ) {
		$output = $input;
	} elseif (function_exists("mb_convert_encoding")) {
		$output = mb_convert_encoding($input,$_output_charset,$_input_charset);
	} elseif(function_exists("iconv")) {
		$output = iconv($_input_charset,$_output_charset,$input);
	} else die("sorry, you have no libs support for charset changes.");
	return $output;
}
?>