<?php
class Settings extends CI_Controller {
  const MODULE_NAME = 'settings';
  
  public function __construct()
  {
    parent::__construct();
    $this->load->model('zmmeta');
    check_session();
  }

  public function index(){
    $this->load->helper(array('form','zmform'));
    
    //共享密码 
    $data['share_pwd']  	= $this->zmmeta->get_meta("mkey_share_pwd");
 
    //资源目录
    $data['resource_path'] 	= $this->zmmeta->get_meta("mkey_resource_path");
    
    //选择测试
    $data["checked_value"]	= $this->zmmeta->get_meta("mkey_checks");
    $data["checked_list"]	=array("A"=>"选项A","B"=>"选项B","C"=>"选项C","D"=>"选项D");

    //$data["checked_list"]	=array("A"=>"选项A","B"=>"选项B","C"=>"选项C","D"=>"选项D");
    
    
    show_view(self::MODULE_NAME."/list",$data); 
  }

  public function save($id) {
    //var_dump($this->input->post());
    if ($id==1) { //共享密码
      $value=$this->input->post("mvalue");
      $this->zmmeta->set_meta("mkey_share_pwd",$value);
    } else if ($id==2) {
      $value=$this->input->post("mvalue");
      $this->zmmeta->set_meta("mkey_resource_path",$value);
    } else if ($id==3) {
      $list=$this->input->post("mvalue");
      $value="";
      foreach($list as $item) {
	if ($value=="") {
	  $value=$item;
	} else {
	  $value.=",".$item;
	}
      }
      
      $this->zmmeta->set_meta("mkey_checks",$value);
    }  
    
    redirect(self::MODULE_NAME);
  }  
}