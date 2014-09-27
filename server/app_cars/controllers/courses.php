<?php
class Courses extends CI_Controller {
  const MODULE_NAME = 'courses';

  public function __construct() {
    parent::__construct();
    $this->load->model('course');
    check_session();
  }

  public function index(){
    $this->load->helper(array('form','zmform'));
    $data['itemlist']  = $this->course->get_course(0);
    $list =  $this->course->get_sclass(0,2);
    $countmap=array();
    foreach ($list as $item) {
        $countmap[$item["rid"]]=$item["count"];
    }
    $data["countlist"] =$countmap;
    
    show_view(self::MODULE_NAME."/list",$data); 
  }

  public function view($id){
    $this->load->helper(array('form','zmform'));

    $data['item'] = $this->course->get_course(0,$id);    
    if (empty($data['item'])) {
      show_404();
    } else {
      show_view("courses/detail",$data); 
    }
  }

  public function sclass($id) {	
    $this->load->helper(array('form','zmform'));
    $course = $this->course->get_course($id);
    if (empty($course)) {
      show_404();
    } else {
      $data["course_id"] =$id;
      $data["course_name"] =$course["name"];
      
      $data['links1'] = $this->course->get_sclass($id,0);
      $data['links2'] = $this->course->get_sclass($id,1);
      
      show_view(self::MODULE_NAME."/sclass",$data); 
    }
  }
  
  public function edit($id) {	
    $this->load->helper(array('form','zmform'));
    $data['item'] = $this->course->get_course($id);
    if (empty($data['item'])) {
      show_404();
    } else {
      //$data["schools"]= $this->course->school_list();
      show_view(self::MODULE_NAME."/edit",$data); 
    }
  }
    
  public function save($id) {	
    $this->course->save($this->input->post(),$id);
    redirect(self::MODULE_NAME);
  }
  
  public function delete($id) {	
    if ($this->input->server('REQUEST_METHOD')==="DELETE") {
      $this->course->remove($id);
      echo "OK";
      return;
    }
  }
  
  public function link($course_id) {
    $this->load->model("slink");
    $lid	= $this->input->get("lid");
    $lname = $this->input->get("lname");
    $rname = $this->input->get("rname");
    
    $action=$this->input->get("action");
    if ($action==0) { //link
      $this->slink->link(Slink::TYPE_CLASS_COURSE,$lid,$lname,$course_id,$rname);
    } else { //unlink
      $this->slink->unlink(Slink::TYPE_CLASS_COURSE,$lid,$course_id);
    }
    redirect(self::MODULE_NAME."/".$course_id."/sclass");
  }
  
  /*
   * 内容管理
   */
  public function content($id) { //课程模块管理	
    $this->load->helper(array('form','zmform'));
    $course = $this->course->get_course($id);
    if (empty($course)) {
      show_404();
    } else {
      $data["course_id"] =$id;
      $data["course_name"] =$course["name"];
      
      $data['itemlist'] = $this->course->get_content($id,0);

      $this->load->model("dic");
      $data["list1"] =$this->dic->get_select_list(Dic::DIC_TYPE_COURSE);

      show_view(self::MODULE_NAME."/content",$data); 
    }
  }
  
  public function module($id) { //课程模块班级管理	
    $this->load->helper(array('form','zmform'));
    $item=$this->course->get_content($id,1);
    if (empty($item)) {
      show_404();
    } else {      
      $data["module_id"]  =$item["id"];
      $data["module_name"]  =$item["name"];
      $data["course_id"]  =$item["course"];

      $this->load->model("slink");
      $data["class_list"] =$this->slink->llist(SLink::TYPE_CLASS_COURSE,$data["course_id"]);

      show_view(self::MODULE_NAME."/module",$data); 
    }
  }
  
  public function edit_module($id) {	
    $this->load->helper(array('form','zmform'));
    $data['item'] = $this->course->get_content($id,1);
    if (empty($data['item'])) {
      show_404();
    } else {
      $this->load->model("dic");
      $data["list1"] =$this->dic->get_select_list(Dic::DIC_TYPE_COURSE);

      show_view(self::MODULE_NAME."/edit_module",$data); 
    }
  }
  
  public function save_module($id) {
    $this->course->save_module($id);
    redirect(self::MODULE_NAME."/".$id."/content");
  }
  
  public function delete_module($id) {	
    if ($this->input->server('REQUEST_METHOD')==="DELETE") {
      $this->course->remove_module($id);
      echo "OK";
      return;
    }
  }

}