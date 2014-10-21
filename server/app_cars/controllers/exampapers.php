<?php
class Exampapers extends CI_Controller {
  const MODULE_NAME = 'exampapers';
  
  public function __construct()
  {
    parent::__construct();
    $this->load->model('exampaper');
    check_session();
	log_message('error', 'Exampltasktype module:'.$_SERVER['REQUEST_URI']);
  }

  public function index(){
	$this->load->helper(array('form','zmform'));
	if ($this->input->get("filter")) {
	  $filter=$this->input->get("filter");
	  if ($filter==1) { //暂存
		$data['list'] = $this->question->search(1);
	  } else { //科目
		$keyword=$this->input->get("keyword");
		$data['list'] = $this->question->search(2,$keyword);
	  }	  
	} else {
	  $data['list'] = $this->question->search(0);
	}

    show_view(self::MODULE_NAME."/list",$data); 
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

  public function edit($id) {	
	  $data['item'] = $this->question->get_one($id);
	  if (empty($data['item'])) {
		show_404();
	  } else {
		$this->load->helper(array('form','zmform'));
		show_view(self::MODULE_NAME."/edit",$data);   		
	  }
  }
  
  public function save($id) {
	$this->question->save($id,$this->input->post());
	redirect(self::MODULE_NAME);
  }
  
  public function fav($id) {
	$this->question->fav($id,$this->input->get("flag"));
	redirect(self::MODULE_NAME);
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