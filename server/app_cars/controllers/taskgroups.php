<?php
class Taskgroups extends CI_Controller {

  public function __construct()
  {
    parent::__construct();
    $this->load->model('taskgroup');
    check_session();
  }

  public function index(){
	
	if ($this->input->get("search")) {
	  $keyword=$this->input->get("search");
	  $data['taskgroups'] = $this->taskgroup->search($keyword);
	} else {
	  $data['taskgroups'] = $this->taskgroup->search();
	}

	$this->load->helper(array('form','zmform'));

    $this->load->view('_common/header');
    
    show_nav(11);

	$data['tasks'] = $this->taskgroup->get_tasks();
    $this->load->view('taskgroups/list', $data);
    $this->load->view('_common/footer');
  }

  public function view($tgid){
	if ($this->input->server('REQUEST_METHOD')==="DELETE") {
	  $this->taskgroup->remove($tgid);
	  echo "OK";
	  return;
	}
	
	if ($this->input->get("method") === "delete") {
	  	$this->taskgroup->remove($tgid);
		redirect('taskgroups'); 		  
	} else { //详情页面 基本信息 关联和未关联任务
	  $data['taskgroup'] = $this->taskgroup->get_one($tgid);
	  if (empty($data['taskgroup'])) show_404();

	  $this->load->helper('form');
	  $this->load->view('_common/header');
	  show_nav(11);
	  
	  $data['tasks1'] = $this->taskgroup->get_tasks1($tgid);
	  $data['tasks2'] = $this->taskgroup->get_tasks2($tgid);
	  
	  $this->load->view('taskgroups/detail', $data);
	  
	  $this->load->view('_common/footer');	  
	}
  }

  public function edit($tgid) {	
	  $data['taskgroup'] = $this->taskgroup->get_one($tgid);
	  if (empty($data['taskgroup'])) show_404();

	  $this->load->helper(array('form','zmform'));
	
	  $this->load->view('_common/header');
	  show_nav(11);

	  $data['tasks1'] = $this->taskgroup->get_tasks1($tgid);
	  $data['tasks2'] = $this->taskgroup->get_tasks2($tgid);
	  
	  $this->load->view('taskgroups/edit', $data);
	  $this->load->view('_common/footer');	  
  }
  
  public function save() {	
	$this->taskgroup->save($this->input->post());
	redirect('taskgroups');
  }
  
  public function link($tgid) {
	$taskid   = $this->input->get("rid");
	$taskname = $this->input->get("rname");
	
	$this->load->model('link');
	$this->link->link(Link::TYPE_TASKGROUP_TASK,$tgid,"",$taskid,$taskname);

	if ($this->input->get("return")==1) {
	  redirect('taskgroups/'.$tgid."/edit");
	} else {
	  redirect('taskgroups/'.$tgid);
	}	
  }
  
  public function unlink($tgid) {
	$taskid   = $this->input->get("rid");
	
	$this->load->model('link');
	$this->link->unlink(Link::TYPE_TASKGROUP_TASK,$tgid,$taskid);

	if ($this->input->get("return")==1) {
	  redirect('taskgroups/'.$tgid."/edit");
	} else {
	  redirect('taskgroups/'.$tgid);
	}
  }  
}