<?php
class Tasktypes extends CI_Controller {

  public function __construct()
  {
    parent::__construct();
    $this->load->model('tasktype');
    check_session();
	log_message('error', 'tasktype module:'.$_SERVER['REQUEST_URI']);
  }

  public function index(){
	$this->load->helper(array('form','zmform'));
	if ($this->input->get("search")) {
	  $keyword=$this->input->get("search");
	  $data['tasktypes'] = $this->tasktype->search($keyword);
	} else {
	  $data['tasktypes'] = $this->tasktype->search();
	}

    $this->load->view('_common/header');
    
    show_nav(11);

    $this->load->view('tasktypes/list', $data);

    $this->load->view('_common/footer');
  }

  public function view($tid){
	if ($this->input->server('REQUEST_METHOD')==="DELETE") { // AJAX
	  log_message('error', 'ajax delete:'.$tid);
	  $this->tasktype->remove($tid);
	  
	  echo "OK";
	  return;
	}
	
	if ($this->input->get("method") === "delete") {
	  	$this->tasktype->remove($tid);
		redirect('tasktypes'); 		  
	} else { //详情页面 基本信息 车辆信息
	  $data['tasktype'] = $this->tasktype->get_one($tid);
	  if (empty($data['tasktype'])) show_404();

	  $this->load->helper(array('form','zmform'));
	  $this->load->view('_common/header');
	  show_nav(11);
	  
	  $data['cars'] = $this->tasktype->get_one($tid);
	  $this->load->view('tasktypes/detail', $data);
	  
	  $this->load->view('_common/footer');	  
	}
  }

  public function edit($tid) {	
	  $data['tasktype'] = $this->tasktype->get_one($tid);
	  if (empty($data['tasktype'])) show_404();

	  $this->load->helper(array('form', 'zmform',"nav"));
	
	  $this->load->view('_common/header');
	  show_nav(11);
	  
	  $this->load->view('tasktypes/edit', $data);
	  $this->load->view('_common/footer');	  
  }
  
  public function save() {	
	$this->tasktype->save($this->input->post());
	redirect('tasktypes');
  }
  
  public function link() {
	$userid=$this->input->post("tasktype_id");
	if ($userid) {
	  $this->tasktype->link($this->input->post());
	  redirect('tasktypes/'.$tasktypeid);
	} else {
	  redirect('tasktypes');
	}	
  } 
  
}