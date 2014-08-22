<?php
class Cars extends CI_Controller {

  public function __construct()
  {
    parent::__construct();
    $this->load->model('car');
    check_session();
  }

  public function index(){
	$this->load->helper(array('form','zmform'));
	
	if ($this->input->get("search")) {
	  $keyword=$this->input->get("search");
	  $data['cars'] = $this->car->search($keyword);
	} else {
	  $data['cars'] = $this->car->search();
	}

    $this->load->view('_common/header');
    
    show_nav(11);

    $this->load->view('cars/list', $data);

    $this->load->view('_common/footer');
  }

  public function detail($cid){
	if ($this->input->server('REQUEST_METHOD')==="DELETE") {
	  $this->car->remove($cid);
	  echo "OK";
	  return;
	}
	
	if ($this->input->get("method") === "delete") {
	  	$this->car->remove($cid);
		redirect('cars'); 		  
	} else if ($this->input->get("method") === "edit") {
	  $data['car'] = $this->car->get_car($cid);
	  if (empty($data['car'])) show_404();

	  $this->load->helper('form');
	
	  $this->load->view('_common/header');
	  show_nav(11);
	  
	  $this->load->view('cars/edit', $data);
	  $this->load->view('_common/footer');	  
	} else {
	  $data['car'] = $this->car->get_car($cid);
	  if (empty($data['car'])) show_404();

	  $this->load->view('_common/header');
	  show_nav(11);
	  
	  $this->load->view('cars/detail', $data);
	  $this->load->view('_common/footer');	  
	}
  }

  public function edit($id) {	
	  $data['car'] = $this->car->get_one($id);
	  if (empty($data['car'])) show_404();

	  $this->load->helper(array('form', 'zmform',"nav"));
	
	  $this->load->view('_common/header');
	  show_nav(11);
	  
	  $this->load->view('cars/edit', $data);
	  $this->load->view('_common/footer');	  
  }
  
  public function save() {	
	$this->car->save($this->input->post());
	redirect('cars');
  }  
}