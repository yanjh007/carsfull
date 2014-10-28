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
    $data["subj_list"]=$this->dic->get_slist(1,Dic::DIC_COURSE_CATA);
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
      $data["ccata_list"]=$this->dic->get_slist(1,Dic::DIC_COURSE_CATA);

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
      
      $data["mtype_list"] =$this->dic->get_slist(0,Dic::DIC_TYPE_COURSE);
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
      $data["status_list"]=$this->dic->get_slist(0,Dic::DIC_LESSON_STATUS);

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
      
      // 内容类型列表
      $data["ctype_list"] =$this->dic->get_slist(0,Dic::DIC_TYPE_CONTENT);
      
      // 科目列表
      $data["subject_list"] =$this->dic->get_slist(1,Dic::DIC_COURSE_CATA);

      // 考试类型列表
      $data["qtype_list"] =$this->dic->get_slist(0,Dic::DIC_TYPE_QUESTION);
      
      //内容项目列表      
      $data["contentlist"] = $this->course->get_content($id,3);
      show_view(self::MODULE_NAME."/edit_plan",$data); 
    }
  }
  
  public function save_module($id) {
    $this->course->save_module($id);
    redirect(self::MODULE_NAME."/".$id."/plan");
  }
  
  public function add_lib($id) { //从题库添加 id 为 moduleid
    $this->course->add_lib($id);
    redirect(self::MODULE_NAME."/".$id."/edit_plan");
  }

  public function add_section($id) {  //测试分隔 id 为 moduleid
    $this->course->add_section($id);
    redirect(self::MODULE_NAME."/".$id."/edit_plan");
  }

  public function add_content($id) { //常规内容 id 为 moduleid
    $this->course->add_content($id);
    redirect(self::MODULE_NAME."/".$id."/edit_plan");
  }
  
  public function add_question($id) { //题目 id 为 moduleid
    $this->course->add_question($id);
    redirect(self::MODULE_NAME."/".$id."/edit_plan");
  }

  public function remove_content($id) { //id 为 moduleid
    $this->course->remove_content($id,$this->input->get("order"));
    redirect(self::MODULE_NAME."/".$id."/edit_plan");
  }
  
  public function pub_content($id) { //发布课堂内容，id 为 moduleid
    $this->course->pub_content($id);
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
  public function report($id) { //课堂报告 id为内容模块id
    $this->load->helper(array('form','zmform'));
    $data['item'] = $this->course->get_content($id,1);
    if (empty($data['item'])) {
      show_404();
    } else {
      // 班级
      $sclass_id=$this->input->get("sclass");
      $data["sclass_id"]=$sclass_id;
      
      //课程课堂
      $data["module_id"]=$id;
      
      // 题目列表
      $data["contentlist"] = $this->course->get_content($id,4);
      
      // 学生列表
      $this->load->model("sclass");
      $data["studentlist"] = $this->sclass->get_members($sclass_id,1);

      // 得分数组
      $score_ary=array();
      $status_ary=array();
      $this->load->model("sreport");
      $ary_score=$this->sreport->get_score_ary($sclass_id,$id);

      foreach ($ary_score as $item) {
        $score_ary [$item["uid"]][$item["qorder"]]=$item["score"];
        $status_ary[$item["uid"]][$item["qorder"]]=$item["status"];
      }
      
      $data["score_ary"]=$score_ary;
      $data["status_ary"]=$status_ary;
      
      
      show_view(self::MODULE_NAME."/report",$data); 
    }
  }
  
    /*
   * 课堂报表
   */
  public function review($id) { //课堂报告 id为内容模块id
    $this->load->helper(array('form','zmform'));
    
    $data["sclass_id"] = $this->input->get("sclass") ;
    $data["module_id"] = $id;
    $data["module"] = $this->course->get_content($id,1); //课堂内容
    $data["qorder"] = $this->input->get("order") ;
    
    $data["uid"] = $this->input->get("uid") ;
        
    $this->load->helper(array('form','zmform'));
    if ($data["uid"]==0) { //显示所有学生答题
      $data['list'] = $this->course->get_content($id,5);
      show_view(self::MODULE_NAME."/review0",$data); 
    } else { //显示特定学生答案
      $data['item'] = $this->course->get_content($id,5);
      show_view(self::MODULE_NAME."/review",$data); 
    }    
  }
  
  // 保存评分和Review
  public function save_review($id) { //课堂报告 id为内容模块id
    $sclass=$this->input->post("sclass");
    
    $this->course->save_review($id);
    
    //重定向
    redirect(self::MODULE_NAME."/".$id."/report?sclass=".$sclass);
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