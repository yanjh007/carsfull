<?php
class Service extends CI_Controller {
  public function __construct()
  {
    parent::__construct();
  }

  public function login() { //登录服务 客户端提交sha1(password)+username 服务器响应session和错误
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