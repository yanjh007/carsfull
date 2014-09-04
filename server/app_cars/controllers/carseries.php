<?php
/*
 *
 */
class Carseries extends CI_Controller {

  public function __construct()
  {
    parent::__construct();
    $this->load->model('carserie');
    check_session();
  }

  public function index(){	
	if ($this->input->get("search")) {
	  $keyword=$this->input->get("search");
	  $data['itemlist'] = $this->carserie->search($keyword);
	} else if ($this->input->get("tag"))  {
	  $tag=$this->input->get("tag");
	  $data['itemlist'] = $this->carserie->search_tag($tag);
	} else {
	  $data['itemlist'] = $this->carserie->search();
	}

	$this->load->helper(array('form','zmform'));
    $this->load->view('_common/header');
    
    show_nav(11);

    $this->load->view('carseries/list', $data);
    $this->load->view('_common/footer');
  }

  public function view($id){	
	//详情页面 基本信息 关联和未关联任务
	  $data['item'] = $this->carserie->get_one($id);
	  if (empty($data['item'])) show_404();

	  $this->load->helper(array('form','zmform'));
	  $this->load->view('_common/header');
	  show_nav(11);
	  
	  $this->load->view('carseries/detail', $data);
	  
	  $this->load->view('_common/footer');	  
  }

  public function edit($item_id) {	
	  $data['item'] = $this->carserie->get_one($item_id);
	  if (empty($data['item'])) show_404();

	  $this->load->helper(array('form','zmform'));
	
	  $this->load->view('_common/header');
	  show_nav(11);

	  $this->load->view('carseries/edit', $data);
	  $this->load->view('_common/footer');	  
  }
  
  public function save($id) {	
	$this->carserie->save($this->input->post(),$id);
	redirect('carseries');
  }
  
  public function delete($id) {	
	if ($this->input->server('REQUEST_METHOD')==="DELETE") {
	  $this->carserie->remove($id);
	  echo "OK";
	  return;
	}
  }
  
  public function link($tgid) {
	$taskid   = $this->input->get("rid");
	$taskname = $this->input->get("rname");
	
	$this->load->model('link');
	$this->link->link(Link::TYPE_TASKGROUP_TASK,$tgid,"",$taskid,$taskname);

	if ($this->input->get("return")==1) {
	  redirect('carseries/'.$tgid."/edit");
	} else {
	  redirect('carseries/'.$tgid);
	}	
  }
  
  public function unlink($tgid) {
	$taskid   = $this->input->get("rid");
	
	$this->load->model('link');
	$this->link->unlink(Link::TYPE_TASKGROUP_TASK,$tgid,$taskid);

	if ($this->input->get("return")==1) {
	  redirect('carseries/'.$tgid."/edit");
	} else {
	  redirect('carseries/'.$tgid);
	}
  }  
}