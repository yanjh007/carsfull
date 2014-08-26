<?php
class Service extends CI_Controller {
  public function __construct()
  {
    parent::__construct();
  }

  public function index() {
	switch ($this->input->get_post("M")) {
	  case "login"://正常登录和绑定
		$this->_login();
	    return;
	  case "getcode": //获取验证码
		$this->_getcode();
	    return;
	  case "recover": //重置密码
		$this->_recover();
	    return;
	  default:
		$this->load->helper('date');
		$data["server_time"] = now();
	    $data["error"]="bad request";
		$this->load->view('service/json_false', $data);	
	}	
  }
  
  
  
  public function crypt() {
    	if ($method) {
	  $content = str_replace(" ","+",$content); //

	  // 加解密库
	  $this->load->library('encrypt');
	  //$this->encrypt->set_cipher(MCRYPT_RIJNDAEL_128);
	  $this->encrypt->set_mode(MCRYPT_MODE_ECB);
	  
	  $this->load->helper('date');
	  
	  $key = mdate("%Y%m%d", now());
	  $key = substr($this->encrypt->sha1($key),0,32);
	  
	  //$original = $this->encrypt->decode(base64_decode($content),$key);
	  	  
	  // 解密方式
	  $iv_size = mcrypt_get_iv_size(MCRYPT_RIJNDAEL_128, MCRYPT_MODE_ECB);
	  $iv = mcrypt_create_iv($iv_size, MCRYPT_RAND);
	  $original = trim(mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $key, base64_decode($content), MCRYPT_MODE_ECB));
	  $original = utf8_encode(rtrim($original, "\x03"));
	  
	  log_message("error","内容:".$content);
	  log_message("error","key:".$key.",decode:".$original);
	  
	  $json = json_decode($original);
	  
	  if ($json) {
	    $data["content"]= "\"".$json->method."\""; //$original;
	    $this->load->view('service/json_ok', $data);
	    exit;
	  } else {
	    $data["error"]="data format error";	
	  }
	} else {
	  $data["error"]="bad request";	  
	}
  }

  // 登录接口 login，getcode,recover
  /* 登录接口状态
   * 1-新用户创建并登录 2-已有用户正常登录 3-密码验证恢复登录
   * 11-新用户通知 12-已有用户生成验证码 13　
   * 21－密码错误 22-提交错误 23-验证码错误
  
  */
  public function _login() { //client登录服务 客户端提交sha1(password)+username 服务器响应session和错误
	$hash  = $this->input->get_post('H');
	if ($hash) { // Post
   		$login    = substr($hash,40);
		$passwd   = substr($hash,0,40);
		$device= $this->input->get_post('I');
		
		$this->load->model('client','',TRUE);
		$client= $this->client->get_by_login($login);
		if ($client) { //有记录，验证密码和Device
		  if ($client["passwd"]==$passwd) {
			$data["content"] = json_encode(array("status"=>2));
		  } else {
			$data["result"] = "FALSE";
			$data["content"] = json_encode(array("status"=>21,"error"=>"密码错误"));
		  }
		} else { //无记录，新用户
		  $this->client->add($login,$passwd,$device);
		  $data["content"] = json_encode(array("status"=>1));
		}	  
	} else {
	  $data["result"] = "FALSE";
	  $data["content"] = json_encode(array("status"=>22,"error"=>"数据交付格式错误"));
	}
	$this->load->view('service/json_std', $data);
  }
  
  public function _getcode() { //密码恢复
	$login  = $this->input->get_post('login');
	if ($login) { // Post
		$device= $this->input->get_post('I');
		
		$this->load->model('client','',TRUE);
		$vcode= $this->client->gen_vcode($login);
		if ($vcode>0) { //有记录，生成验证码
		  $data["content"] = json_encode(array("status"=>12,"vcode"=>$vcode));
		} else { //无记录，可能是新用户
		  $data["content"] = json_encode(array("status"=>11));
		}	  
	} else {
	  $data["result"]="FALSE"; //数据交付格式错误
	  $data["content"] = json_encode(array("status"=>22,"error"=>"数据提交格式错误"));
	}
	$this->load->view('service/json_std', $data);
  }
  
  public function _recover() { //密码恢复
	$hash  = $this->input->get_post('H');
	if ($hash) { // Post
		$passwd   = substr($hash,0,40);
   		$vcode    = substr($hash,40,6);
		$login    = substr($hash,46);
		$device= $this->input->get_post('I');
		//var_dump($passwd."-".$vcode."-".$login);
		
		$this->load->model('client','',TRUE);
		$r=$this->client->vsave($login,$passwd,$vcode) ;
		if ($r==10) { //正常验证，保存
		  $data["content"] = json_encode(array("status"=>3));
		} else if ($r==1) { //验证码匹配错误
		  $data["result"]="FALSE"; 
		  $data["content"] = json_encode(array("status"=>23,"error"=>"验证码错误"));		  
		} else if ($r==2) { //验证码超时错误
		  $data["result"]="FALSE"; 
		  $data["content"] = json_encode(array("status"=>24,"error"=>"验证码过期"));		  
		} else { //其他错误
		  $data["result"]="FALSE"; 
		  $data["content"] = json_encode(array("status"=>29,"error"=>"未知错误"));		  
		}
	} else {
	  $data["result"]="FALSE"; //数据交付格式错误
	  $data["content"] = json_encode(array("status"=>22,"error"=>"数据提交格式错误"));
	}
	$this->load->view('service/json_std', $data);
  }

  public function login1() { //登录服务 客户端提交sha1(password)+username 服务器响应session和错误
	$this->load->helper('date');
	$data["server_time"] = now();

	$hash  = $this->input->get_post('hash');
	$device= $this->input->get_post('deviceid');
	if ($hash) { // Post
		$this->load->model('zmsession');
   		$username    = substr($hash,41);
		$sessiontype = substr($hash,40,1);
		
		if ($sessiontype==="0") {
		  $this->load->model('client','',TRUE); //加载客户模型
		  $password = $this->client->get_passwd_by_login($username);
		  //var_dump($sessiontype."-".$username."-".$password);
		  if ($password == substr($hash,0,40)) { //验证成功
			  $data["session"] = $this->zmsession->save("0",$username,$device,$this->input->ip_address());
			  $this->load->view('service/login_ok', $data);
			  return TRUE;
		  }
		} else if ($sessiontype==="1") {
		  $this->load->model('user','',TRUE); //加载用户模型
		  $user = $this->user->get_user_by_login($username);
		  if ($user) {
			  $password = substr($hash,0,40);
			  if ($password == $user->passwd) { //验证成功
				  $data["session"] = $this->zmsession->save("0",$username,$device,$this->input->ip_address());
				  $this->load->view('service/login_ok', $data);
				  return TRUE;
			  }
		}
		  
		}
		$data["error"]="用户名或密码错误"; 
	} else {
	  $data["error"]="数据格式错误";  
	}
	
	$this->load->view('service/login_false', $data);
  }

  public function verify() { //登录验证 客户端提交session 服务器响应session是否正确和过期
	$this->load->helper('date');
	$data["server_time"] = now();

	$hash=$this->input->get_post('hash');
	if ($hash) { // Post
		$this->load->model('zmsession');	
		$hash.= $this->zmsession->hex_ip($this->input->ip_address());
		
		if ($this->zmsession->is_valid($hash)) {		  
		  $this->load->view('service/verify_ok', $data);
		  return TRUE;
		} else {
		  $data["error"]="无有效记录"; 
		}
	} else {
	  $data["error"]="数据格式错误";  
	}
	
	$this->load->view('service/verify_false', $data);	
  }  

  public function client($action="") { //客户服务接口
	if ($action=="login") {
	  echo "Login OK";	  
	} else {
	  echo "OK";	  
	}
  }
  
  public function user($action) { //客户服务接口


  }

}