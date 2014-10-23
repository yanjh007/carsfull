<?php
class Questions extends CI_Controller {
  const MODULE_NAME = 'questions';
  
  public function __construct()
  {
    parent::__construct();
    $this->load->model('question');
    check_session();
	log_message('error', 'tasktype module:'.$_SERVER['REQUEST_URI']);
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

	// 科目列表和题型列表
	$this->load->model("dic");
    $data["subject_list"] =$this->dic->get_slist(1,Dic::DIC_COURSE_CATA);
    $data["qtype_list"] =$this->dic->get_slist(0,Dic::DIC_TYPE_QUESTION);

    show_view(self::MODULE_NAME."/list",$data); 
  }

  public function edit($id) {	
	  $data['item'] = $this->question->get_one($id);
	  if (empty($data['item'])) {
		show_404();
	  } else {
		$this->load->helper(array('form','zmform'));

		// 科目列表和题型列表
		$this->load->model("dic");
		$data["subject_list"] =$this->dic->get_slist(1,Dic::DIC_COURSE_CATA);
		$data["qtype_list"] =$this->dic->get_slist(0,Dic::DIC_TYPE_QUESTION);

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