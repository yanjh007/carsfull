<?php
class Courses extends CI_Controller {
  public function __construct() {
    parent::__construct();
    $this->load->model('course');
    check_session();
  }

  public function index(){
    $this->load->helper(array('form','zmform'));
    $data['itemlist'] = $this->course->get_course(0);
//    $data["school"] = 0;
//    $data["schools"]= $this->course->school_list();
    
    show_view("courses/list",$data); 
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

  public function member($id) {	
    $this->load->helper(array('form','zmform'));
    $course = $this->course->get_course(0,$id);
    if (empty($course)) {
      show_404();
    } else {
      $data["class_id"] =$id;
      $data["class_name"] =$course["name"];
      
      $data['itemlist']  = $this->course->get_members($id,0);
      $data['itemlist2'] = $this->course->get_members($id,1);
      
      show_view("courses/member",$data); 
    }
  }
  
  public function edit($id) {	
    $this->load->helper(array('form','zmform'));
    $data['item'] = $this->course->get_course($id);
    if (empty($data['item'])) {
      show_404();
    } else {
      //$data["schools"]= $this->course->school_list();
      show_view("courses/edit",$data); 
    }
  }
  
  public function edit_member($id) {	
    $this->load->helper(array('form','zmform'));
    $data['item'] = $this->course->get_member($id);
    if (empty($data['item'])) {
      show_404();
    } else {
      show_view("courses/edit_member",$data); 
    }
  }
  
  public function save($id) {	
    $this->course->save($this->input->post(),$id);
    redirect('courses');
  }

  
  public function delete($id) {	
    if ($this->input->server('REQUEST_METHOD')==="DELETE") {
      $this->course->remove($id);
      echo "OK";
      return;
    }
  }
  
  public function link() {
	$courseid=$this->input->post("course_id");
	if ($courseid) {
	  $this->course->link($this->input->post());
	  redirect('courses/'.$courseid);
	} else {
	  redirect('courses');
	}	
  }  

}