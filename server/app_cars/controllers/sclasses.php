<?php

class Sclasses extends CI_Controller {
  const MODULE_NAME = 'sclasses';
    
  public function __construct() {
    parent::__construct();
    $this->load->model('sclass');
    check_session();
  }

  public function index(){
    $this->load->helper(array('form','zmform'));
    $data['itemlist']  = $this->sclass->get_schools();
    $data['itemlist2'] = $this->sclass->get_sclass(0,0);
    
    $data["school_list"]= $this->sclass->school_select_list();
    
    show_view(self::MODULE_NAME."/list",$data); 
  }

  public function view($id){
    $this->load->helper(array('form','zmform'));

    $data['item'] = $this->sclass->get_sclass(0,$id);    
    if (empty($data['item'])) {
      show_404();
    } else {
      show_view(self::MODULE_NAME."/detail",$data); 
    }
  }

  // 成员列表和设置
  public function member($id) {	
    $this->load->helper(array('form','zmform'));
    $sclass = $this->sclass->get_sclass(0,$id);
    if (empty($sclass)) {
      show_404();
    } else {
      $data["class_id"] =$id;
      $data["class_name"] =$sclass["name"];
      
      $data["mtype_list"] =array(0=>"教师",1=>"管理员");
      
      if ($sclass["utype"]==2) { //班级，显示相关教员和学员
	$data["is_school"] = FALSE;
	$data["school_id"] =$sclass["pid"];
	$data['itemlist']  = $this->sclass->get_members($id,0);
	$data['itemlist2'] = $this->sclass->get_members($id,1);
	
      } else { //学校，显示所有教员
	$data["is_school"] = TRUE;
	$data['itemlist']  = $this->sclass->get_members($id,2);
      }
      
      show_view(self::MODULE_NAME."/member",$data); 
    }
  }
  
  // 课程列表和设置
  public function course($id) {	
    $this->load->helper(array('form','zmform'));
    $sclass = $this->sclass->get_sclass(0,$id);
    if (empty($sclass)) {
      show_404();
    } else {
      $data["class_id"] =$id;
      $data["class_name"] =$sclass["name"];
      
      // 课程设置和选择
      $data['links1'] = $this->sclass->get_courses($id,0);
      $data['links2'] = $this->sclass->get_courses($id,1);
      
      // 状态列表
      $this->load->model("dic");
      $data["status_list"]=$this->dic->get_dic_list(Dic::DIC_LESSON_STATUS);
      
      // 课程计划,id 为班级id
      $data["lesson_list"] = $this->sclass->get_courses($sclass["id"],2);
      show_view(self::MODULE_NAME."/course",$data); 
    }
  }
  
  public function edit($id) {	
    $this->load->helper(array('form','zmform'));
    $data['item'] = $this->sclass->get_sclass(0,$id);
    if (empty($data['item'])) {
      show_404();
    } else {
      $data["school_list"]= $this->sclass->school_select_list();
      show_view(self::MODULE_NAME."/edit",$data); 
    }
  }
  
  public function edit_member($id) {	
    $this->load->helper(array('form','zmform'));
    $data['item'] = $this->sclass->get_member($id);
    if (empty($data['item'])) {
      show_404();
    } else {
      show_view(self::MODULE_NAME."/edit_member",$data); 
    }
  }
  
  public function save($id) {	
    $this->sclass->save($this->input->post(),$id,2);
    redirect(self::MODULE_NAME);
  }

  public function save_school($id) {	
    $this->sclass->save($this->input->post(),$id,0);
    redirect(self::MODULE_NAME);
  }

  public function save_member($id) { //id是class_id
    $this->sclass->save_member($this->input->post(),$id);
    redirect(self::MODULE_NAME."/".$id."/member");
  }
  
  public function add_member($id) { //id是class_id
    $this->sclass->add_member($id);
    
    redirect(self::MODULE_NAME."/".$id."/member");
  }
  
  public function delete($id) {	
    if ($this->input->server('REQUEST_METHOD')==="DELETE") {
      $this->sclass->remove($id);
      echo "OK";
      return;
    }
  } 
  
  public function link($class_id) {
    $this->load->model("slink");
    $rid   = $this->input->get("rid");
    $rname = $this->input->get("rname");
    $lname = $this->input->get("lname");
    
    $action=$this->input->get("action");
    if ($action==0) { //link
      $this->slink->link(Slink::TYPE_CLASS_COURSE,$class_id,$lname,$rid,$rname);
    } else { //unlink
      $this->slink->unlink(Slink::TYPE_CLASS_COURSE,$class_id,$rid);
    }
    redirect(self::MODULE_NAME."/".$class_id."/course");
  }  

}