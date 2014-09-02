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
	  case "apmts": //预约
		$this->_apmt();
	    return;
	  case "shops": //预约
		$this->_shop();
	    return;
	  default:
		  $data["result"] = "FALSE";
		  $data["content"] = json_encode(array("status"=>404,"error"=>"Request Not Found"));
		  $this->load->view('service/json_std', $data);
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
		
		$this->load->model('zmsession');
		
		$this->load->model('client','',TRUE);
		$client= $this->client->get_by_login($login);
		if ($client) { //有记录，验证密码和Device
		  if ($client["passwd"]==$passwd) {
			$token = $this->zmsession->save(Zmsession::SESSION_TYPE_CLIENT,$login,$device,$this->input->ip_address());
			$data["content"] = json_encode(array("status"=>2,"token"=>$token,"cid"=>$client["id"]));
		  } else {
			$data["result"] = "FALSE";
			$data["content"] = json_encode(array("status"=>21,"error"=>"密码错误"));
		  }
		} else { //无记录，新用户
		  $this->client->add($login,$passwd,$device);
		  $token = $this->zmsession->save(Zmsession::SESSION_TYPE_CLIENT,$login,$device,$this->input->ip_address());
		  $cid= $this->client->get_id_by_login($login);
		  $data["content"] = json_encode(array("status"=>1,"token"=>$token,"cid"=>$cid));
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
		  $this->load->model('zmsession');	
		  $token = $this->zmsession->save(Zmsession::SESSION_TYPE_CLIENT,$login,$device,$this->input->ip_address());
		  $cid= $this->client->get_id_by_login($login);
		  
		  $data["content"] = json_encode(array("status"=>3,"token"=>$token,"cid"=>$cid));
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

  /*
   * 提交 S,I,C(待审核预约列表)
   * 返回 R,C(审核确认列表，包括确认和改期,审核取消列表)
   */
  public function _apmt() { //预约服务接口
	if (!$this->_tokenCheck()) return;
	
	
	$content = $this->input->get_post('C');
	$client  = $this->input->get_post('U');
	
	$this->load->model('appointment');
	$data = $this->appointment->onSubmit($content,$client);	  
	$this->load->view('service/json_std', $data);
  }
  
  public function _shop() { //店铺信息同步接口
	//if (!$this->_tokenCheck()) return;
	
	$this->load->model('shop');
	$version = $this->input->get_post('V');

	$data = $this->shop->onSubmit($version);	  
	$this->load->view('service/json_std', $data);
  }
  
  function _tokenCheck() {
	$token  = $this->input->get_post('S');
	$device = $this->input->get_post('I');
	$user   = $this->input->get_post('U');
	
	if ($token!=NULL && strlen($token)>0) {
	  $this->load->model('zmsession');	
	  $token.= $this->zmsession->hex_ip($this->input->ip_address());
	  
	  if ($this->zmsession->is_valid_token($token,$user,$device)) {
		return TRUE;
	  } else {
		$check = "无效的Token";
	  }  
	} else {
	  $check="无效的请求或数据";
	}

	$data["result"] = "FALSE";
	$data["content"] = json_encode(array("status"=>25,"error"=>$check));
	$this->load->view('service/json_std', $data);
	return FALSE;	
  }
}