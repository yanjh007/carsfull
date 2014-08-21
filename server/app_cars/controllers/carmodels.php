<?php
class Carmodels extends CI_Controller {

  public function __construct()
  {
    parent::__construct();
    $this->load->model('carmodel');
    check_session();
  }

  public function index(){
	
	if ($this->input->get("search")) {
	  $keyword=$this->input->get("search");
	  $data['carmodels'] = $this->carmodel->search($keyword);
	} else {
	  $data['carmodels'] = $this->carmodel->search();
	}

	$this->load->helper(array('form','zmform'));

    $this->load->view('_common/header');
    
    show_nav(11);

    $this->load->view('carmodels/list', $data);
    $this->load->view('_common/footer');
  }

  public function view($tgid){
	if ($this->input->server('REQUEST_METHOD')==="DELETE") {
	  $this->carmodel->remove($tgid);
	  echo "OK";
	  return;
	}
	
	if ($this->input->get("method") === "delete") {
	  	$this->carmodel->remove($tgid);
		redirect('carmodels'); 		  
	} else { //详情页面 基本信息 关联和未关联任务
	  $data['carmodel'] = $this->carmodel->get_one($tgid);
	  if (empty($data['carmodel'])) show_404();

	  $this->load->helper(array('form','zmform'));
	  $this->load->view('_common/header');
	  show_nav(11);
	  
	  $this->load->view('carmodels/detail', $data);
	  
	  $this->load->view('_common/footer');	  
	}
  }

  public function edit($item_id) {	
	  $data['carmodel'] = $this->carmodel->get_one($item_id);
	  if (empty($data['carmodel'])) show_404();

	  $this->load->helper(array('form','zmform'));
	
	  $this->load->view('_common/header');
	  show_nav(11);

	  $this->load->view('carmodels/edit', $data);
	  $this->load->view('_common/footer');	  
  }
  
  public function save() {	
	$this->carmodel->save($this->input->post());
	redirect('carmodels');
  }
  
  public function link($tgid) {
	$taskid   = $this->input->get("rid");
	$taskname = $this->input->get("rname");
	
	$this->load->model('link');
	$this->link->link(Link::TYPE_TASKGROUP_TASK,$tgid,"",$taskid,$taskname);

	if ($this->input->get("return")==1) {
	  redirect('carmodels/'.$tgid."/edit");
	} else {
	  redirect('carmodels/'.$tgid);
	}	
  }
  
  public function unlink($tgid) {
	$taskid   = $this->input->get("rid");
	
	$this->load->model('link');
	$this->link->unlink(Link::TYPE_TASKGROUP_TASK,$tgid,$taskid);

	if ($this->input->get("return")==1) {
	  redirect('carmodels/'.$tgid."/edit");
	} else {
	  redirect('carmodels/'.$tgid);
	}
  }  
}