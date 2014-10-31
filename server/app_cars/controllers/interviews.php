<?php
class Interviews extends CI_Controller {
  const MODULE_NAME = 'interviews';
  const TIME_EXAM=60;
  
  public function __construct()
  {
    parent::__construct();
    $this->load->model('interview');
	$this->load->library('session');
    //check_session();
  }
  
  private static function _examarray() {
	  return array(11=>"iOS软件工程师",12=>"Android软件工程师",13=>"服务端软件工程师",14=>"测试运维工程师",15=>"UI/UE设计师");
  }

  public function index(){
	if ($this->input->post('contact')) { // Postback 注册或登录
	  $user= $this->interview->get_user();
	  if ($user["flag"]==-1) { //登录失败
		$this->session->unset_userdata("itv_user");
		redirect(self::MODULE_NAME."?status=1");
	  }

	  if ($user["contact"]=="13808077242") { //设置管理员
		$userrole = 100;		  
	  } else {
		$userrole = $user["flag"]; //	
	  }
	  
	  $this->session->set_userdata(array("itv_user"=>$user["contact"],
										 "itv_username"=>$user["name"],
										 "itv_userrole"=>$userrole,
										 "itv_type"=>$user["itype"],
										 "itv_timeleft"=>round($user["itime"]-time()/60+self::TIME_EXAM)));
	  
   	} 

	$data["user"] = $this->session->userdata('itv_user');
	
	$this->load->helper(array('form','zmform'));
	if ($data["user"]) {
	  $data["userrole"] = $this->session->userdata('itv_userrole');
	  $data["username"]  = $this->session->userdata('itv_username');
	  $data["itype"] = $this->session->userdata('itv_type');	

		  // 自定义标题头	
	  $this->load->view('_common/header');   
	  
	  $data["timeleft"] = $this->session->userdata('itv_timeleft');
	  $this->load->view(self::MODULE_NAME."/navbar", $data);
  
	  if  ($data["userrole"] ==100) {
		  $data["showmode"]=0;
		  $data["list"] =$this->interview->get_review(0,0);	    
		  $this->load->view(self::MODULE_NAME."/review", $data);
	  
	  } elseif ($data["userrole"] ==1) { //答题中		  
		  $data["list"] =$this->interview->get_question(0,$data["itype"]);	  
		  $data["answerlist"]	= $this->interview->get_answer(0,$data["itype"],$data["user"]);
	
		  $this->load->view(self::MODULE_NAME."/list", $data);	  
	  }	else { //状态查询
		  $data["examtitle"] = $this->_examarray()[$data["itype"]];
		  $data["statuslist"] = array(1=>"进行中",2=>"已提交,未批复",3=>"已批复");
		  $data["status"]=$this->interview->get_status($data["itype"],$data["user"]);
		  $this->load->view(self::MODULE_NAME."/check", $data);	  
	  }
	  $this->load->view('_common/footer');	

	} else { //显示登录
	  $this->_showLogin();
	}
  }
  
  private function _showLogin() {
	  $data["itvlist"] = array(11=>"iOS软件工程师",12=>"Android软件工程师",13=>"服务端软件工程师",14=>"测试运维工程师",15=>"UI/UE设计师");
  
	  $data["userrole"] = 0;
	  $data["username"] ="<未登录>";
	  $data["status"]=$this->input->get("status");
	  
	  // 自定义标题头	
	  $this->load->view('_common/header');   
	  $this->load->view(self::MODULE_NAME."/navbar", $data);
  
	  $this->load->view(self::MODULE_NAME."/index", $data);
	  
	  $footdata["jss"]=array("/assets/js/jquery.sha1.js");
	  $this->load->view('_common/footer',$footdata);		  	
  }
  
  public function logout() {
	  $this->session->unset_userdata("itv_user");
	  redirect(self::MODULE_NAME."?status=0");
  }
  
  public function answer($params) {
	$data["user"] = $this->session->userdata('itv_user');
	if (!$data["user"]) redirect(self::MODULE_NAME."?status=2");
	
	$data["userrole"] = $this->session->userdata('itv_userrole');
	$data["username"]  = $this->session->userdata('itv_username');
	$data["itype"] = $this->session->userdata('itv_type');	
	$data["timeleft"] = $this->session->userdata('itv_timeleft');	

	$plist=explode(ZM_URL_SPLIT_CHAR,$params);
	$qorder=$plist[0];
	
	$this->load->helper(array('form','zmform'));
		// 自定义标题头	
	$this->load->view('_common/header');   
	$this->load->view(self::MODULE_NAME."/navbar", $data);
  
	$data["item"] 	= $this->interview->get_question($qorder,$data["itype"]);
	$data["answer"]	= $this->interview->get_answer($qorder,$data["itype"],$data["user"]);
	
	$this->load->view(self::MODULE_NAME."/edit", $data);	  
	$this->load->view('_common/footer');	
  }

  public function save() {
	$this->load->library('session');
	$exdata=array(
				  "user"	=> $this->session->userdata('itv_user'),
				  "itype"	=> $this->session->userdata('itv_type'),
				  "next"    => $this->input->post("gonext")
				  );
	
	$nid= $this->interview->save($exdata);
	if ($nid==0) {
	  redirect(self::MODULE_NAME);
	} else {
	  redirect(self::MODULE_NAME."/answer/".$nid);
	}
	
  }
  
  public function commit() { //提交 ajax response
	if ($this->input->server('REQUEST_METHOD')==="POST") {
	  $this->load->library('session');
	  $exdata=array(
					"user"	=> $this->session->userdata('itv_user'),
					"itype"	=> $this->session->userdata('itv_type'),	
					);
      $this->interview->commit($exdata);
	  $this->session->set_userdata("itv_userrole",2);
      echo "OK";
      return;
    }	
  }
  
  public function review($params) {
	$data["user"] = $this->session->userdata('itv_user');
	if (!$data["user"]) redirect(self::MODULE_NAME."?status=2");
	$data["userrole"] = $this->session->userdata('itv_userrole');
	
	if (!$data["userrole"]||$data["userrole"]!=100) redirect(self::MODULE_NAME."?status=3");	
	$data["username"] = $this->session->userdata('itv_username');

	$plist=explode(ZM_URL_SPLIT_CHAR,$params);
	$itype	 = $plist[0];
	$contact = $plist[1];
  
	// 显示评估页面
	$data["showmode"] =1;	
	$data["contact"]=$contact;
	$data["itype"]=$itype;
	
	// 题目列表
	$data["list"] =$this->interview->get_question(0,$itype);

	// 解答列表
	$data["answerlist"] =$this->interview->get_answer(0,$itype,$contact);;	  
	// 答题状态
	$data["status"] =$this->interview->get_status($itype,$contact);;	  
	
	
	// 自定义标题头	
	$this->load->helper(array('form','zmform'));
	$this->load->view('_common/header');   
	$this->load->view(self::MODULE_NAME."/navbar", $data);

	$this->load->view(self::MODULE_NAME."/review", $data);
	
	$this->load->view('_common/footer');		
  }
  
  public function review_commit() { //提交批覆结果, id为exam
	$nid= $this->interview->review_commit();
	redirect(self::MODULE_NAME);
  }
}