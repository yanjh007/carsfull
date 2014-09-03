<?php
class Appointments extends CI_Controller {
  const ATYPE_CAR  = 0; //预约类型，修车
  const ATYPE_METAL= 1; //预约类型，订餐
  
  public function __construct()
  {
    parent::__construct();
    $this->load->model('appointment');
    check_session();
  }

  public function index(){
	
	if ($this->input->get("search")) {
	  $keyword=$this->input->get("search");
	  $data['appointments'] = $this->appointment->search($keyword);
	} else {
	  $data['appointments'] = $this->appointment->search();
	}

	$this->load->helper(array('form','zmform'));

    $this->load->view('_common/header');
    
    show_nav(11);

    $data["status_desc"] = array(1=>"待处理",2=>"已确认",3=>"已取消");
    $this->load->view('appointments/list', $data);

    $this->load->view('_common/footer');
  }
  
  public function filter(){
    $filter=$this->input->get("r");

    $data['appointments'] = $this->appointment->filter($filter);

    $this->load->helper(array('form','zmform'));

    $this->load->view('_common/header');
    
    show_nav(11);

    $this->load->view('appointments/list', $data);

    $this->load->view('_common/footer');
  }

  public function detail($sid){
      //详情页面 
      $data['appointment'] = $this->appointment->get_one($sid);
      if (empty($data['appointment'])) show_404();

      $this->load->helper('form');
      $this->load->view('_common/header');
      show_nav(11);
      
      $this->load->view('appointments/detail', $data);
      
      $this->load->view('_common/footer');	  
 }

  public function save() {	
	$this->appointment->save($this->input->post());
	redirect('appointments');
  }
  
  public function edit($sid) {	
      $data['appointment'] = $this->appointment->get_appointment($sid);
      if (empty($data['appointment'])) show_404();

      $this->load->helper('form');
    
      $this->load->view('_common/header');
      show_nav(11);
      
      $this->load->view('appointments/edit', $data);
      $this->load->view('_common/footer');	  
  }
  

  // ajax delete
  public function jdelete($id) {	
      if ($this->input->server('REQUEST_METHOD')==="DELETE") {
	$this->appointment->remove($id);
	echo "OK";
      }	  
  }  
  
  // ajax confirm
  public function jconfirm($id) {	
      if ($this->input->server('REQUEST_METHOD')==="POST") {
	$note= $this->input->post("note");
	$this->appointment->confirm($id,2,$note);
	echo "OK";
      }	  
  }  

  // ajax cancel
  public function jcancel($id) {	
      if ($this->input->server('REQUEST_METHOD')==="POST") {
	$note= $this->input->post("note");
	$this->appointment->confirm($id,3,$note);
	echo "OK";
      }	  
  }  
  
  
}