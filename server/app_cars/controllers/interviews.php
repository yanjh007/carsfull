<?php
class Interviews extends CI_Controller {
  const MODULE_NAME = 'interviews';
  
  public function __construct()
  {
    parent::__construct();
    $this->load->model('interview');
    //check_session();
  }

  public function index(){
	$this->load->helper(array('form','zmform'));

	// 科目列表和题型列表
	//$this->load->model("interview");
    //$data["subject_list"] =$this->dic->get_slist(1,Dic::DIC_COURSE_CATA);
    //$data["qtype_list"] =$this->dic->get_slist(0,Dic::DIC_TYPE_QUESTION);
	
	$data["itvlist"] = array(11=>"iOS软件工程师",12=>"Android软件工程师",13=>"服务端软件工程师",14=>"测试运维工程师",15=>"UI/UE设计师");

	$data["userrole"] = 0;
	$data["username"] ="<未登录>";
	
	// 自定义标题头	
	$this->load->view('_common/header');   
	$this->load->view(self::MODULE_NAME."/navbar", $data);

	$this->load->view(self::MODULE_NAME."/index", $data);
	
	$footdata["jss"]=array("/assets/js/jquery.sha1.js");
	$this->load->view('_common/footer',$footdata);	
  }

  public function view($id) {
	$this->load->library('session');
	
	if ($this->input->post('contact')) { // 注册或登录
	  $user= $this->interview->get_user();
	  if ($user["flag"]==-1) { //登录失败
		redirect(self::MODULE_NAME."?status=1");
	  } 
	  $this->session->set_userdata(array("itv_user"=>$user["contact"],
										 "itv_username"=>$user["name"],
										 "itv_type"=>$user["itype"]));
   	} 

	$data["userrole"] = 10;	
	$data["username"]  = $this->session->userdata('itv_username');
	$data["user"] = $this->session->userdata('itv_user');
	$data["itype"] = $this->session->userdata('itv_type');	
	
	// 自定义标题头	
	$this->load->view('_common/header');   
	$this->load->view(self::MODULE_NAME."/navbar", $data);

	if ($id==0) { //列表和结果
	  $data["list"] =$this->interview->get_question($id,$data["itype"]);	  
	  $data["answerlist"]	= $this->interview->get_answer($id,$data["itype"],$data["user"]);

	  $this->load->view(self::MODULE_NAME."/list", $data);	  
	} else { //题目	
	  $data["item"] 	= $this->interview->get_question($id,$data["itype"]);
	  $data["answer"]	= $this->interview->get_answer($id,$data["itype"],$data["user"]);
	  
	  $this->load->helper(array('form','zmform'));
	  $this->load->view(self::MODULE_NAME."/edit", $data);	  
	}
	
	$this->load->view('_common/footer');	
  }	

  public function save($id) {
	$this->load->library('session');
	$exdata=array(
				  "user"	=> $this->session->userdata('itv_user'),
				  "itype"	=> $this->session->userdata('itv_type'),	
				  );
	
	$this->interview->save($id,$exdata);
	redirect(self::MODULE_NAME."/0/view");
  }
  
  public function commit($id) {	
	if ($this->input->server('REQUEST_METHOD')==="POST") {
	  $this->load->library('session');
	  $exdata=array(
					"user"	=> $this->session->userdata('itv_user'),
					"itype"	=> $this->session->userdata('itv_type'),	
					);
      $this->interview->commit($id,$exdata);
      echo "OK";
      return;
    }	
  }  
}