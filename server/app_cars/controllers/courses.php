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
    
    // 班级数量
    $list =  $this->course->get_sclass(0,2);
    $countmap=array();
    foreach ($list as $item) {
        $countmap[$item["rid"]]=$item["count"];
    }
    $data["countlist"] =$countmap;
    
    // 科目列表
    $this->load->model("dic");
    $data["ccata_list"]=$this->dic->get_select_list(Dic::DIC_COURSE_CATA);
    
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

  public function sclass($id) {	 //课程和班级的关联页面 id为课程id
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
  
  public function edit($id) { // 课程编辑
    $this->load->helper(array('form','zmform'));
    $data['item'] = $this->course->get_course($id);
    if (empty($data['item'])) {
      show_404();
    } else {
      // 科目列表
      $this->load->model("dic");
      $data["ccata_list"]=$this->dic->get_select_list(Dic::DIC_COURSE_CATA);

      show_view(self::MODULE_NAME."/edit",$data); 
    }
  }
    
  public function save($id) { // 课程保存
    $this->course->save($this->input->post(),$id);
    redirect(self::MODULE_NAME);
  }
  
  public function delete($id) {	 //课程删除
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
   * 课程计划管理
   */
  public function plan($id) { //课程内容和模块管理	
    $this->load->helper(array('form','zmform'));
    $course = $this->course->get_course($id);
    if (empty($course)) {
      show_404();
    } else {
      $data["course_id"] =$id;
      $data["course_name"] =$course["name"];
      
      $data['itemlist'] = $this->course->get_content($id,0);

      // 模块课程状态列表
      $data["sclass_list"] =$this->course->get_sclass($id,10);
      
      // 模块类型
      $this->load->model("dic");
      $data["mtype_list"] =$this->dic->get_select_list(Dic::DIC_TYPE_COURSE);

      show_view(self::MODULE_NAME."/plan",$data); 
    }
  }
  
  public function lesson($id) { //课堂管理	
    $this->load->helper(array("form","zmform","date"));
    $item=$this->course->get_content($id,1);
    if (empty($item)) {
      show_404();
    } else {      
      $data["module_id"]  =$item["id"];
      $data["module_name"]  =$item["name"];
      $data["course_id"]  =$item["course"];

      // 状态列表
      $this->load->model("dic");
      $data["status_list"]=$this->dic->get_select_list(Dic::DIC_LESSON_STATUS);

      // 班级列表
      $this->load->model("slink");
      $data["class_list"] =$this->slink->llist(SLink::TYPE_CLASS_COURSE,$data["course_id"]);

      // 课程列表
      $stime=(now()+2*86400)/60;
      $etime=$stime+60;
      
      $data["new_lesson"]  = array("id"=>0,
				   "stime"=>$stime,
				   "etime"=>$etime,
				   "lcode"=>$data["module_name"],
				   "status"=>0);
      $data["lesson_list"] = $this->course->get_content($id,2);
      
      show_view(self::MODULE_NAME."/lesson",$data); 
    }
  }
  
  public function edit_plan($id) {	
    $this->load->helper(array('form','zmform'));
    $data['item'] = $this->course->get_content($id,1);
    if (empty($data['item'])) {
      show_404();
    } else {
      $this->load->model("dic");
      $data["mtype_list"] =$this->dic->get_select_list(Dic::DIC_TYPE_COURSE);
      $content=$data["item"]["content"];
      $json=json_decode($content,true);
      
      //var_dump($json);
      
      if ($json && $json["content"]) {
        $data["list"] = $json["content"];
        //$data["contentlist"] = $content;
      } else {
        $data["list"] = array();
        $data["contentlist"] = "";
      }
      show_view(self::MODULE_NAME."/edit_plan",$data); 
    }
  }
  
  public function save_module($id) {
    $this->course->save_module($id);
    redirect(self::MODULE_NAME."/".$id."/content");
  }
  
  public function save_content($id) { //id 为 moduleid
    $this->course->save_content($id);
    redirect(self::MODULE_NAME."/".$id."/edit_plan");
  }

  public function remove_content($id) { //id 为 moduleid
    $this->course->remove_content($id);
    redirect(self::MODULE_NAME."/".$id."/edit_plan");
  }
  
  public function delete_module($id) {	
    if ($this->input->server('REQUEST_METHOD')==="DELETE") {
      $this->course->remove_module($id);
      echo "OK";
      return;
    }
  }
    
  /*
   * 课堂管理
   */
  public function save_lesson($id) { //课堂保存 id为模块id
    $this->load->helper('date');
    $course_id=$this->input->post("course_id");
    $this->course->save_lesson($id);
    redirect(self::MODULE_NAME."/".$course_id."/content");
  }
  
  
  /*
   * 课堂报表
   */
  public function report($id) { //课堂报告 id为课堂id
    $this->load->helper(array('form','zmform'));
    $data['item'] = $this->course->get_content($id,1);
    if (empty($data['item'])) {
      show_404();
    } else {
      $this->load->model("dic");
      $data["mtype_list"] =$this->dic->get_select_list(Dic::DIC_TYPE_COURSE);

      show_view(self::MODULE_NAME."/edit_module",$data); 
    }
  }
  
    /*
   * 课堂日志
   */
  public function log($id) {//课堂报告 id为课堂id或者课程id
    $this->load->helper(array('form','zmform'));
    $data= $this->course->get_logs($id,$this->input->get());
    
    show_view(self::MODULE_NAME."/logs",$data); 
  }
  

}