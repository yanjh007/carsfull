<?php
class Shops extends CI_Controller {

  public function __construct()
  {
    parent::__construct();
    $this->load->model('shop');
    check_session();
  }

  public function index(){
	$this->load->helper('form');
	
	if ($this->input->get("search")) {
	  $keyword=$this->input->get("search");
	  $data['shops'] = $this->shop->search($keyword);
	} else {
	  $data['shops'] = $this->shop->search();
	}

    $this->load->view('_common/header');
    
    show_nav(11);

    $this->load->view('shops/list', $data);

    $this->load->view('_common/footer');
  }

  public function detail($sid){
	if ($this->input->server('REQUEST_METHOD')==="DELETE") {
	  $this->shop->remove($sid);
	  echo "OK";
	  return;
	}
	
	if ($this->input->get("method") === "delete") {
	  	$this->shop->remove($sid);
		redirect('shops'); 		  
	} else if ($this->input->get("method") === "edit") {
	  $data['shop'] = $this->shop->get_shop($cid);
	  if (empty($data['shop'])) show_404();

	  $this->load->helper('form');
	
	  $this->load->view('_common/header');
	  show_nav(11);
	  
	  $this->load->view('shops/edit', $data);
	  $this->load->view('_common/footer');	  
	} else { //详情页面 
	  $data['shop'] = $this->shop->get_shop($sid);
	  if (empty($data['shop'])) show_404();

	  $this->load->helper('form');
	  $this->load->view('_common/header');
	  show_nav(11);
	  
	  $this->load->view('shops/detail', $data);
	  
	  $this->load->view('_common/footer');	  
	}
  }

  public function save() {	
	$this->shop->save($this->input->post());
	redirect('shops');
  }
  
  public function edit($sid) {	
	  $data['shop'] = $this->shop->get_shop($sid);
	  if (empty($data['shop'])) show_404();

	  $this->load->helper('form');
	
	  $this->load->view('_common/header');
	  show_nav(11);
	  
	  $this->load->view('shops/edit', $data);
	  $this->load->view('_common/footer');	  
  }
  
  public function link() {
	$shopid=$this->input->post("shop_id");
	if ($shopid) {
	  $this->shop->link($this->input->post());
	  redirect('shops/'.$shopid);
	} else {
	  redirect('shops');
	}
	
  }  

  
}