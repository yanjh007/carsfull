<?php
class Service extends CI_Controller {
  public function __construct()
  { parent::__construct(); }

  public function index() {
      switch ($this->input->get_post("M")) {
	  // 登录接口 login，getcode,recover
	  /* 登录接口状态
	   * 1-新用户创建并登录 2-已有用户正常登录 3-密码验证恢复登录
	   * 11-新用户通知 12-已有用户生成验证码 13　
	   * 21－密码错误 22-提交错误 23-验证码错误
	  */
	  case "login":////client登录服务 客户端提交sha1(password)+username 服务器响应session和错误
	      $this->load->model("client");
	      $data=$this->client->if_login();
	      break;
	  case "getcode": //获取验证码
	      $this->load->model("client");
	      $data=$this->client->if_getcode();
	      break;
	  case "recover": //重置密码
	      $this->load->model("client");
	      $data=$this->client->if_recover();
	      break;
	  case "apmts": //预约
	      $this->_apmt();
	      return;
	  case "shops": //预约
	      $this->load->model('shop');
	      $version = $this->input->get_post('V');
      
	      $data = $this->shop->onSubmit($version);	  
	      break;
	  case "carseries": //车型
	      $this->load->model('carserie');
	      $tag = $this->input->get_post('K');      
	      $data = $this->carserie->if_tag($tag);	  
	      break;
	  default:
	      $data["result"] = "FALSE";
	      $data["content"] = json_encode(array("status"=>404,"error"=>"Request Not Found"));
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